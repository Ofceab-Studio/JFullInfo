import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:jfullinfo/jfullinfo.dart';

import 'package:jfullinfo/src/_models/_android_models.dart';

///[JFullInfoAndroid] The root class for jfullinfo Android Implementation Plugin
///
/// has a [Future] method called [getOsInformation] has [JAndroidInfo] return type.
///
/// has a [Future] method called [getApplicationInformation] has [JApplicationInfoAndroid] return type.
///
/// has a [Future] method called [getAllInformation] has [JFullInfoAndroidModel] return type.
///
/// has a [Future] method called [getSimInformation] has [List] of [JSimInfo] return type.
class JFullInfoAndroid extends JFullInfo {
  static const String _ANDROID_INFO = "AndroidInfo";
  static const String _SIM_INFO = "SimInfo";
  static const String _APPLICATION_INFO = "ApplicationInfo";
  static const String _ALL_INFO = "AllInfo";
  static const _methodChannel = MethodChannel('JFullInfo');

  /// [Future] method called [getOsInformation] has [JAndroidInfo] return type.
  @override
  Future<JAndroidInfo> getOsInformation() async {
    JAndroidInfo androidInfo = JAndroidInfo();
    try {
      final value = await _methodChannel.invokeMethod<String>(_ANDROID_INFO);
      if (value != null) {
        final val = json.decode(value);
        androidInfo = JAndroidInfo.fromMap(val);
      }
      return androidInfo;
    } catch (e) {
      return androidInfo;
    }
  }

  ///[Future] method called [getApplicationInformation] has [JApplicationInfoAndroid] return type.
  @override
  Future<JApplicationInfoAndroid> getApplicationInformation() async {
    JApplicationInfoAndroid applicationInfo = JApplicationInfoAndroid();
    try {
      final value =
          await _methodChannel.invokeMethod<String>(_APPLICATION_INFO);
      if (value != null) {
        final val = json.decode(value);
        applicationInfo = JApplicationInfoAndroid.fromMap(val);
      }
      return applicationInfo;
    } catch (e) {
      return applicationInfo;
    }
  }

  ///[Future] method called [getAllInformation] has [JFullInfoAndroidModel] return type.
  @override
  Future<JFullInfoAndroidModel> getAllInformation() async {
    JFullInfoAndroidModel allInfo = JFullInfoAndroidModel();
    try {
      final value = await _methodChannel.invokeMethod<String>(_ALL_INFO);
      if (value != null) {
        final val = json.decode(value);
        allInfo = JFullInfoAndroidModel.fromMap(val);
      }
      return allInfo;
    } catch (e) {
      return allInfo;
    }
  }

  ///[Future] method called [getSimInformation] has [List] of [JSimInfo] return type.
  @override
  Future<List<JSimInfo>> getSimInformation() async {
    List<JSimInfo> simInfo = [];
    try {
      final value = await _methodChannel.invokeListMethod<String>(_SIM_INFO);
      if (value != null) {
        for (var i in value) {
          simInfo.add(JSimInfo.fromMap(json.decode(i)));
        }
      }
      return simInfo;
    } catch (e) {
      return simInfo;
    }
  }
}
