import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

@singleton
class DeviceRepository {
  final DeviceInfoPlugin _device;

  DeviceRepository(this._device);

  Future<String?> getId() async {
    if (Platform.isIOS) {
      final iosDeviceInfo = await _device.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await _device.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }
}
