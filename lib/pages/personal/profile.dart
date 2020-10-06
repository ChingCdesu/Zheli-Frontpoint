import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/api/model_operations.dart' as API;
import 'package:zl_app/settings/user.dart';
import 'package:zl_app/utils/device_size.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _user = API.User(id: Account.userId);

  @override
  void initState() {
    API.Get(_user).doOperation().then((_o) {
      if (_o.hasError) {
        SnackBar(content: Text("获取个人信息失败"));
      }
    }).whenComplete(() => super.initState());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Container(
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                //背景区
                Container(
                    height: DeviceSize.getHeightByPercent(1),
                    child: Image.network(
                      _user.headerImage,
                      fit: BoxFit.fill,
                    ),
                    ),
                //头像区
                Positioned(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //back
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: DeviceSize.getHeightByPercent(0.108)),
                      width: DeviceSize.getWidthByPercent(0.12),
                      child: CupertinoButton(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: Icon(
                          CupertinoIcons.back,
                          color: CupertinoColors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    //用户信息
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                        top: DeviceSize.getHeightByPercent(0.12),
                        left: DeviceSize.getWidthByPercent(0.04),
                        right: DeviceSize.getWidthByPercent(0.02),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //头像
                          Container(
                            // margin: EdgeInsets.all(10),
                            height: DeviceSize.getHeightByPercent(0.18),
                            width: DeviceSize.getWidthByPercent(0.2),
                            decoration: BoxDecoration(
                              image: new DecorationImage(
                                //image: NetworkImage(publicUrl + _user.avatar),
                                image: AssetImage('assets/images/home_page/avatar.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(45)),
                            ),
                          ),
                          Container(
                            child: Text(
                              _user.username,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: CupertinoColors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          //好友 编辑 更换背景
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '好友   10',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: CupertinoColors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              //背景
                              Container(
                                  width: DeviceSize.getWidthByPercent(0.4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      CupertinoButton(
                                          minSize: 16,
                                          padding: EdgeInsets.fromLTRB(14, 2, 14, 2),
                                          child: Text(
                                            '编辑',
                                            style: TextStyle(
                                                color: CupertinoColors.white, fontSize: 12),
                                          ),
                                          color: Color.fromRGBO(155, 155, 155, 0.8),
                                          pressedOpacity: 0.8,
                                          onPressed: () {
                                            // Navigator.push(
                                            //     context,
                                            //     CupertinoPageRoute(
                                            //         builder: (context) => new MySettingsPage()));
                                          }),
                                      CupertinoButton(
                                          minSize: 16,
                                          padding: EdgeInsets.fromLTRB(14, 2, 14, 2),
                                          child: Text(
                                            '更换背景',
                                            style: TextStyle(
                                                color: CupertinoColors.white, fontSize: 12),
                                          ),
                                          color: Color.fromRGBO(155, 155, 155, 0.8),
                                          pressedOpacity: 0.8,
                                          onPressed: () {
                                            // TODO: 点击时弹出照片选择
                                          }),
                                    ],
                                  )),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ],
                )),
                //动态区&收藏区
                Positioned(
                  left: 0,
                  right: 0,
                  top: DeviceSize.getHeightByPercent(0.7),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CardPage(),
                  ),
                )
              ],
            )));
  }
}

class CardPage extends StatefulWidget {
  CardPage({Key key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List<API.Favorite> _favorites = [];

  @override
  void initState() async {
    var _f = API.Favorite(userId: Account.userId);
    var _o = await API.Confirm(_f).doOperation();
    if (!_o.hasError) {
      var result = _o.getResult();
      result['values'].forEach((ele) async {
        _f.id = ele['ID'];
        await API.Get(_f).doOperation().then((o) {
          if (!o.hasError) {
            _favorites.add(_f);
          } else {
            print(o.log);
            return;
          }
        });
      });
    } else {
      print(_o.log);
      return;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //动态&收藏
          Container(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '笔记',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '收藏',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: new Border.all(color: CupertinoColors.systemGrey6),
            ),
            height: DeviceSize.getHeightByPercent(0.001),
          ),
          //内容
          Container(
            height: MediaQuery.of(context).size.height,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: PageView(children: <Widget>[
                //我的笔记list
                Container(margin: EdgeInsets.only(top: 10), child: null),
                //我的收藏list
                Container(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                        // children: PocketInfo.getWidgets(),
                        ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
