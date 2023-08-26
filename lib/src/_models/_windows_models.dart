import 'dart:convert';

import 'package:jfullinfo/src/_src.dart';

///class [JWindowsInfo] has
///[String] getter [pcName]
///[String] getter [userName]
///[String] getter [buildNumber]
///[String] getter [platformId]
///[String] getter [productId]
///[String] getter [productName]
///[String] getter [owner]
///[String] getter [releaseId]
///[String] getter [installDate]
///[String] getter [cores]
///[String] getter [memorySize]
///[String] getter [deviceId]
///[String] getter [displayVersion]
///Has [JWindowsInfo.fromMap] Constructor
///has [Map]getter called [info]
///has [String]type method called [toString]
class JWindowsInfo implements JOSInfoModel {
  /// [JWindowsInfo] Constructor
  JWindowsInfo();

  String _fPcName = '',
      _fUserName = '',
      _fBuildNumber = '',
      _fPlatformId = '',
      _fProductId = '',
      _fProductName = '',
      _fOwner = '',
      _fReleaseId = '',
      _fInstallDate = '',
      _fCores = '',
      _fMemorySize = '',
      _fDeviceId = '',
      _fDisplayVersion = '';

  ///[String] getter [pcName]
  String get pcName => _fPcName;

  ///[String] getter [userName]
  String get userName => _fUserName;

  ///[String] getter [buildNumber]
  String get buildNumber => _fBuildNumber;

  ///[String] getter [platformId]
  String get platformId => _fPlatformId;

  ///[String] getter [productId]
  String get productId => _fProductId;

  ///[String] getter [productName]
  String get productName => _fProductName;

  ///[String] getter [owner]
  String get owner => _fOwner;

  ///[String] getter [releaseId]
  String get releaseId => _fReleaseId;

  ///[String] getter [installDate]
  String get installDate => _fInstallDate;

  ///[String] getter [cores]
  String get cores => _fCores;

  ///[String] getter [memorySize]
  String get memorySize => _fMemorySize;

  ///[String] getter [deviceId]
  String get deviceId => _fDeviceId;

  ///[String] getter [displayVersion]
  String get displayVersion => _fDisplayVersion;

  /// [JWindowsInfo.fromMap] Constructor
  JWindowsInfo.fromMap(var data) {
    _fPcName = data['pcName'].toString();
    _fUserName = data['userName'].toString();
    _fBuildNumber = data['buildNumber'].toString();
    _fPlatformId = data['platformId'].toString();
    _fProductId = data['productId'].toString();
    _fProductName = data['productName'].toString();
    _fOwner = data['owner'].toString();
    _fReleaseId = data['releaseId'].toString();
    _fInstallDate = data['installDate'].toString();
    _fCores = data['cores'].toString();
    _fMemorySize = data['memorySize'].toString();
    _fDeviceId = data['deviceId'].toString();
    _fDisplayVersion = data['displayVersion'].toString();
  }

  ///[Map] getter [info]
  @override
  Map<String, dynamic> get info => {
        "pcName": _fPcName,
        "userName": _fUserName,
        "buildNumber": _fBuildNumber,
        "platformId": _fPlatformId,
        "productName": _fProductName,
        "productId": _fProductId,
        "releaseId": _fReleaseId,
        "installDate": _fInstallDate,
        "owner": _fOwner,
        "cores": _fCores,
        "memorySize": _fMemorySize,
        "deviceId": _fDeviceId,
        "displayVersion": _fDisplayVersion,
      };

  /// [String]type method called [toString]
  @override
  String toString() {
    return json.encode(info);
  }
}

///class [JApplicationInfoWindows] has
///[String] getter [appName]
///[String] getter [packageName]
///[String] getter [version]
///[String] getter [buildNumber]
///Has [JApplicationInfoWindows.fromMap] Constructor
///has [Map]type method called [info]
///has [String]type method called [toString]
class JApplicationInfoWindows implements JApplicationInfo {
  /// [JApplicationInfoWindows] Constructor
  JApplicationInfoWindows();

  String _fAppName = '', _fPackageName = '', _fVersion = '', _fBuildNumber = '';

  ///[String] getter [appName]
  String get appName => _fAppName;

  ///[String] getter [packageName]
  String get packageName => _fPackageName;

  ///[String] getter [version]
  String get version => _fVersion;

  ///[String] getter [buildNumber]
  String get buildNumber => _fBuildNumber;

  /// [JApplicationInfoWindows.fromMap] Constructor
  JApplicationInfoWindows.fromMap(var data) {
    _fAppName = data['appName'].toString();
    _fPackageName = data['packageName'].toString();
    _fVersion = data['version'].toString();
    _fBuildNumber = data['buildNumber'].toString();
  }

  ///[Map] getter [info]
  @override
  Map<String, dynamic> get info => {
        "appName": _fAppName,
        "packageName": _fPackageName,
        "version": _fVersion,
        "buildNumber": _fBuildNumber,
      };

  /// [String]type method called [toString]
  @override
  String toString() {
    return json.encode(info);
  }
}

///class [JFullInfoWindowsModel] has
///[JWindowsInfo] getter [windowsInfo]
///[JApplicationInfoWindows] getter [appInfo]
///Has [JFullInfoWindowsModel.fromMap] Constructor
///has [Map]getter called [info]
///has [String]type method called [toString]
class JFullInfoWindowsModel implements JFullInfoModel {
  /// [JFullInfoWindowsModel] Constructor
  JFullInfoWindowsModel();

  JWindowsInfo _fWindowsInfo = JWindowsInfo();
  JApplicationInfoWindows _fJApplicationInfo = JApplicationInfoWindows();

  ///[JWindowsInfo] getter [windowsInfo]
  JWindowsInfo get windowsInfo => _fWindowsInfo;

  ///[JApplicationInfoWindows] getter [appInfo]
  JApplicationInfoWindows get appInfo => _fJApplicationInfo;

  /// [JFullInfoWindowsModel.fromMap] Constructor
  JFullInfoWindowsModel.fromMap(var data) {
    _fWindowsInfo = JWindowsInfo.fromMap(data["windowsInfo"]);
    _fJApplicationInfo = JApplicationInfoWindows.fromMap(data["appInfo"]);
  }

  /// [String]type method called [toString]
  @override
  String toString() {
    return json.encode(info);
  }

  @override
  Map<String, dynamic> get info => {
        "windowsInfo": _fWindowsInfo.toString(),
        "appInfo": _fJApplicationInfo.toString(),
      };
}
