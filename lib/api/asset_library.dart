import 'package:zl_app/api/asset_loader.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:typed_data';

class AImage {
  static Future<Widget> network(String url) async {
    var loader = AssetLoader.getInstance();
    var response = await loader.get(url);
    var s = response.data as ResponseBody;
    var data = List<int>();
    Widget image;
    var l = await s.stream.toList();
    l.forEach((element) => data.addAll(element));
    image = Image.memory(Uint8List.fromList(data));
    return image;
  }
}
