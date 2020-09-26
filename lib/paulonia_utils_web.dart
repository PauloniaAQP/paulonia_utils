class PUtilsPlatform {
  /// Verifies if the app supports Apple Sign In
  static Future<bool> supportsAppleSignIn() async {
    return false;
  }

  /// Verifies if the app is running in a test environment
  static bool isOnTest() {
    return false;
  }
}
