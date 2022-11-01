import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:jfullinfo/jDataModels.dart';

///[JFullInfo] The root class for jfullinfo Plugin
/// has a [Future] method called [getAndroidInformation] has [JAndroidInfo] return type.
/// has a [Future] method called [getHardwareInformation] has [JHardwareInfo] return type.
/// has a [Future] method called [getApplicationInformation] has [JApplicationInfo] return type.
/// has a [Future] method called [getAllInformation] has [JInfoModel] return type.
/// has a [Future] method called [getSimInformation] has [List] of [JSimInfo] return type.
class JFullInfo {
  static const String _ANDROID_INFO = "AndroidInfo";
  static const String _SIM_INFO = "SimInfo";
  static const String _DEVICE_INFO = "DeviceInfo";
  static const String _APPLICATION_INFO = "ApplicationInfo";
  static const String _ALL_INFO = "AllInfo";
  static const _methodChannel = MethodChannel('JFullInfo');

  /// [Future] method called [getAndroidInformation] has [JAndroidInfo] return type.
  Future<JAndroidInfo> getAndroidInformation() async {
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

  ///[Future] method called [getHardwareInformation] has [JHardwareInfo] return type.
  Future<JHardwareInfo> getHardwareInformation() async {
    JHardwareInfo hardwareInfo = JHardwareInfo();
    try {
      final value = await _methodChannel.invokeMethod<String>(_DEVICE_INFO);
      if (value != null) {
        final val = json.decode(value);
        hardwareInfo = JHardwareInfo.fromMap(val);
      }
      return hardwareInfo;
    } catch (e) {
      return hardwareInfo;
    }
  }

  ///[Future] method called [getApplicationInformation] has [JApplicationInfo] return type.
  Future<JApplicationInfo> getApplicationInformation() async {
    JApplicationInfo applicationInfo = JApplicationInfo();
    try {
      final value =
          await _methodChannel.invokeMethod<String>(_APPLICATION_INFO);
      if (value != null) {
        final val = json.decode(value);
        applicationInfo = JApplicationInfo.fromMap(val);
      }
      return applicationInfo;
    } catch (e) {
      return applicationInfo;
    }
  }

  ///[Future] method called [getAllInformation] has [JInfoModel] return type.
  Future<JInfoModel> getAllInformation() async {
    JInfoModel allInfo = JInfoModel();
    try {
      final value = await _methodChannel.invokeMethod<String>(_ALL_INFO);
      if (value != null) {
        final val = json.decode(value);
        allInfo = JInfoModel.fromMap(val);
      }
      return allInfo;
    } catch (e) {
      return allInfo;
    }
  }

  ///[Future] method called [getSimInformation] has [List] of [JSimInfo] return type.
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
