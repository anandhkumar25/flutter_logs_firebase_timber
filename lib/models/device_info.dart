import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfo {
  final String deviceId;
  final String deviceName;
  final String deviceBrand;
  final String osVersion;
  final String manufacturer;
  final String model;
  final String appVersionName;
  final int appVersionCode;

  DeviceInfo({
    required this.deviceId,
    required this.deviceName,
    required this.deviceBrand,
    required this.osVersion,
    required this.manufacturer,
    required this.model,
    required this.appVersionName,
    required this.appVersionCode,
  });

  static Future<DeviceInfo> create() async {
    var deviceInfo = DeviceInfoPlugin();
    var packageInfo = await PackageInfo.fromPlatform();
    if (defaultTargetPlatform == TargetPlatform.android) {
      var androidInfo = await deviceInfo.androidInfo;
      return DeviceInfo(
        deviceId: androidInfo.id,
        deviceName: androidInfo.device,
        deviceBrand: androidInfo.brand,
        osVersion: androidInfo.version.release,
        manufacturer: androidInfo.manufacturer,
        model: androidInfo.model,
        appVersionName: packageInfo.version,
        appVersionCode: int.parse(packageInfo.buildNumber),
      );
    } else {
      var iOSDeviceInfo = await deviceInfo.iosInfo;
      return DeviceInfo(
        deviceId: iOSDeviceInfo.name,
        deviceName: iOSDeviceInfo.localizedModel,
        deviceBrand: iOSDeviceInfo.name,
        osVersion: iOSDeviceInfo.systemVersion,
        manufacturer: iOSDeviceInfo.systemName,
        model: iOSDeviceInfo.model,
        appVersionName: packageInfo.version,
        appVersionCode: int.parse(packageInfo.buildNumber),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId,
        'deviceName': deviceName,
        'deviceBrand': deviceBrand,
        'osVersion': osVersion,
        'manufacturer': manufacturer,
        'model': model,
        'appVersionName': appVersionName,
        'appVersionCode': appVersionCode,
      };

  @override
  String toString() {
    return 'DeviceInfo(deviceId: $deviceId, deviceName: $deviceName, deviceBrand: $deviceBrand, osVersion: $osVersion, manufacturer: $manufacturer, model: $model, appVersionName: $appVersionName, appVersionCode: $appVersionCode)';
  }
}
