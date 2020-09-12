import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:zl_app/api/model_operations.dart' as API;
import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/settings/user.dart';

// Todo: 添加图片到ImageLibrary
// Todo: 调整页面自适应
// Todo: 从参数content获取UI内容
class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<List<Widget>> _getHistories() async {
    List<Widget> ret = List<Widget>();
    var operation = await API.Get(new API.History(userId: Account.userId)).doOperation();
    if (!operation.hasError) {
      operation.getResult().forEach((history) {
        ret.add(_getSingleHistory());
      });
    } else {
      print(operation.log);
    }
    // var reversedHistories = reversedHistories.forEach((history) {
    //   ret.add(_getSingleHistory(history));
    // });
    return ret;
  }

  static Widget _getSingleHistory(API.History history) {
    return Container(
      height: 80,
      margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
      decoration: BoxDecoration(
          //color: CupertinoColors.systemGrey5,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.asset(history.video.image),
            width: 150,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 4),
            width: 154,
            child: Text(
              history.video.title,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: CupertinoColors.white,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(6, 40, 0, 0),
                        height: 34,
                        width: 50,
                        child: CupertinoButton(
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              CupertinoIcons.back,
                              color: CupertinoColors.black,
                              size: 28,
                            ),
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            }),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.fromLTRB(0, 46, 0, 0),
                        child: Text(
                          '历史记录',
                          style: TextStyle(
                              fontSize: 20,
                              color: CupertinoColors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        margin: EdgeInsets.fromLTRB(0, 40, 6, 0),
                        height: 34,
                        width: 50,
                        child: CupertinoButton(
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              CupertinoIcons.tag,
                              color: CupertinoColors.black,
                            ),
                            onPressed: () {}),
                      )
                    ],
                  ),
                ),
              ],
            ),
            height: 86,
          ),
          Container(
            height: 726,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(children: _getHistories()),
            ),
          ),
        ],
      ),
    );
  }
}
