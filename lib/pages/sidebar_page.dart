import 'dart:core';

import 'package:zl_app/utils/device_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideBarPage extends StatefulWidget {
  SideBarPage({Key key}) : super(key: key);

  @override
  _SideBarPageState createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage> {
  List<Widget> _generateList() {
    final Map<String, dynamic> _list = {
      "首页": {'icon': CupertinoIcons.home, 'router': '/'},
      "我的收藏": {'icon': CupertinoIcons.heart, 'router': '/personal/favorite'},
      "我的笔记": {'icon': CupertinoIcons.mail, 'router': '/personal/note'},
      "历史记录": {'icon': CupertinoIcons.time, 'router': '/personal/history'},
    };

    List<Widget> _widgets = List<Widget>();

    _list.forEach((key, value) {
      _widgets.add(
        CupertinoButton(
          child: Container(
            height: 79,
            width: DeviceSize.getWidthByPercent(1.0),
            child: ListTile(
              leading: Icon(
                value['icon'],
                color: CupertinoColors.white,
                size: 32,
              ),
              title: Text(
                key,
                style: TextStyle(
                    color: CupertinoColors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onPressed: () => Navigator.pushNamed(context, value['router']),
        ),
      );
    });
    return _widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36.0),
        color: Colors.blueGrey[400],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(children: <Widget>[
          Container(
            height: DeviceSize.getHeightByPercent(0.2),
            child: Row(
              children: <Widget>[
                Container(width: 20),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/avatar.jpg',
                      width: 60,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 25, 20),
                  child: Text(
                    '阿口太',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(child: Container(color: Colors.transparent)),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    CupertinoIcons.pencil,
                    color: CupertinoColors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    CupertinoIcons.settings,
                    color: CupertinoColors.white,
                  ),
                ),
                Container(width: 20)
              ],
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: _generateList(),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36.0),
              color: Colors.white,
            ),
            height: DeviceSize.getHeightByPercent(0.22),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        CupertinoIcons.person,
                        color: Colors.blueGrey[600],
                        size: 24,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        '个人主页',
                        style: TextStyle(
                          color: Colors.blueGrey[600],
                        ),
                      ),
                    )
                  ],
                )),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  width: 1.5,
                  color: Colors.blueGrey[400],
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        CupertinoIcons.bell,
                        color: Colors.blueGrey[600],
                        size: 24,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        '退出登录',
                        style: TextStyle(
                          color: Colors.blueGrey[600],
                        ),
                      ),
                    )
                  ],
                )),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
