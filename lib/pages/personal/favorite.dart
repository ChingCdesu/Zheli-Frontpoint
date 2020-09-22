// TODO: 完成此页面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:zl_app/utils/device_size.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: true,
        middle: Text('我的收藏'),
        border: Border(),
        padding: EdgeInsetsDirectional.only(
          end: DeviceSize.getWidthByPercent(0.02),
        ),
        backgroundColor: Colors.white,
        //trailing: this.trailing,
        leading: Container(
            //需要 用Material包裹IconButton 不然到第三个页面会报错
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
      child: Column(children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey5,
          ),
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView(
                // children: PocketInfo.getWidgets(),
                ),
          ),
        )),
      ]),
    );
  }
}
