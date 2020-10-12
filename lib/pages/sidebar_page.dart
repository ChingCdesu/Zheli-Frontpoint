import 'dart:core';

import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/settings/user.dart';
import 'package:zl_app/utils/device_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/api/model_operations.dart' as API;

class SideBar extends StatefulWidget {
  SideBar({Key key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  // List<Widget> _generateList() {
  //   final Map<String, dynamic> _list = {
  //     "首页": {'icon': CupertinoIcons.home, 'router': '/home'},
  //     "我的收藏": {'icon': CupertinoIcons.heart, 'router': '/personal/favorite'},
  //     "我的笔记": {'icon': CupertinoIcons.mail, 'router': '/personal/note'},
  //     "历史记录": {'icon': CupertinoIcons.time, 'router': '/personal/history'},
  //   };

  //   List<Widget> _widgets = List<Widget>();

  //   _list.forEach((key, value) {
  //     _widgets.add(
  //       CupertinoButton(
  //         child: Container(
  //           height: 79,
  //           width: DeviceSize.getWidthByPercent(1.0),
  //           child: ListTile(
  //             leading: Icon(
  //               value['icon'],
  //               color: CupertinoColors.white,
  //               size: 32,
  //             ),
  //             title: Text(
  //               key,
  //               style: TextStyle(
  //                   color: CupertinoColors.white, fontSize: 18, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //         ),
  //         onPressed: () => Navigator.pushNamed(context, value['router']),
  //       ),
  //     );
  //   });
  //   return _widgets;
  // }

  // String _prefix = '?user=${Account.userId}&token=${Account.token}';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36.0),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/home_page/side_bcg.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            height: DeviceSize.getHeightByPercent(0.6),
            child: Column(
              children: <Widget>[
                Container(width: 20),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(publicUrl + Account.avatarPath),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 25, 10),
                  child: Text(
                    Account.username,
                    style: TextStyle(
                      color: Color.fromRGBO(108, 100, 78, 1),
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 25, 0),
                  child: Text(
                    'ID:${230000 + Account.userId}',
                    style: TextStyle(
                      color: Color.fromRGBO(108, 100, 78, 1),
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(child: Container(color: Colors.transparent)),
                Container(width: 20)
              ],
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: Container(
                  padding: EdgeInsets.only(
                    bottom:
                        MediaQuery.of(context).padding.bottom + DeviceSize.getHeightByPercent(0.1),
                    top: DeviceSize.getHeightByPercent(0.1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      list_icon(0xe773, '个人中心', '/personal/profile'),
                      list_icon(0xe754, '我的消息', '/personal/message'),
                      list_icon(0xe753, '我的笔记', '/personal/note'),
                      list_icon(0xe79d, '我的收藏', '/personal/favorite'),
                      list_icon(0xe74d, '历史记录', '/personal/history'),
                      list_icon(0xe76c, '系统设置', '/settings'),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget list_icon(int code, String name, String router) {
    return Container(
      margin: EdgeInsets.all(0),
      child: ListTile(
        leading: Icon(
          IconData(code, fontFamily: "Schyler"),
          size: 33,
          color: Color.fromRGBO(108, 100, 78, 1),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(108, 100, 78, 1),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, router);
        },
      ),
    );
  }
}
