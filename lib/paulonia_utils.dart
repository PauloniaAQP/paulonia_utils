library paulonia_utils;

import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:ntp/ntp.dart';
import 'package:paulonia_utils/paulonia_utils_mobile.dart'
    if (dart.library.html) 'package:paulonia_utils/paulonia_utils_web.dart';

class PUtils {

  /// Verifies if there is network connectivity
  static Future<bool> checkNetwork() async {
    if((await Connectivity().checkConnectivity()) ==
        ConnectivityResult.none) return false;
    if(isOnWeb()) return true;
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

  /// Verifies if the app is running on release
  static bool isOnRelease() {
    return kReleaseMode;
  }

  /// Verifies if the app is running in a test environment
  static bool isOnTest() {
    return PUtilsPlatform.isOnTest();
  }

  /// Verifies if the app is running on web
  static bool isOnWeb() {
    return kIsWeb;
  }

  /// Verifies if the app is running in iOS
  static bool isOnIOS() {
    return PUtilsPlatform.isOnIOS();
  }

  /// Verifies if the app supports Apple Sign In
  static Future<bool> supportsAppleSignIn() {
    return PUtilsPlatform.supportsAppleSignIn();
  }

  /// Get the Gmail profile URL with configurable [height] and [width]
  ///
  /// You need to get the [photoUrl] for the original photo. This function change
  /// the URL to get the image with fixed size.
  static String getGmailProfileUrl(
    String photoUrl,
    int height,
    int width,
  ) {
    String res = "";
    for (int c in photoUrl.runes) {
      var char = String.fromCharCode(c);
      res += char;
      if (char == '=') {
        res += 'h' + height.toString();
        res += '-w' + width.toString();
        break;
      }
    }
    return res;
  }

  /// Get the Facebook profile URL with configurable [height] and [width]
  ///
  /// You need to get the [photoUrl] for the original photo. This function change
  /// the URL to get the image with fixed size.
  static String getFacebookProfileUrl(
    String photoUrl,
    int height,
    int width,
  ) {
    String res;
    res = photoUrl + '?height=' + height.toString();
    res += '&width=' + width.toString();
    return res;
  }

  /// Gets the actual NTP date
  static Future<DateTime?> getNTPDate() async{
    if(PUtils.isOnTest()) return DateTime.now();
    if(!(await checkNetwork())) return null;
    return NTP.now();
  }

}
