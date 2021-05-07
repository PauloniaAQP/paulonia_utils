import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:ntp/ntp.dart';

class PUtilsPlatform {

  /// Verifies if there is network connectivity
  static Future<bool> checkNetwork() async{
    try{
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Verifies if the app supports Apple Sign In
  static Future<bool> supportsAppleSignIn() async {
    if (!Platform.isIOS) return false;
    var iosInfo = await DeviceInfoPlugin().iosInfo;
    var version = iosInfo.systemVersion;
    return version.contains('13');
  }

  /// Verifies if the app is running in a test environment
  static bool isOnTest() {
    return Platform.environment.containsKey('FLUTTER_TEST');
  }

  /// Verifies if the app is running in iOS
  static bool isOnIOS() {
    return Platform.isIOS;
  }

  /// Gets the actual NTP date
  static Future<DateTime?> getNTPDate() async{
    return NTP.now();
  }
}
