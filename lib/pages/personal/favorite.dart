import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zl_app/settings/user.dart';

import 'package:zl_app/utils/device_size.dart';

import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/api/model_operations.dart' as API;

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<API.Favorite> _fs = new List<API.Favorite>();

  @override
  void initState() {
    var _f = new API.Favorite(userId: Account.userId);
    API.Confirm(_f).doOperation().then((_o) {
      if (_o.hasError) {
        print(_o.log);
        return;
      }
      var _r = _o.getResult()['values'];
      for (var item in _r) {
        var id = item['ID'] as int;
        _f = new API.Favorite(id: id);
        API.Get(_f).doOperation().then((_) {
          _fs.add(_f);
        });
      }
    }).whenComplete(() => super.initState());
  }

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
