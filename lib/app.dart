import 'package:zl_app/pages/personal/history.dart';
import 'package:zl_app/pages/sidebar_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino App',
      home: HomePage(),
      initialRoute: '/',
      routes: {
        '/sidebar': (context) => SideBarPage(),
        // '/content': (context, {Content content}) => ContentPage(
        //       content: content,
        //     ),
        // '/history': (context) => HistoryPage(),
        // '/video': (context, {Video video}) => VideoPage(
        //       video: video,
        //     )
      },
    );
  }
}
