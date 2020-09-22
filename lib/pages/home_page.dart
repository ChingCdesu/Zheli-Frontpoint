import 'dart:math';

import 'package:zl_app/pages/sidebar_page.dart';
import 'package:zl_app/settings/user.dart';
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
    // init size of device
    DeviceSize.setDeviceSize(MediaQuery.of(context).size);
    if (Account.token == null) {
      // TODO: 跳转到登录界面
    }

    return SlideStack(
      drawer: SideBarPage(),
      child: SlideContainer(
        key: _slideKey,
        slideDirection: SlideDirection.left,
        onSlide: onSlide,
        drawerSize: maxSlideDistance,
        // transform:
        //     Matrix4.translationValues(0.0, height * position / 10, 0.0),
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 1.0 - position,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(36.0),
                  ),
                  color: CupertinoColors.white,
                ),
                child: SafeArea(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        // navigationBar
                        SizedBox(
                          width: DeviceSize.getWidthByPercent(1.0),
                          height: DeviceSize.getHeightByPercent(0.1),
                          child: Row(
                            children: <Widget>[
                              // leading
                              Expanded(
                                child: CupertinoButton(
                                  child: Icon(
                                    Icons.perm_identity,
                                    size: 30,
                                    color: CupertinoColors.black,
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
                              Expanded(
                                child: Text(
                                  "博研非遗",
                                  style: TextStyle(fontSize: 18),
                                ),
                                flex: 1,
                              )
                            ],
                          ),
                        ),
                        // searchBar
                        Container(
                          padding: EdgeInsets.all(15),
                          child: CupertinoTextField(
                            enabled: !this.homeLock,
                            padding: EdgeInsets.only(left: 10, top: 6, right: 10, bottom: 6),
                            prefix: Container(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                CupertinoIcons.search,
                                color: CupertinoColors.black,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: CupertinoColors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(DeviceSize.getHeightByPercent(1.0))),
                              border: Border.all(color: CupertinoColors.systemGrey3),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: CupertinoColors.systemGrey2,
                                    offset: Offset(5.0, 5.0),
                                    blurRadius: 5.0)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                  left: 10,
                                  top: 120 - scale * 15,
                                  bottom: 60 - scale * 2),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(36.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Color.fromARGB(
                                            (255 * (1 - position)).floor(), 180, 180, 180),
                                        offset: Offset(12, 18),
                                        blurRadius: 15.0,
                                        spreadRadius: 0.0,
                                      )
                                    ]),
                                child: GestureDetector(
                                  onTap: () {
                                    if (position.floor() == 1) {
                                      _slideKey.currentState.openOrClose();
                                    } else {}
                                  },
                                  child: CupertinoButton(
                                    child: Image.asset(
                                      _list[index].url,
                                      fit: BoxFit.contain,
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
                      Opacity(
                        opacity: 1.0 - position,
                        child: Indicator(
                          controller: pageController,
                          itemCount: _list.length,
                        ),
                      )
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
      // FirstImg("assets/images/arvr.png", "arvr"),
      FirstImg("assets/images/1.png", "十里红妆", '/pages/feminine_adornment/main'),
      FirstImg("assets/images/皮影之光.png", "皮影之光", '/pages/shadow_play/main'),
      FirstImg("assets/images/舟山渔海.png", "舟山渔海", '/pages/sea_culture/main'),
      FirstImg("assets/images/彰吴竹扇.png", "彰吴竹扇", '/pages/handcrafted_fan/main'),
      FirstImg("assets/images/富阳竹纸.png", "富阳竹纸", '/pages/china_paper/main'),
    ];
  }
}
