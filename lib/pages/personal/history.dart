import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/api/interfaces.dart';

import 'package:zl_app/api/model_operations.dart' as API;
import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/pages/video_page.dart';
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
  List<API.History> _histories = new List();
  List<API.Video> _videoInfos = new List();

  Future _getHistories() async {
    var operation = await API.Confirm(new API.History(userId: Account.userId)).doOperation();
    if (operation.hasError) throw ErrorDescription(operation.log);
    var _s = operation.getResult()['values'] as List<dynamic>;
    for (var e in _s) {
      API.History _h;
      API.Video _v;
      operation = await API.Get(new API.History(id: e['ID'])).doOperation();
      if (operation.hasError) throw ErrorDescription(operation.log);
      _h = operation.getResult();
      _histories.add(_h);
      _v = API.Video(id: _h.videoId);
      operation = await API.Get(_v).doOperation();

      if (operation.hasError) throw ErrorDescription(operation.log);
      _v = operation.getResult();
      _videoInfos.add(_v);
    }
  }

  @override
  void initState() {
    super.initState();
    _getHistories().catchError((e) {
      print(e);
    }).whenComplete(() {
      print(_histories);
      setState(() {});
    });
  }

  List<Widget> _render() {
    List<Widget> _r = [];
    for (var i = 0; i < _histories.length; i++) {
      _r.add(_getSingleHistory(_histories[i], _videoInfos[i]));
    }
    return _r;
  }

  Widget _getSingleHistory(API.History history, API.Video video) {
    return GestureDetector(
      child: Container(
        height: 80,
        margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
        decoration: BoxDecoration(
            //color: CupertinoColors.systemGrey5,
            ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.network(publicUrl + video.imageUrl),
              width: 150,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 4),
              width: 154,
              child: Text(
                video.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () async {
        VideoArguments.videoInfo = video;
        VideoArguments.comments = await getCommentsByVideoIdAsync(video.id);
        Navigator.pushNamed(context, '/video');
      },
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
              child: ListView(children: _render()),
            ),
          ),
        ],
      ),
    );
  }
}
