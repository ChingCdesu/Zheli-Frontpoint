import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/api/models.dart' as API;

// import 'package:zl_app/pages/handcrafted_fan/video.dart';

import 'package:zl_app/utils/device_size.dart';
import 'package:zl_app/api/model_operations.dart' as API;

class HandcraftedFanMain extends StatefulWidget {
  HandcraftedFanMain({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HandcraftedFanMainState createState() => _HandcraftedFanMainState();
}

class _HandcraftedFanMainState extends State<HandcraftedFanMain> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: DeviceSize.getHeightByPercent(0.8),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(publicUrl + 'assets/handcrafted_fan/main/zwzs.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //back
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: DeviceSize.getHeightByPercent(0.108)),
                    width: DeviceSize.getWidthByPercent(0.12), // 50
                    child: CupertinoButton(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                      child: Icon(
                        CupertinoIcons.back,
                        color: CupertinoColors.white,
                        size: 28,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  //title
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        top: DeviceSize.getHeightByPercent(0.1),
                        left: DeviceSize.getWidthByPercent(0.06),
                        right: DeviceSize.getWidthByPercent(0.06)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '鄣吴竹扇',
                                  style: TextStyle(
                                      fontSize: 36,
                                      color: CupertinoColors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Zhang Wu Bamboo fan',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: CupertinoColors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              // padding: EdgeInsets.fromLTRB(60, 44, 0, 0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(
                                      IconData(0xe677, fontFamily: 'Schyler'),
                                      color: CupertinoColors.white,
                                    ),
                                    Text(
                                      '鄣吴',
                                      style: TextStyle(fontSize: 14, color: CupertinoColors.white),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                          child: Text(
                            '鄣吴镇鄣吴村是一代艺术大师吴昌硕先生故里，位于安吉县西北部。07年11月份原龙山村和鄣吴村合并,更名为鄣吴村，是鄣吴镇的中心自然村、政府驻地。全村以农业、制扇业经济为主，全村现有家庭工业40余家（其中制扇31家）。',
                            style: TextStyle(
                                fontSize: 12,
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: CardPage(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardPage extends StatefulWidget {
  CardPage({Key key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List<API.Video> _videos;

  @override
  void initState() {
    var _v = API.Video(parentModuleId: 3);
    API.Confirm(_v).doOperation().then((_o) {
      if (_o.hasError) {
        print(_o.log);
      } else {
        var _r = _o.getResult();
        var _l = _r['values'] as List<dynamic>;
        _l.forEach((element) {
          _v.id = element['ID'];
          API.Get(_v).doOperation().then((_) => _videos.add(_v));
        });
      }
    }).whenComplete(() => super.initState());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: CupertinoColors.systemGrey6,
                  offset: Offset.fromDirection(45, 10),
                  spreadRadius: 6,
                )
              ],
            ),
            padding: EdgeInsets.fromLTRB(18, 16, 0, 10),
            child: new Text(
              '微课视频',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                children: _getClasses(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getClasses() {
    List<Widget> _w = [];
    _videos.forEach(
      (v) {
        var _widget = Container(
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: CupertinoColors.systemGrey3,
                  offset: Offset.fromDirection(45, 10),
                  spreadRadius: 4)
            ],
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: CupertinoColors.systemGrey5,
          ),
          padding: EdgeInsets.fromLTRB(11, 0, 10, 0),
          margin: EdgeInsets.fromLTRB(16, 10, 14, 10),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Image.network(v.imageUrl),
                height: DeviceSize.getHeightByPercent(0.3), //110
                decoration: BoxDecoration(),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                width: DeviceSize.getWidthByPercent(0.52), //180
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      v.title,
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Text(
                        v.description,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: CupertinoButton(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(198, 204, 205, 1),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          width: DeviceSize.getWidthByPercent(0.16),
                          height: DeviceSize.getWidthByPercent(0.07),
                          child: Text(
                            '播放',
                            style: TextStyle(color: CupertinoColors.white, fontSize: 14),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/pages/handcrafted_fan/video');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
        _w.add(_widget);
      },
    );
    return _w;
  }
}
