import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/api/interfaces.dart';
import 'package:zl_app/pages/video_page.dart';
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
  List<API.Video> _vs = new List();
  @override
  void initState() {
    super.initState();
    var _f = new API.Favorite(userId: Account.userId);
    API.Confirm(_f).doOperation().then((_o) async {
      if (_o.hasError) {
        print(_o.log);
        return;
      }
      var _r = _o.getResult()['values'];
      for (var item in _r) {
        var id = item['ID'] as int;
        _f = new API.Favorite(id: id);
        var operation = await API.Get(_f).doOperation();
        _f = operation.getResult();
        _fs.add(_f);
        var _v = new API.Video(id: _f.videoId);
        operation = await API.Get(_v).doOperation();
        _vs.add(operation.getResult() as API.Video);
      }
    }).whenComplete(() => setState(() {}));
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
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey5,
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                  itemCount: _vs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: DeviceSize.getHeightByPercent(0.28),
                        margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: new BorderRadius.circular((14.0)),
                        ),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Image.network(
                                    publicUrl + _vs[index].imageUrl,
                                    fit: BoxFit.cover,
                                  ),

                                  // Positioned(
                                  //   top: 52,
                                  //   left: 114,
                                  //   child: Container(
                                  //     alignment: Alignment.center,
                                  //     width: DeviceSize.getWidthByPercent(0.09),
                                  //     decoration: BoxDecoration(
                                  //       color: Color.fromRGBO(59, 59, 59, 0.6),
                                  //       borderRadius: new BorderRadius.circular((2.0)),
                                  //     ),
                                  //     child: Text(
                                  //       _fs[index].currentTime,
                                  //       style: TextStyle(fontSize: 10, color: CupertinoColors.white),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              width: DeviceSize.getWidthByPercent(0.35),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(10, 16, 0, 4),
                              width: DeviceSize.getWidthByPercent(0.44),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    _vs[index].title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: <Widget>[
                                  //     Container(
                                  //       alignment: Alignment.center,
                                  //       width: DeviceSize.getWidthByPercent(0.07),
                                  //       decoration: BoxDecoration(
                                  //         color: CupertinoColors.systemGrey,
                                  //         borderRadius: new BorderRadius.circular((2.0)),
                                  //       ),
                                  //       child: Text(
                                  //         "pockets.form",
                                  //         style:
                                  //             TextStyle(fontSize: 10, color: CupertinoColors.white),
                                  //       ),
                                  //     ),
                                  //     CupertinoButton(
                                  //       padding: EdgeInsets.all(0),
                                  //       child: Icon(
                                  //         IconData(0xe666, fontFamily: 'Schyler'),
                                  //         color: CupertinoColors.systemGrey,
                                  //       ),
                                  //       onPressed: () {},
                                  //     )
                                  //   ],
                                  // )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () async {
                        VideoArguments.videoInfo = _vs[index];
                        VideoArguments.comments = await getCommentsByVideoIdAsync(_vs[index].id);
                        Navigator.pushNamed(context, '/video');
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
