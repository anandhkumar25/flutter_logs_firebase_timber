import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// A class representing the device and application information.
class DeviceInfo {
  final String? deviceId;
  final String deviceName;
  final String deviceBrand;
  final String osVersion;
  final String manufacturer;
  final String model;
  final String appVersionName;
  final int appVersionCode;

  /// Creates an instance of [DeviceInfo] with the given properties.
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

  /// Asynchronously creates an instance of [DeviceInfo] by fetching
  /// the device and application information.
  ///
  /// Supports both Android and iOS platforms.
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
        deviceId: iOSDeviceInfo.identifierForVendor,
        deviceName: iOSDeviceInfo.name,
        deviceBrand: iOSDeviceInfo.name,
        osVersion: iOSDeviceInfo.systemVersion,
        manufacturer: iOSDeviceInfo.systemName,
        model: iOSDeviceInfo.model,
        appVersionName: packageInfo.version,
        appVersionCode: int.parse(packageInfo.buildNumber),
      );
    }
  }

  /// Converts the [DeviceInfo] instance to a JSON object.
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
