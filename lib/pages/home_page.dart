import 'dart:math';

import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/pages/sidebar_page.dart';
// import 'package:zl_app/pages/sidebar_page.txt';
// import 'package:zl_app/settings/user.dart';
import 'package:zl_app/ui_libraries/indicator.dart';
import 'package:zl_app/ui_libraries/slide_stack.dart';
import 'package:zl_app/utils/device_size.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double position = 0.0;
  double height = 0.0;
  bool homeLock = false;

  double get maxSlideDistance => MediaQuery.of(context).size.width * 0.45;

  final GlobalKey<ContainerState> _slideKey = GlobalKey<ContainerState>();

  void onSlide(double position) {
    // print("position: $position");
    this.homeLock = position.floor() == 0 ? false : true;

    setState(() => this.position = position);
  }

  List<FirstImg> _list = FirstImg.generate();

  PageController pageController;
  double viewportFraction = 0.8; //放大之后展示多大的图
  double pageOffset = 1; //首个放大页面是第几个

  @override
  void initState() {
    super.initState();
    //首页面设置第几个，放多大
    pageController = PageController(initialPage: 1, viewportFraction: viewportFraction)
      ..addListener(() {
        setState(() {
          pageOffset = pageController.page;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void _pageChanged(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SlideStack(
      drawer: SideBar(),
      child: SlideContainer(
        key: _slideKey,
        slideDirection: SlideDirection.left,
        onSlide: onSlide,
        drawerSize: maxSlideDistance,
        // transform:
        //     Matrix4.translationValues(0.0, height * position / 10, 0.0),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home_page/bcg.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: SafeArea(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      // menu
                      SizedBox(
                        width: DeviceSize.getWidthByPercent(1.0),
                        height: DeviceSize.getHeightByPercent(0.1),
                        child: Row(
                          children: <Widget>[
                            // leading
                            Expanded(
                              child: CupertinoButton(
                                child: Icon(
                                  Icons.menu,
                                  size: 30,
                                  color: Color.fromRGBO(108, 100, 78, 1),
                                ),
                                onPressed: () =>
                                    this.homeLock ? null : _slideKey.currentState.openOrClose(),
                              ),
                              flex: 1,
                            ),
                            // middle
                            Expanded(
                              child: Container(),
                              flex: 2,
                            ),
                            // trailer
                          ],
                        ),
                      ),
                      //title
                      SizedBox(
                        width: DeviceSize.getWidthByPercent(1.0),
                        height: DeviceSize.getHeightByPercent(0.4),
                        child: Container(
                          margin: EdgeInsets.only(left: 50, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "浙 里",
                                style: TextStyle(
                                    color: Color.fromRGBO(108, 100, 78, 1),
                                    fontSize: 45.0,
                                    fontFamily: "font_boo",
                                    fontWeight: FontWeight.bold),
                              ),
                              //Padding(padding: EdgeInsets.only(bottom: 8)),
                              Text(
                                "欢迎回来,Colaholic!",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: "font_boo",
                                  // fontFamily: "font_siyuan",
                                  color: Color.fromRGBO(108, 100, 78, 1),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 8)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.only(
                  top: DeviceSize.getHeightByPercent(0.2 - 0.2 * position),
                ),
                margin: EdgeInsets.only(
                  bottom: DeviceSize.getHeightByPercent(0.3 * position),
                ),
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: PageView.builder(
                          physics: this.homeLock ? NeverScrollableScrollPhysics() : null,
                          onPageChanged: _pageChanged,
                          controller: pageController,
                          itemBuilder: (context, index) {
                            double scale = max(viewportFraction,
                                    (1 - (pageOffset - index).abs()) + viewportFraction) *
                                2;
                            return Container(
                              padding: EdgeInsets.only(
                                  right: 10 + position * 30,
                                  left: 0,
                                  top: 140 - scale * 15,
                                  bottom: 60 - scale * 2),
                              child: Container(
                                child: GestureDetector(
                                  onTap: () {
                                    if (position.floor() == 1) {
                                      _slideKey.currentState.openOrClose();
                                    } else {}
                                  },
                                  child: CupertinoButton(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              _list[index].url,
                                            ),
                                            fit: BoxFit.fitWidth),
                                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(5, 5),
                                            blurRadius: 12.0,
                                            spreadRadius: 0.0,
                                          )
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      print(_list[index].router);
                                      Navigator.pushNamed(context, _list[index].router);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: _list.length,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            child: RaisedButton(
                                child: Text(
                                  'AR',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "font_boo",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                textColor: Color.fromRGBO(108, 100, 78, 1),
                                padding: EdgeInsets.all(10),
                                color: Color.fromRGBO(233, 217, 171, 1),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                onPressed: () {}),
                          ),
                          Container(
                            child: RaisedButton(
                                child: Text(
                                  '全景',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "font_boo",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                textColor: Color.fromRGBO(108, 100, 78, 1),
                                padding: EdgeInsets.all(10),
                                color: Color.fromRGBO(233, 217, 171, 1),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                onPressed: () {}),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstImg {
  String url;
  String name;
  String router;

  FirstImg(this.url, this.name, this.router);

  static List<FirstImg> generate() {
    return [
      FirstImg("assets/images/home_page/zsyh_home.png", "zsyh_home", '/pages/sea_culture/main'),
      FirstImg("assets/images/home_page/fyzz_home.png", "fyzz_home", '/pages/china_paper/main'),
      FirstImg("assets/images/home_page/pyzg_home.png", "pyzg_home", '/pages/shadow_play/main'),
      FirstImg(
          "assets/images/home_page/slhz_home.png", "slhz_home", '/pages/feminine_adornment/main'),
      FirstImg("assets/images/home_page/zwzs_home.png", "zwzs_home", '/pages/handcrafted_fan/main'),
    ];
  }
}
