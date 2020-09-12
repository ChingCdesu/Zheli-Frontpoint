import 'dart:io';

class AppEnvironment {
  static const bool isDebug = !bool.fromEnvironment("dart.vm.product");
  static String platform = Platform.operatingSystem;
  static String appName = "Zheli";
  static String version = "1.0.0";
  static String buildNumber;
}
