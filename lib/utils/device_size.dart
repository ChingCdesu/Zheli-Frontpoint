import 'dart:math';
import 'dart:ui';

class DeviceSize {
  static Size _deviceSize;
  static bool _lock = false;

  static Size getSizeByPercent(double percentX, double percentY) {
    final double _x = min(max(percentX, 0.0), 1.0);
    final double _y = min(max(percentY, 0.0), 1.0);
    return Size(_deviceSize.width * _x, _deviceSize.height * _y);
  }

  static double getWidthByPercent(double percentX) {
    final double _x = min(max(percentX, 0.0), 1.0);
    return _deviceSize.width * _x;
  }

  static double getHeightByPercent(double percentY) {
    final double _y = min(max(percentY, 0.0), 1.0);
    return _deviceSize.width * _y;
  }

  static void setDeviceSize(Size size) {
    // if (_lock) throw  Exception("You cannot Set Device Size twice!");
    _deviceSize = size;
    _lock = true;
  }
}
