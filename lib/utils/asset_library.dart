import 'dart:core';

import 'package:flutter/widgets.dart';

class ImageLibrary {
  // TODO: 整合资源文件
  static final Map<String, String> _images = {
    '十里红妆': 'assets/images/1.png',
    '富阳竹纸': 'assets/images/富阳竹纸.png',
    '皮影之光': 'assets/images/皮影之光.png',
    '舟山渔海': 'assets/images/舟山渔海.png',
    'AR/VR': 'assets/images/arvr.png',
  };

  static String getImagePathByName(String name) => _images[name] ?? null;
  static bool exists(String name) => _images.containsKey(name);
  static Image getImageByName(String name) => exists(name) ? Image.network(_images[name]) : null;
}

class VideoLibrary {
  static final Map<String, String> _videos = {};

  static String getVideoPathByName(String name) => _videos[name] ?? null;
  static bool exists(String name) => _videos.containsKey(name);
  static Image getVideoByName(String name) => exists(name) ? Image.network(_videos[name]) : null;
}
