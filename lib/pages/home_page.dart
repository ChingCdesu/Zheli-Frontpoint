import 'dart:math';

import 'package:zl_app/api/dio_singleton.dart';
//import 'package:zl_app/pages/sidebar_page.txt';
// import 'package:zl_app/settings/user.dart';
import 'package:zl_app/ui_libraries/indicator.dart';
import 'package:zl_app/ui_libraries/slide_stack.dart';
import 'package:zl_app/utils/device_size.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'ar.dart';
import 'all_view.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var ar = new ArPage();
  var hm = new HmPage();
  var all = new AllView();
  final List _pageList = [
    ArPage(),
    HmPage(),
    AllView(),
  ];

  final GlobalKey<ContainerState> _slideKey = GlobalKey<ContainerState>();

  @override
  Widget build(BuildContext context) {
    return SlideStack(
      child: SlideContainer(
        key: _slideKey,
        slideDirection: SlideDirection.left,
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconData(0xe75f, fontFamily: "Schyler"),
                ),
                activeIcon: Icon(
                  IconData(0xe60d, fontFamily: "Schyler"),
                ),
                title: Text(
                  'AR',
                  style: TextStyle(
                    fontSize: 15.0,
                    // fontFamily: "font_siyuan",
                    color: Color.fromRGBO(108, 100, 78, 1),
                  ),
                ),
                // title: Container(
                //   height: 0,
                // ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconData(0xe7a7, fontFamily: "Schyler"),
                ),
                activeIcon: Icon(
                  IconData(0xe7ae, fontFamily: "Schyler"),
                ),
                title: Text(
                  '首页',
                  style: TextStyle(
                    fontSize: 15.0,
                    // fontFamily: "font_siyuan",
                    color: Color.fromRGBO(108, 100, 78, 1),
                  ),
                ),
                // title: Container(
                //   height: 0,
                // ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconData(0xe60b, fontFamily: "Schyler"),
                ),
                activeIcon: Icon(
                  IconData(0xe6c5, fontFamily: "Schyler"),
                ),
                title: Text(
                  '全景',
                  style: TextStyle(
                    fontSize: 15.0,
                    // fontFamily: "font_siyuan",
                    color: Color.fromRGBO(108, 100, 78, 1),
                  ),
                ),
                // title: Container(
                //   height: 0,
                // ),
              )
            ],
          ),
          tabBuilder: (context, index) {
            return _pageList[index];
          },
        ),
      ),
      drawer: SideBar(),
    );
    // return MaterialApp(
    //   home: Scaffold(
    //     body: this._pageList[this._currentIndex],
    //     drawer: SideBar(),
    //     bottomNavigationBar: BottomNavigationBar(
    //       //backgroundColor: Color.fromRGBO(233, 217, 171, 1),
    //       backgroundColor: Color.fromRGBO(232, 221, 190, 1),
    //       selectedItemColor: Color.fromRGBO(108, 100, 78, 1),
    //       currentIndex: _currentIndex,
    //       onTap: (index) {
    //         setState(() {
    //           _currentIndex = index;
    //         });
    //       },
    //       items: [
    //         BottomNavigationBarItem(
    //           icon: Icon(
    //             IconData(0xe75f, fontFamily: "Schyler"),
    //           ),
    //           activeIcon: Icon(
    //             IconData(0xe60d, fontFamily: "Schyler"),
    //           ),
    //           title: Text(
    //             'AR',
    //             style: TextStyle(
    //               fontSize: 15.0,
    //               // fontFamily: "font_siyuan",
    //               color: Color.fromRGBO(108, 100, 78, 1),
    //             ),
    //           ),
    //           // title: Container(
    //           //   height: 0,
    //           // ),
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(
    //             IconData(0xe7a7, fontFamily: "Schyler"),
    //           ),
    //           activeIcon: Icon(
    //             IconData(0xe7ae, fontFamily: "Schyler"),
    //           ),
    //           title: Text(
    //             '首页',
    //             style: TextStyle(
    //               fontSize: 15.0,
    //               // fontFamily: "font_siyuan",
    //               color: Color.fromRGBO(108, 100, 78, 1),
    //             ),
    //           ),
    //           // title: Container(
    //           //   height: 0,
    //           // ),
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(
    //             IconData(0xe60b, fontFamily: "Schyler"),
    //           ),
    //           activeIcon: Icon(
    //             IconData(0xe6c5, fontFamily: "Schyler"),
    //           ),
    //           title: Text(
    //             '全景',
    //             style: TextStyle(
    //               fontSize: 15.0,
    //               // fontFamily: "font_siyuan",
    //               color: Color.fromRGBO(108, 100, 78, 1),
    //             ),
    //           ),
    //           // title: Container(
    //           //   height: 0,
    //           // ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}

class HmPage extends StatefulWidget {
  @override
  HmPageState createState() => HmPageState();
}

class HmPageState extends State<HmPage> {
  Widget bcg() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home_page/bcg.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

//导航栏，listicon
  Widget _buildAppBar() {
    return Positioned(
      top: 30.0,
      left: 20.0,
      right: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 0, top: 10),
            child: CupertinoButton(
              child: Icon(
                //IconData(0xe663, fontFamily: "Schyler"),
                Icons.menu,
                color: Color.fromRGBO(108, 100, 78, 1),
                size: 30,
              ),
              onPressed: () {
                // Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      ),
    );
  }

//两行标题
  Widget _buildTitle(double height) {
    return Positioned(
      top: height * .15,
      left: 30.0,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            bcg(),
            //_buildAppBar(),
            _buildTitle(height),
            Align(
              alignment: Alignment.bottomCenter,
              child: PageViewWidget(),
            ),
            _buildAppBar(),
          ],
        );
      },
    );
  }
}

class PageViewWidget extends StatefulWidget {
  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  List<Imagelist> _list = Imagelist.generate();

  PageController pageController;

  double viewportFraction = 0.8;

  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: viewportFraction)
      ..addListener(() {
        setState(() {
          pageOffset = pageController.page;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemBuilder: (ctx, index) {
        double scale = max(viewportFraction, (1 - (pageOffset - index).abs()) + viewportFraction);
        double angle = (pageOffset - index).abs();

        if (angle > 0.5) {
          angle = 1 - angle;
        }
        return CupertinoButton(
          onPressed: () {
            Navigator.pushNamed(
              this.context,
              _list[index].router,
              // '/home',
            );
          },
          child: Container(
            padding:
                EdgeInsets.only(right: 20, left: 0, top: 270 - scale * 15, bottom: 50 - scale * 2),
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              child: Stack(
                children: <Widget>[
                  Container(
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
                ],
              ),
            ),
          ),
        );
      },
      itemCount: _list.length,
    );
  }
}

class Imagelist {
  String url;
  String name;
  String router;

  Imagelist(this.url, this.name, this.router);

  static List<Imagelist> generate() {
    return [
      Imagelist("assets/images/home_page/zsyh_home.png", "zsyh_home", '/pages/sea_culture/main'),
      Imagelist("assets/images/home_page/fyzz_home.png", "fyzz_home", '/pages/china_paper/main'),
      Imagelist("assets/images/home_page/pyzg_home.png", "pyzg_home", '/pages/shadow_play/main'),
      Imagelist(
          "assets/images/home_page/slhz_home.png", "slhz_home", '/pages/feminine_adornment/main'),
      Imagelist(
          "assets/images/home_page/zwzs_home.png", "zwzs_home", '/pages/handcrafted_fan/main'),
    ];
  }
}

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  //listile封装
  Widget list_icon(int code, String name) {
    return ListTile(
      leading: Icon(
        IconData(code, fontFamily: "Schyler"),
        size: 35,
        color: Color.fromRGBO(108, 100, 78, 1),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 18,
          color: Color.fromRGBO(108, 100, 78, 1),
        ),
      ),
    );
  }

//drawer
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/home_page/side_bcg.png',
                        ),
                        fit: BoxFit.cover),
                  ),
                  // accountName: Text('Colaholic'),
                  // accountEmail: Text('ID:235073306'),
                  // currentAccountPicture: CircleAvatar(
                  //   backgroundImage: AssetImage('assets/Avatar.jpg'),
                  child: Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 80,
                          margin: EdgeInsets.only(bottom: 10),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/home_page/Avatar.jpg',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Text(
                            'Colaholic',
                            style: TextStyle(
                              color: Color.fromRGBO(108, 100, 78, 1),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'ID:2377905',
                            style: TextStyle(
                              color: Color.fromRGBO(108, 100, 78, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          list_icon(0xe773, '个人中心'),
          list_icon(0xe754, '我的消息'),
          list_icon(0xe753, '我的笔记'),
          list_icon(0xe79d, '我的收藏'),
          list_icon(0xe74d, '历史记录'),
          list_icon(0xe76c, '选项设置'),
        ],
      ),
    );
  }
}
