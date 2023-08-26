import 'dart:io';

import 'package:jfullinfo/jfullinfo.dart';
import 'package:jfullinfo/src/_src.dart';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';
import 'package:win32_registry/win32_registry.dart';

///[JFullInfoWindows] The root class for jfullinfo Windows Implementation Plugin
///
/// has a [Future] method called [getOsInformation] has [JWindowsInfo] return type.
///
/// has a [Future] method called [getApplicationInformation] has [JApplicationInfoWindows] return type.
///
/// has a [Future] method called [getAllInformation] has [JFullInfoWindowsModel] return type.
///
/// has a [Future] method called [getSimInformation] has [List] of [JSimInfo] return type.
class JFullInfoWindows extends JFullInfo {
  JWindowsInfo? _winfocache;
  // ignore: non_constant_identifier_names
  void Function(Pointer<OSVERSIONINFOEX>) RtlGetVersion =
      DynamicLibrary.open('ntdll.dll').lookupFunction<
          Void Function(Pointer<OSVERSIONINFOEX>),
          void Function(Pointer<OSVERSIONINFOEX>)>('RtlGetVersion');

  /// [Future] method called [getOsInformation] has [JWindowsInfo] return type.
  @override
  Future<JWindowsInfo> getOsInformation() async {
    try {
      final v = Future.value(_winfocache ??= _getWindowsInfo());
      return v;
    } catch (e) {
      return JWindowsInfo();
    }
  }

  ///[Future] method called [getApplicationInformation] has [JApplicationInfoWindows] return type.
  @override
  Future<JApplicationInfoWindows> getApplicationInformation() async {
    JApplicationInfoWindows applicationInfo = JApplicationInfoWindows();
    try {
      String resolvedExecutable = Platform.resolvedExecutable;
      if (resolvedExecutable.startsWith(r"UNC\")) {
        resolvedExecutable = resolvedExecutable.replaceFirst(r"UNC\", r"\\");
      }
      final info = _FileVersionInfo(resolvedExecutable);
      final versions = info.productVersion.split('+');
      final data = {
        "appName": info.productName,
        "packageName": info.internalName,
        "version": versions.getOrNull(0) ?? '',
        "buildNumber": versions.getOrNull(1) ?? '',
      };
      info.dispose();
      final v = Future.value(JApplicationInfoWindows.fromMap(data));
      return v;
    } catch (e) {
      return applicationInfo;
    }
  }

  ///[Future] method called [getAllInformation] has [JFullInfoWindowsModel] return type.
  @override
  Future<JFullInfoWindowsModel> getAllInformation() async {
    try {
      final sInfo = await getOsInformation();
      final aInfo = await getApplicationInformation();
      final data = {
        "windowsInfo": sInfo.toString(),
        "appInfo": aInfo.toString(),
      };
      final v = Future.value(JFullInfoWindowsModel.fromMap(data));
      return v;
    } catch (e) {
      return JFullInfoWindowsModel();
    }
  }

  @override
  Future<List<JSimInfo>> getSimInformation() async =>
      throw UnimplementedError('getSimInformation() has not been implemented.');

  JWindowsInfo _getWindowsInfo() {
    final systemInfo = calloc<SYSTEM_INFO>();
    final osVersionInfo = calloc<OSVERSIONINFOEX>()
      ..ref.dwOSVersionInfoSize = sizeOf<OSVERSIONINFOEX>();

    try {
      final currentVersionKey = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Microsoft\Windows NT\CurrentVersion');
      final displayVersion =
          currentVersionKey.getValueAsString('DisplayVersion') ?? '';
      final installDate = DateTime.fromMillisecondsSinceEpoch(
          1000 * (currentVersionKey.getValueAsInt('InstallDate') ?? 0));
      final productId = currentVersionKey.getValueAsString('ProductID') ?? '';
      var productName = currentVersionKey.getValueAsString('ProductName') ?? '';
      final registeredOwner =
          currentVersionKey.getValueAsString('RegisteredOwner') ?? '';
      final releaseId = currentVersionKey.getValueAsString('ReleaseId') ?? '';

      final sqmClientKey = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Microsoft\SQMClient');
      final machineId = sqmClientKey.getValueAsString('MachineId') ?? '';
      GetSystemInfo(systemInfo);
      RtlGetVersion(osVersionInfo);
      if (osVersionInfo.ref.dwBuildNumber >= 22000) {
        productName = productName.replaceAll('10', '11');
      }
      final data = {
        "pcName": _getComputerName(),
        "userName": _getUserName(),
        "buildNumber": osVersionInfo.ref.dwBuildNumber,
        "platformId": osVersionInfo.ref.dwPlatformId,
        "productName": productName,
        "productId": productId,
        "releaseId": releaseId,
        "installDate": installDate,
        "owner": registeredOwner,
        "cores": systemInfo.ref.dwNumberOfProcessors,
        "memorySize": _getSystemMemoryInMegabytes(),
        "deviceId": machineId,
        "displayVersion": displayVersion,
      };
      return JWindowsInfo.fromMap(data);
    } finally {
      free(systemInfo);
      free(osVersionInfo);
    }
  }

  int _getSystemMemoryInMegabytes() {
    final memoryInKilobytes = calloc<ULONGLONG>();
    try {
      final result = GetPhysicallyInstalledSystemMemory(memoryInKilobytes);
      if (result != 0) {
        return memoryInKilobytes.value ~/ 1024;
      } else {
        final error = GetLastError();
        throw WindowsException(HRESULT_FROM_WIN32(error));
      }
    } finally {
      free(memoryInKilobytes);
    }
  }

  String _getComputerName() {
    // We call this a first time to get the length of the string in characters,
    // so we can allocate sufficient memory.
    final nSize = calloc<DWORD>();
    GetComputerNameEx(
        COMPUTER_NAME_FORMAT.ComputerNameDnsFullyQualified, nullptr, nSize);

    // Now allocate memory for a native string and call this a second time.
    final lpBuffer = wsalloc(nSize.value);
    try {
      final result = GetComputerNameEx(
          COMPUTER_NAME_FORMAT.ComputerNameDnsFullyQualified, lpBuffer, nSize);

      if (result != 0) {
        return lpBuffer.toDartString();
      } else {
        throw WindowsException(HRESULT_FROM_WIN32(GetLastError()));
      }
    } finally {
      free(lpBuffer);
      free(nSize);
    }
  }

  String _getUserName() {
    const maxLength = 256;
    final lpBuffer = wsalloc(maxLength + 1);
    final pcbBuffer = calloc<DWORD>()..value = maxLength + 1;
    try {
      final result = GetUserName(lpBuffer, pcbBuffer);
      if (result != 0) {
        return lpBuffer.toDartString();
      } else {
        throw WindowsException(HRESULT_FROM_WIN32(GetLastError()));
      }
    } finally {
      free(pcbBuffer);
      free(lpBuffer);
    }
  }
}

extension _GetOrNull<T> on List<T> {
  T? getOrNull(int index) => _checkIndex(index) ? this[index] : null;

  bool _checkIndex(int index) => index >= 0 && index < length;
}

final class LANGANDCODEPAGE extends Struct {
  @WORD()
  external int wLanguage;

  @WORD()
  external int wCodePage;
}

class _FileInfoWin {
  const _FileInfoWin({required this.lpBlock, required this.lpLang});
  final Pointer<BYTE> lpBlock;
  final Pointer<LANGANDCODEPAGE> lpLang;
}

class _FileVersionInfo {
  final String filePath;
  final _FileInfoWin _data;
  _FileVersionInfo(this.filePath) : _data = _getData(filePath);
  void dispose() => free(_data.lpBlock);

  String get productName => getValue('ProductName');
  String get internalName => getValue('InternalName');
  String get productVersion => getValue('ProductVersion');

  String getValue(String name) {
    final langCodepages = [
      // try the language and codepage from the EXE
      [_data.lpLang.ref.wLanguage, _data.lpLang.ref.wCodePage],
      // try the default language and codepage from the EXE
      [GetUserDefaultLangID(), _data.lpLang.ref.wCodePage],
      // try the language from the EXE and Latin codepage (most common)
      [_data.lpLang.ref.wLanguage, 1252],
      // try the default language and Latin codepage (most common)
      [GetUserDefaultLangID(), 1252],
    ];

    final lplpBuffer = calloc<LPWSTR>();
    final puLen = calloc<UINT>();
    String toHex4(int val) => val.toRadixString(16).padLeft(4, '0');

    try {
      for (final langCodepage in langCodepages) {
        final lang = toHex4(langCodepage[0]);
        final codepage = toHex4(langCodepage[1]);
        final lpSubBlock = TEXT('\\StringFileInfo\\$lang$codepage\\$name');
        final res =
            VerQueryValue(_data.lpBlock, lpSubBlock, lplpBuffer.cast(), puLen);
        free(lpSubBlock);

        if (res != 0 && lplpBuffer.address != 0 && puLen.value > 0) {
          return lplpBuffer.value.toDartString();
        }
      }
      return '';
    } finally {
      free(lplpBuffer);
      free(puLen);
    }
  }

  static _FileInfoWin _getData(String filePath) {
    if (!File(filePath).existsSync()) {
      throw ArgumentError.value(filePath, 'filePath', 'File not present');
    }

    final lptstrFilename = TEXT(filePath);
    final dwLen = GetFileVersionInfoSize(lptstrFilename, nullptr);

    final lpData = calloc<BYTE>(dwLen); // freed by the dispose() method
    final lpSubBlock = TEXT(r'\VarFileInfo\Translation');
    final lpTranslate = calloc<Pointer<LANGANDCODEPAGE>>();
    final puLen = calloc<UINT>();
    try {
      if (GetFileVersionInfo(lptstrFilename, NULL, dwLen, lpData) == 0) {
        throw WindowsException(HRESULT_FROM_WIN32(GetLastError()));
      }

      if (VerQueryValue(lpData, lpSubBlock, lpTranslate.cast(), puLen) == 0) {
        throw WindowsException(HRESULT_FROM_WIN32(GetLastError()));
      }
      return _FileInfoWin(lpBlock: lpData, lpLang: lpTranslate.value);
    } finally {
      free(lptstrFilename);
      free(lpTranslate);
      free(lpSubBlock);
      free(puLen);
    }
  }
}
