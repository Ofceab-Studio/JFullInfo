import 'dart:io';

import 'package:jfullinfo/src/_src.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class JFullInfo extends PlatformInterface {
  /// Constructs a JFullInfo.
  JFullInfo() : super(token: _token);

  static final Object _token = Object();

  static JFullInfo _instance = JFullInfo._setPlatform();

  /// The default [instance] of [JFullInfo] to use.
  static JFullInfo get instance => _instance;

  Future<JAndroidInfo> get androidInfo async =>
      JAndroidInfo.fromMap(await _instance.getOsInformation());
  Future<JLinuxInfo> get linuxInfo async =>
      JLinuxInfo.fromMap(await _instance.getOsInformation());
  Future<JWindowsInfo> get windowsInfo async =>
      JWindowsInfo.fromMap(await _instance.getOsInformation());
  Future<JOSInfoModel> get osInformation async {
    if (Platform.isAndroid) {
      return androidInfo;
    } else if (Platform.isLinux) {
      return linuxInfo;
    } else if (Platform.isWindows) {
      return windowsInfo;
    } else {
      return JOSInfoModel(<String, dynamic>{});
    }
  }

  Future<JApplicationInfoAndroid> get androidAppInfo async =>
      JApplicationInfoAndroid.fromMap(
          await _instance.getApplicationInformation());
  Future<JApplicationInfoLinux> get linuxAppInfo async =>
      JApplicationInfoLinux.fromMap(
          await _instance.getApplicationInformation());
  Future<JApplicationInfoWindows> get windowsAppInfo async =>
      JApplicationInfoWindows.fromMap(
          await _instance.getApplicationInformation());
  Future<JApplicationInfo> get applicationInfo async {
    if (Platform.isAndroid) {
      return androidAppInfo;
    } else if (Platform.isLinux) {
      return linuxAppInfo;
    } else if (Platform.isWindows) {
      return windowsAppInfo;
    } else {
      return JApplicationInfo(<String, dynamic>{});
    }
  }

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [JFullInfo] when
  /// they register themselves.
  static set instance(JFullInfo instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  factory JFullInfo._setPlatform() {
    if (Platform.isAndroid) {
      return JFullInfoAndroid();
    } else if (Platform.isWindows) {
      return JFullInfoWindows();
    } else if (Platform.isLinux) {
      return JFullInfoLinux();
    } else {
      throw UnimplementedError(
        'The current platform "${Platform.operatingSystem}" is not supported by this plugin.',
      );
    }
  }

  ///[Future] method called [getOsInformation] has [JOSInfoModel] return type.
  Future<JOSInfoModel> getOsInformation() async =>
      throw UnimplementedError('getOsInformation() has not been implemented.');

  ///[Future] method called [getApplicationInformation] has [JApplicationInfo] return type.
  Future<JApplicationInfo> getApplicationInformation() async =>
      throw UnimplementedError(
          'getApplicationInformation() has not been implemented.');

  ///[Future] method called [getSimInformation] has [List] of [JSimInfo] return type.
  Future<List<JSimInfo>> getSimInformation() async =>
      throw UnimplementedError('getSimInformation() has not been implemented.');

  ///[Future] method called [getAllInformation] has [JFullInfoModel] return type.
  Future<JFullInfoModel> getAllInformation() async =>
      throw UnimplementedError('getAllInformation() has not been implemented.');
}
