class PUtilsPlatform {
  /// Verifies if there is network connectivity
  static Future<bool> checkNetwork() async {
    return true;
  }

  /// Verifies if the app supports Apple Sign In
  static Future<bool> supportsAppleSignIn() async {
    return false;
  }

  /// Verifies if the app is running in a test environment
  static bool isOnTest() {
    return false;
  }

  /// Verifies if the app is running in iOS
  static bool isOnIOS() {
    return false;
  }

  /// Gets the actual NTP date
  static Future<DateTime?> getNTPDate() async {
    return DateTime.now();
  }
}
