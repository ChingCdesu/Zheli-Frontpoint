import 'dart:core';

import 'package:flutter/widgets.dart';

class ImageLibrary {
  static final Map<String, String> _images = {
    '十里红妆': 'assets/images/home_page/slhz_home.png',
    '富阳竹纸': 'assets/images/home_page/fyzz_home.png',
    '皮影之光': 'assets/images/home_page/pyzg_home.png',
    '舟山渔海': 'assets/images/home_page/zsyh_home.png',
    'AR/VR': 'assets/images/home_page/arvr.png',
  };

  static String getImagePathByName(String name) => _images[name] ?? null;
  static bool exists(String name) => _images.containsKey(name);
  //static Image getImageByName(String name) => exists(name) ? Image.network(_images[name]) : null;
  static Image getImageByName(String name) => exists(name) ? Image.asset(_images[name]) : null;
}

class VideoLibrary {
  static final Map<String, String> _videos = {};

  static String getVideoPathByName(String name) => _videos[name] ?? null;
  static bool exists(String name) => _videos.containsKey(name);
  //static Image getVideoByName(String name) => exists(name) ? Image.network(_videos[name]) : null;
  static Image getVideoByName(String name) => exists(name) ? Image.asset(_videos[name]) : null;
}
