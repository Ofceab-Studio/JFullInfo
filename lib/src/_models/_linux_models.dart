import 'dart:convert';
import 'package:jfullinfo/src/_src.dart';

///class [JLinuxInfo] has
///[String] getter [name]
///[String] getter [version]
///[String] getter [id]
///[String] getter [idLike]
///[String] getter [versionCodeName]
///[String] getter [versionId]
///[String] getter [prettyName]
///[String] getter [buildId]
///[String] getter [variant]
///[String] getter [variantId]
///[String] getter [deviceId]
///[String] getter [displayVersion]
///Has [JLinuxInfo.fromMap] Constructor
///has [Map]getter called [info]
///has [String]type method called [toString]
class JLinuxInfo implements JOSInfoModel {
  /// [JLinuxInfo] Constructor
  JLinuxInfo();

  String _fName = '',
      _fVersion = '',
      _fId = '',
      _fIdLike = '',
      _fVersionCodeName = '',
      _fVersionId = '',
      _fPrettyName = '',
      _fBuildId = '',
      _fVariant = '',
      _fVariantId = '',
      _fDeviceId = '';

  ///[String] getter [name]
  String get name => _fName;

  ///[String] getter [version]
  String get version => _fVersion;

  ///[String] getter [idLike]
  String get idLike => _fIdLike;

  ///[String] getter [id]
  String get id => _fId;

  ///[String] getter [versionCodeName]
  String get versionCodeName => _fVersionCodeName;

  ///[String] getter [versionId]
  String get versionId => _fVersionId;

  ///[String] getter [prettyName]
  String get prettyName => _fPrettyName;

  ///[String] getter [buildId]
  String get buildId => _fBuildId;

  ///[String] getter [variant]
  String get variant => _fVariant;

  ///[String] getter [variantId]
  String get variantId => _fVariantId;

  ///[String] getter [deviceId]
  String get deviceId => _fDeviceId;

  /// [JLinuxInfo.fromMap] Constructor
  JLinuxInfo.fromMap(var data) {
    _fName = data['name'].toString();
    _fVersion = data['version'].toString();
    _fIdLike = data['idLike'].toString();
    _fId = data['id'].toString();
    _fVersionCodeName = data['versionCodeName'].toString();
    _fVersionId = data['versionId'].toString();
    _fPrettyName = data['prettyName'].toString();
    _fBuildId = data['buildId'].toString();
    _fVariant = data['variant'].toString();
    _fVariantId = data['variantId'].toString();
    _fDeviceId = data['deviceId'].toString();
  }

  ///[Map] getter [info]
  @override
  Map<String, dynamic> get info => {
        "name": _fName,
        "version": _fVersion,
        "idLike": _fIdLike,
        "id": _fId,
        "versionCodeName": _fVersionCodeName,
        "versionId": _fVersionId,
        "prettyName": _fPrettyName,
        "buildId": _fBuildId,
        "variant": _fVariant,
        "variantId": _fVariantId,
        "deviceId": _fDeviceId,
      };

  /// [String]type method called [toString]
  @override
  String toString() {
    return json.encode(info);
  }
}

///class [JApplicationInfoLinux] has
///[String] getter [appName]
///[String] getter [packageName]
///[String] getter [version]
///[String] getter [buildNumber]
///Has [JApplicationInfoLinux.fromMap] Constructor
///has [Map]type method called [info]
///has [String]type method called [toString]
class JApplicationInfoLinux implements JApplicationInfo {
  /// [JApplicationInfoLinux] Constructor
  JApplicationInfoLinux();

  String _fAppName = '', _fPackageName = '', _fVersion = '', _fBuildNumber = '';

  ///[String] getter [appName]
  String get appName => _fAppName;

  ///[String] getter [packageName]
  String get packageName => _fPackageName;

  ///[String] getter [version]
  String get version => _fVersion;

  ///[String] getter [buildNumber]
  String get buildNumber => _fBuildNumber;

  /// [JApplicationInfoLinux.fromMap] Constructor
  JApplicationInfoLinux.fromMap(var data) {
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

///class [JFullInfoLinuxModel] has
///[JLinuxInfo] getter [windowsInfo]
///[JApplicationInfoLinux] getter [appInfo]
///Has [JFullInfoWindowsModel.fromMap] Constructor
///has [Map]getter called [info]
///has [String]type method called [toString]
class JFullInfoLinuxModel implements JFullInfoModel {
  /// [JFullInfoLinuxModel] Constructor
  JFullInfoLinuxModel();

  JLinuxInfo _fLinuxInfo = JLinuxInfo();
  JApplicationInfoLinux _fJApplicationInfo = JApplicationInfoLinux();

  ///[JLinuxInfo] getter [linuxInfo]
  JLinuxInfo get linuxInfo => _fLinuxInfo;

  ///[JApplicationInfoLinux] getter [appInfo]
  JApplicationInfoLinux get appInfo => _fJApplicationInfo;

  /// [JFullInfoLinuxModel.fromMap] Constructor
  JFullInfoLinuxModel.fromMap(var data) {
    _fLinuxInfo = JLinuxInfo.fromMap(data["linuxInfo"]);
    _fJApplicationInfo = JApplicationInfoLinux.fromMap(data["appInfo"]);
  }

  /// [String]type method called [toString]
  @override
  String toString() {
    return json.encode(info);
  }

  @override
  Map<String, dynamic> get info => {
        "linuxInfo": _fLinuxInfo.toString(),
        "appInfo": _fJApplicationInfo.toString(),
      };
}
