library paulonia_utils;

import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PUtils {
  /// Verifies if there is network connectivity
  static Future<bool> checkNetwork() async {
    return (await Connectivity().checkConnectivity()) !=
        ConnectivityResult.none;
  }

  /// Verifies if the app is running on release
  static bool isOnRelease() {
    return kReleaseMode;
  }

  /// Verifies if the app is running in a test environment
  static bool isOnTest() {
    if (isOnWeb()) return false;
    return Platform.environment.containsKey('FLUTTER_TEST');
  }

  /// Verifies if the app is running on web
  static bool isOnWeb() {
    return kIsWeb;
  }

  /// Verifies if the app supports Apple Sign In
  static Future<bool> supportsAppleSignIn() async {
    if (isOnWeb()) return false;
    if (!Platform.isIOS) return false;
    var iosInfo = await DeviceInfoPlugin().iosInfo;
    var version = iosInfo.systemVersion;
    return version.contains('13');
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

  /// Get a file image from a url
  static Future<File> getImageFromUrl(String tempName, String url) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File resFile = File(tempPath + tempName + '.jpg');
    final response = await http.get(url);
    await resFile.writeAsBytes(response.bodyBytes);
    return resFile;
  }
}
