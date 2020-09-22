import 'package:zl_app/pages/china_paper/history.dart';
import 'package:zl_app/pages/china_paper/main.dart';
import 'package:zl_app/pages/china_paper/manufacture.dart';

import 'package:zl_app/pages/feminine_adornment/history.dart';
import 'package:zl_app/pages/feminine_adornment/main.dart';
import 'package:zl_app/pages/feminine_adornment/object.dart';
import 'package:zl_app/pages/feminine_adornment/video.dart';

import 'package:zl_app/pages/handcrafted_fan/main.dart';
import 'package:zl_app/pages/handcrafted_fan/video.dart';
import 'package:zl_app/pages/personal/edit_profile.dart';
import 'package:zl_app/pages/personal/favorite.dart';

import 'package:zl_app/pages/personal/history.dart';
import 'package:zl_app/pages/personal/login.dart';
import 'package:zl_app/pages/personal/note.dart';
import 'package:zl_app/pages/personal/profile.dart';
import 'package:zl_app/pages/personal/register.dart';

import 'package:zl_app/pages/sea_culture/cinema.dart';
import 'package:zl_app/pages/sea_culture/main.dart';
import 'package:zl_app/pages/sea_culture/video.dart';

import 'package:zl_app/pages/shadow_play/cinema.dart';
import 'package:zl_app/pages/shadow_play/history.dart';
import 'package:zl_app/pages/shadow_play/main.dart';
import 'package:zl_app/pages/shadow_play/manufacture.dart';
import 'package:zl_app/pages/shadow_play/video.dart';

// import 'package:zl_app/pages/sidebar_page.dart';
import 'package:zl_app/pages/home_page.dart';
import 'package:zl_app/utils/env.dart';

import 'package:flutter/cupertino.dart';
import 'package:package_info/package_info.dart';

void main() {
  PackageInfo.fromPlatform().then((value) {
    AppEnvironment.appName = value.appName;
    AppEnvironment.version = value.version;
    AppEnvironment.buildNumber = value.buildNumber;
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<String, WidgetBuilder> _routes = {
    // 富阳竹纸
    '/pages/china_paper/main': (context) => ChinaPaperMain(),
    '/pages/china_paper/history': (context) => ChinaPaperHistory(),
    '/pages/china_paper/manufacture': (context) => ChinaPaperManufacture(),
    // 十里红妆
    '/pages/feminine_adornment/main': (context) => FeminineAdornmentMain(),
    '/pages/feminine_adornment/history': (context) => FeminineAdornmentHistory(),
    '/pages/feminine_adornment/object': (context) => FeminineAdornmentObject(),
    '/pages/feminine_adornment/video': (context) => FeminineAdornmentVideo(),
    // 彰吴竹扇
    '/pages/handcrafted_fan/main': (context) => HandcraftedFanMain(),
    '/pages/handcrafted_fan/video': (context) => HandcraftedFanVideo(),
    // 舟山渔海
    '/pages/sea_culture/main': (context) => SeaCultureMain(),
    '/pages/sea_culture/cinema': (context) => SeaCultureCinema(),
    '/pages/sea_culture/video': (context) => SeaCultureVideo(),
    // 皮影之光
    '/pages/shadow_play/main': (context) => ShadowPlayMain(),
    '/pages/shadow_play/history': (context) => ShadowPlayHistory(),
    '/pages/shadow_play/manufacture': (context) => ShadowPlayManufacture(),
    '/pages/shadow_play/cinema': (context) => ShadowPlayCinema(),
    '/pages/shadow_play/video': (context) => ShadowPlayVideo(),
    // 个人中心页面
    '/personal/edit_profile': (context) => EditProfile(),
    '/personal/favorite': (context) => FavoritePage(),
    '/personal/history': (context) => HistoryPage(),
    '/personal/login': (context) => LoginPage(),
    '/personal/profile': (context) => ProfilePage(),
    '/personal/register': (context) => RegisterPage(),
    '/personal/note': (context) => NotePage(),
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino App',
      home: HomePage(),
      initialRoute: '/',
      routes: _routes,
    );
  }
}
