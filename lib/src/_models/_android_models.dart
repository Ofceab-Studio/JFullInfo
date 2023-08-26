import 'dart:convert';

///class [JAndroidInfo] has
///[String] getter [androidId]
///[String] getter [androidSdk]
///[String] getter [securityPatch]
///[String] getter [codeName]
///[String] getter [release]
///[String] getter [device]
///[String] getter [model]
///[String] getter [board]
///[String] getter [brand]
///[String] getter [display]
///[String] getter [fingerPrint]
///[String] getter [batteryLevel]
///[String] getter [deviceId]
///[String] getter [host]
///[String] getter [manufacturer]
///[String] getter [product]
///[String] getter [bootloader]
///[String] _ [List] getter [deviceApis]
///Has [JAndroidInfo.fromMap] Constructor
///has [Map]getter called [info]
///has [String]type method called [toString]
class JAndroidInfo implements JOSInfoModel {
  /// [JAndroidInfo] Constructor
  JAndroidInfo();
  String _fAndroidId = "",
      _fAndroidSdk = "",
      _fAndroidSecurityPatch = "",
      _fAndroidCodeName = "",
      _fAndroidRelease = "",
      _fDevice = "",
      _fModel = "",
      _fBoard = "",
      _fBrand = "",
      _fDisplay = "",
      _fFingerPrint = "",
      _fBatteryLevel = "",
      _fDeviceId = "",
      _fHost = "",
      _fManufacturer = "",
      _fProduct = "",
      _fBootloader = "";
  List<String> _fDeviceApis = [];

  ///[String] getter [androidId]
  String get androidId => _fAndroidId;

  ///[String] getter [androidSdk]
  String get androidSdk => _fAndroidSdk;

  ///[String] getter [securityPatch]
  String get securityPatch => _fAndroidSecurityPatch;

  ///[String] getter [codeName]
  String get codeName => _fAndroidCodeName;

  ///[String] getter [release]
  String get release => _fAndroidRelease;

  ///[String] getter [device]
  String get device => _fDevice;

  ///[String] getter [model]
  String get model => _fModel;

  ///[String] getter [board]
  String get board => _fBoard;

  ///[String] getter [brand]
  String get brand => _fBrand;

  ///[String] getter [display]
  String get display => _fDisplay;

  ///[String] getter [fingerPrint]
  String get fingerPrint => _fFingerPrint;

  ///[String] getter [batteryLevel]
  String get batteryLevel => _fBatteryLevel;

  ///[String] getter [deviceId]
  String get deviceId => _fDeviceId;

  ///[String] getter [host]
  String get host => _fHost;

  ///[String] getter [manufacturer]
  String get manufacturer => _fManufacturer;

  ///[String] getter [product]
  String get product => _fProduct;

  ///[String] getter [bootloader]
  String get bootloader => _fBootloader;

  ///[String] _ [List] getter [deviceApis]
  List<String> get deviceApis => _fDeviceApis;

  /// [JAndroidInfo.fromMap] Constructor
  JAndroidInfo.fromMap(var data) {
    _fAndroidId = data["01"].toString();
    _fAndroidSdk = data["02"].toString();
    _fAndroidSecurityPatch = data["03"].toString();
    _fAndroidCodeName = data["04"].toString();
    _fAndroidRelease = data["05"].toString();
    _fDevice = data["06"].toString();
    _fModel = data["07"].toString();
    _fBoard = data["08"].toString();
    _fBrand = data["09"].toString();
    _fDisplay = data["010"].toString();
    _fFingerPrint = data["011"].toString();
    _fBatteryLevel = data["012"].toString();
    _fDeviceId = data["013"].toString();
    _fHost = data["014"].toString();
    _fManufacturer = data["015"].toString();
    _fProduct = data["016"].toString();
    _fBootloader = data["017"].toString();
    _fDeviceApis = _getApis(data["018"]);
  }
  List<String> _getApis(List s) {
    List<String> ss = [];
    for (var i in s) {
      ss.add(i.toString());
    }
    return ss;
  }

  /// [String]type method called [toString]
  @override
  String toString() {
    return json.encode(info);
  }

  ///[Map] getter [info]
  @override
  Map<String, dynamic> get info => {
        "androidId": _fAndroidId,
        "androidSdk": _fAndroidSdk,
        "securityPatch": _fAndroidSecurityPatch,
        "codeName": _fAndroidCodeName,
        "release": _fAndroidRelease,
        "device": _fDevice,
        "model": _fModel,
        "board": _fBoard,
        "brand": _fBrand,
        "display": _fDisplay,
        "fingerPrint": _fFingerPrint,
        "batteryLevel": _fBatteryLevel,
        "deviceId": _fDeviceId,
        "host": _fHost,
        "manufacturer": _fManufacturer,
        "product": _fProduct,
        "bootloader": _fBootloader,
        "deviceApis": _fDeviceApis,
      };
}

///class [JApplicationInfoAndroid] has

///[String] getter [versionCode]
///[String] getter [versionName]
///[String] getter [appName]
///[String] getter [appUid]
///[String] getter [packageName]
///[String] getter [targetSdk]
///[String] getter [firstInstall]
///[String] getter [dataDir]
///[String] _ [List] getter [permissions]
///Has [JApplicationInfoAndroid.fromMap] Constructor
///has [Map]getter called [info]
///has [String]type method called [toString]
class JApplicationInfoAndroid implements JApplicationInfo {
  /// [JApplicationInfoAndroid] Constructor
  JApplicationInfoAndroid();
  String _fAppVersionCode = "",
      _fAppVersionName = "",
      _fAppName = "",
      _fAppPackageName = "",
      _fAppTargetSdk = "",
      _fAppFirstInstall = "",
      _fAppUid = "",
      _fAppDataDir = "";
  List<String> _fAppPermissions = [];

  ///[String] getter [versionCode]
  String get versionCode => _fAppVersionCode;

  ///[String] getter [versionName]
  String get versionName => _fAppVersionName;

  ///[String] getter [appName]
  String get appName => _fAppName;

  ///[String] getter [appUid]
  String get appUid => _fAppUid;

  ///[String] getter [packageName]
  String get packageName => _fAppPackageName;

  ///[String] getter [targetSdk]
  String get targetSdk => _fAppTargetSdk;

  ///[String] getter [firstInstall]
  String get firstInstall => _fAppFirstInstall;

  ///[String] getter [dataDir]
  String get dataDir => _fAppDataDir;

  ///[String] _ [List] getter [permissions]
  List<String> get permissions => _fAppPermissions;

  /// [JApplicationInfoAndroid.fromMap] Constructor
  JApplicationInfoAndroid.fromMap(var data) {
    _fAppVersionCode = data["01"].toString();
    _fAppVersionName = data["02"].toString();
    _fAppName = data["03"].toString();
    _fAppPackageName = data["04"].toString();
    _fAppTargetSdk = data["05"].toString();
    _fAppFirstInstall = data["06"].toString();
    _fAppDataDir = data["07"].toString();
    _fAppUid = data["08"].toString();
    _fAppPermissions = _getPerm(data["09"]);
  }
  List<String> _getPerm(List s) {
    List<String> ss = [];
    for (var i in s) {
      ss.add(i.toString());
    }
    return ss;
  }

  ///[Map] getter [info]
  @override
  Map<String, dynamic> get info => {
        "appUid": _fAppUid,
        "versionCode": _fAppVersionCode,
        "versionName": _fAppVersionName,
        "appName": _fAppName,
        "packageName": _fAppPackageName,
        "targetSdk": _fAppTargetSdk,
        "firstInstall": _fAppFirstInstall,
        "dataDir": _fAppDataDir,
        "permissions": _fAppPermissions,
      };

  /// [String]type method called [toString]
  @override
  String toString() {
    return json.encode(info);
  }
}

///class [JSimInfo] has
///[String] getter [slotIndex]
///[String] getter [iccId]
///[String] getter [cardId]
///[String] getter [carrierId]
///[String] getter [carrierName]
///[String] getter [countryIso]
///[String] getter [displayName]
///[String] getter [subscribeId]
///[String] getter [mcc]
///[String] getter [mnc]
///Has [JSimInfo.fromMap] Constructor
///has [Map]getter called [toMap]
///has [String]type method called [toString]
class JSimInfo {
  String _fSimSlotIndex = "",
      _fSimIccId = "",
      _fSimCardId = "",
      _fSimCarrierId = "",
      _fSimCarrierName = "",
      _fSimCountryIso = "",
      _fSimDisplayName = "",
      _fSimSubscriptionId = "",
      _fSimMcc = "",
      _fSimMnc = "";

  ///[String] getter [slotIndex]
  String get slotIndex => _fSimSlotIndex;

  ///[String] getter [iccId]
  String get iccId => _fSimIccId;

  ///[String] getter [cardId]
  String get cardId => _fSimCardId;

  ///[String] getter [carrierId]
  String get carrierId => _fSimCarrierId;

  ///[String] getter [carrierName]
  String get carrierName => _fSimCarrierName;

  ///[String] getter [countryIso]
  String get countryIso => _fSimCountryIso;

  ///[String] getter [displayName]
  String get displayName => _fSimDisplayName;

  ///[String] getter [subscribeId]
  String get subscribeId => _fSimSubscriptionId;

  ///[String] getter [mcc]
  String get mcc => _fSimMcc;

  ///[String] getter [mnc]
  String get mnc => _fSimMnc;

  /// [JSimInfo.fromMap] Constructor
  JSimInfo.fromMap(var data) {
    _fSimSlotIndex = data["01"].toString();
    _fSimIccId = data["02"].toString();
    _fSimCardId = data["03"].toString();
    _fSimCarrierId = data["04"].toString();
    _fSimCarrierName = data["05"].toString();
    _fSimCountryIso = data["06"].toString();
    _fSimDisplayName = data["07"].toString();
    _fSimSubscriptionId = data["08"].toString();
    _fSimMcc = data["09"].toString();
    _fSimMnc = data["010"].toString();
  }

  ///[Map] getter [toMap]
  Map<String, dynamic> get toMap => {
        "slotIndex": _fSimSlotIndex,
        "iccId": _fSimIccId,
        "cardId": _fSimCardId,
        "carrierId": _fSimCarrierId,
        "carrierName": _fSimCarrierName,
        "countryIso": _fSimCountryIso,
        "displayName": _fSimDisplayName,
        "subscribeId": _fSimSubscriptionId,
        "mcc": _fSimMcc,
        "mnc": _fSimMnc,
      };

  /// [String]type method called [toString]
  @override
  String toString() {
    return json.encode(toMap);
  }
}

///class [JFullInfoAndroidModel] has
///[JAndroidInfo] getter [androidInfo]
///[JApplicationInfoAndroid] getter [appInfo]
///[JSimInfo] _ [List] getter [simInfo]
///Has [JFullInfoAndroidModel.fromMap] Constructor
///has [Map]getter called [toMap]
///has [String]type method called [toString]
class JFullInfoAndroidModel implements JFullInfoModel {
  /// [JFullInfoAndroidModel] Constructor
  JFullInfoAndroidModel();
  JAndroidInfo _fAndroidInf = JAndroidInfo();
  JApplicationInfoAndroid _fJApplicationInfo = JApplicationInfoAndroid();
  List<JSimInfo> _fJSimInfo = [];

  ///[JAndroidInfo] getter [androidInfo]
  JAndroidInfo get androidInfo => _fAndroidInf;

  ///[JApplicationInfoAndroid] getter [appInfo]
  JApplicationInfoAndroid get appInfo => _fJApplicationInfo;

  ///[JSimInfo] _ [List] getter [simInfo]
  List<JSimInfo> get simInfo => _fJSimInfo;

  /// [JFullInfoAndroidModel.fromMap] Constructor
  JFullInfoAndroidModel.fromMap(var data) {
    _fAndroidInf = JAndroidInfo.fromMap(json.decode(data["01"]));
    _fJSimInfo = _getSim(data["02"]);
    _fJApplicationInfo =
        JApplicationInfoAndroid.fromMap(json.decode(data["03"]));
  }
  List<JSimInfo> _getSim(List s) {
    List<JSimInfo> ss = [];
    for (var i in s) {
      ss.add(JSimInfo.fromMap(json.decode(i)));
    }
    return ss;
  }

  List<String> _getS(List<JSimInfo> s) {
    List<String> ss = [];
    for (var i in s) {
      ss.add(i.toString());
    }
    return ss;
  }

  /// [String]type method called [toString]
  @override
  String toString() {
    return json.encode(info);
  }

  @override
  Map<String, dynamic> get info => {
        "androidInfo": _fAndroidInf.toString(),
        "appInfo": _fJApplicationInfo.toString(),
        "simInfo": _getS(_fJSimInfo),
      };
}

class JOSInfoModel {
  JOSInfoModel(this.info);
  final Map<String, dynamic> info;
  @override
  String toString() {
    return json.encode(info);
  }
}

class JApplicationInfo {
  JApplicationInfo(this.info);
  final Map<String, dynamic> info;
  @override
  String toString() {
    return json.encode(info);
  }
}

class JFullInfoModel {
  JFullInfoModel(this.info);
  final Map<String, dynamic> info;
  @override
  String toString() {
    return json.encode(info);
  }
}
