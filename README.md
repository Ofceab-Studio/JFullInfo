# jfullinfo

JFullInfo: Just An Amazing Full Hardware, System, Sim & Application Information Plugin For Android Devices.

## Features
- Get Full Device Information
- Get Full Android Information
- Get Full SIM Card Information
- Get Full Application Information
- Get All Information


## Usage
To Use `jfullinfo`

#Android
To Use `getSimInformation` Method Add to `AndroidManifest.xml` this Permission:
```xml
 <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
```

## Simple Usage

```dart
final _jFullInfo = JFullInfo();
```
Get Hardware Information:
```dart
Future<JHardwareInfo> getHardwareInfo()async{
  final value =  await _jFullInfo.getHardwareInformation();
  return value;
}
```

Get Android Information:
```dart
Future<JAndroidInfo> getAndroidInfo()async{
  final value =  await _jFullInfo.getAndroidInformation();
  return value;
}
```

Get Application Information:
```dart
Future<JApplicationInfo> getApplicationInfo()async{
  final value =  await _jFullInfo.getApplicationInformation();
  return value;
}
```

Get JSimInfo Information:
```dart
Future<List<JSimInfo>> getSimInfo()async{
  final value =  await _jFullInfo.getSimInformation();
  return value;
}
```

Get All Information:
```dart
Future<JInfoModel> getAllInfo()async{
  final value =  await _jFullInfo.getAllInformation();
  return value;
}
```

## Additional information

Provided By [Just Codes Developers](https://jucodes.com/)

