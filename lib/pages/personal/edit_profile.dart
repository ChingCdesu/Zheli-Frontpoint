import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/utils/device_size.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //更改头像
  Widget photoChange() {
    return Container(
      margin: EdgeInsets.fromLTRB(22, 0, 22, 0),
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                '更换头像',
                style: TextStyle(fontSize: 18, color: CupertinoColors.black),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    height: DeviceSize.getHeightByPercent(0.14),
                    width: DeviceSize.getWidthByPercent(0.14),
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        //image: NetworkImage(publicUrl + "assets/images/photo01.jpg"),
                        image: AssetImage('assets/images/home_page/photo01.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                    child: Icon(
                      CupertinoIcons.forward,
                      color: CupertinoColors.black,
                      size: 28,
                    ),
                    onPressed: () {
                      // TODO: 点击时弹出照片选择
                    },
                  ),
                ],
              ),
            ),
          ]),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              border: new Border.all(color: CupertinoColors.systemGrey4),
            ),
            height: DeviceSize.getHeightByPercent(0.001),
          ),
        ],
      ),
    );
  }

  //更改用户名
  Widget nameChange() {
    return Container(
      margin: EdgeInsets.fromLTRB(22, 0, 22, 0),
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                '更改用户名',
                style: TextStyle(fontSize: 18, color: CupertinoColors.black),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      'scdsx',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Icon(
                      CupertinoIcons.forward,
                      color: CupertinoColors.black,
                      size: 24,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ]),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              border: new Border.all(color: CupertinoColors.systemGrey4),
            ),
            height: DeviceSize.getHeightByPercent(0.001),
          ),
        ],
      ),
    );
  }

  //更改所在地
  Widget locationChange() {
    return Container(
      margin: EdgeInsets.fromLTRB(22, 0, 22, 0),
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                '更改所在地',
                style: TextStyle(fontSize: 18, color: CupertinoColors.black),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      '杭州',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Icon(
                      CupertinoIcons.forward,
                      color: CupertinoColors.black,
                      size: 24,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ]),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              border: new Border.all(color: CupertinoColors.systemGrey4),
            ),
            height: DeviceSize.getHeightByPercent(0.001),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: true,
        middle: Text('个人设置'),
        border: Border(),
        padding: EdgeInsetsDirectional.only(
          end: DeviceSize.getWidthByPercent(0.02),
        ),
        backgroundColor: Colors.white,
        //trailing: this.trailing,
        leading: Container(
            child: Material(
          color: Colors.transparent,
          child: CupertinoButton(
              padding: EdgeInsets.all(0),
              child: Icon(
                CupertinoIcons.back,
                color: CupertinoColors.black,
                size: 25,
              ),
              onPressed: () => Navigator.of(context).pop()),
        )),
      ),
      child: Container(
        height: double.infinity,
        child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Container(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: <Widget>[
                    photoChange(),
                    nameChange(),
                    locationChange(),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
