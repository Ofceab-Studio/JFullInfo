import 'dart:convert';
import 'dart:io' as io;
import 'package:jfullinfo/jfullinfo.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:jfullinfo/src/_src.dart';
import 'package:path/path.dart' as path;

///[JFullInfoLinux] The root class for jfullinfo Linux Implementation Plugin
///
/// has a [Future] method called [getOsInformation] has [JLinuxInfo] return type.
///
/// has a [Future] method called [getApplicationInformation] has [JApplicationInfoLinux] return type.
///
/// has a [Future] method called [getAllInformation] has [JFullInfoLinuxModel] return type.
///
/// has a [Future] method called [getSimInformation] has [List] of [JSimInfo] return type.
class JFullInfoLinux extends JFullInfo {
  JLinuxInfo? _linuxcache;
  final FileSystem _fileSystem = const LocalFileSystem();

  /// [Future] method called [getOsInformation] has [JLinuxInfo] return type.
  @override
  Future<JLinuxInfo> getOsInformation() async {
    try {
      final v = _linuxcache ??= await _getLinuxInfo();
      return v;
    } catch (e) {
      return JLinuxInfo();
    }
  }

  ///[Future] method called [getApplicationInformation] has [JApplicationInfoLinux] return type.
  @override
  Future<JApplicationInfoLinux> getApplicationInformation() async {
    try {
      final versionJson = await _getVersionJson();
      final data = {
        "appName": versionJson['app_name'] ?? '',
        "packageName": versionJson['package_name'] ?? '',
        "version": versionJson['version'] ?? '',
        "buildNumber": versionJson['build_number'] ?? '',
      };
      return JApplicationInfoLinux.fromMap(data);
    } catch (e) {
      return JApplicationInfoLinux();
    }
  }

  ///[Future] method called [getAllInformation] has [JFullInfoLinuxModel] return type.
  @override
  Future<JFullInfoLinuxModel> getAllInformation() async {
    try {
      final sInfo = await getOsInformation();
      final aInfo = await getApplicationInformation();
      final data = {
        "linuxInfo": sInfo.toString(),
        "appInfo": aInfo.toString(),
      };

      return JFullInfoLinuxModel.fromMap(data);
    } catch (e) {
      return JFullInfoLinuxModel();
    }
  }

  @override
  Future<List<JSimInfo>> getSimInformation() async =>
      throw UnimplementedError('getSimInformation() has not been implemented.');

  Future<Map<String, dynamic>> _getVersionJson() async {
    try {
      final exePath = await io.File('/proc/self/exe').resolveSymbolicLinks();
      final appPath = path.dirname(exePath);
      final assetPath = path.join(appPath, 'data', 'flutter_assets');
      final versionPath = path.join(assetPath, 'version.json');
      return jsonDecode(await io.File(versionPath).readAsString());
    } catch (_) {
      return <String, dynamic>{};
    }
  }

  Future<JLinuxInfo> _getLinuxInfo() async {
    final os = await _getOsRelease() ?? {};
    final lsb = await _getLsbRelease() ?? {};
    final machineId = await _getMachineId();
    final data = {
      "name": os['NAME'] ?? 'Linux',
      "version": os['VERSION'] ?? lsb['LSB_VERSION'],
      "idLike": os['ID_LIKE']?.split(' '),
      "id": os['ID'] ?? lsb['DISTRIB_ID'] ?? 'linux',
      "versionCodeName": os['VERSION_CODENAME'] ?? lsb['DISTRIB_CODENAME'],
      "versionId": os['VERSION_ID'] ?? lsb['DISTRIB_RELEASE'],
      "prettyName": os['PRETTY_NAME'] ?? lsb['DISTRIB_DESCRIPTION'] ?? 'Linux',
      "buildId": os['BUILD_ID'],
      "variant": os['VARIANT'],
      "variantId": os['VARIANT_ID'],
      "deviceId": machineId,
    };
    return JLinuxInfo.fromMap(data);
  }

  Future<Map<String, String?>?> _getOsRelease() {
    return _tryReadKeyValues('/etc/os-release').then((value) async =>
        value ?? await _tryReadKeyValues('/usr/lib/os-release'));
  }

  Future<Map<String, String?>?> _getLsbRelease() {
    return _tryReadKeyValues('/etc/lsb-release');
  }

  Future<String?> _getMachineId() {
    return _tryReadValue('/etc/machine-id');
  }

  Future<String?> _tryReadValue(String path) {
    return _fileSystem
        .file(path)
        .readAsString()
        .then((str) => str.trim(), onError: (_) => null);
  }

  Future<Map<String, String?>?> _tryReadKeyValues(String path) {
    return _fileSystem
        .file(path)
        .readAsLines()
        .then((lines) => lines.toKeyValues(), onError: (_) => null);
  }
}

extension _Unquote on String {
  String removePrefix(String prefix) {
    if (!startsWith(prefix)) return this;
    return substring(prefix.length);
  }

  String removeSuffix(String suffix) {
    if (!endsWith(suffix)) return this;
    return substring(0, length - suffix.length);
  }

  String unquote() {
    return removePrefix('"').removeSuffix('"');
  }
}

extension _KeyValues on List<String> {
  Map<String, String?> toKeyValues() {
    return Map.fromEntries(map((line) {
      final parts = line.split('=');
      if (parts.length != 2) return MapEntry(line, null);
      return MapEntry(parts.first, parts.last.unquote());
    }));
  }
}
