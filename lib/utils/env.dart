import 'dart:io';

class AppEnvironment {
  static const bool isDebug = !bool.fromEnvironment("dart.vm.product");
  static String platform = Platform.operatingSystem;
  static String appName;
  static String version;
  static String buildNumber;
}
