import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:zl_app/pages/sea_culture/cinema.dart';
import 'package:zl_app/pages/sea_culture/video.dart';

import 'package:zl_app/utils/device_size.dart';

class SeaCultureMain extends StatefulWidget {
  SeaCultureMain({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SeaCultureMainState createState() => _SeaCultureMainState();
}

class _SeaCultureMainState extends State<SeaCultureMain> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/zsyh/bgc.png'), fit: BoxFit.fill),
        ),
        child: Stack(
          children: <Widget>[
            //拉动+卡片+按钮
            SlidingUpPanel(
              minHeight: DeviceSize.getHeightByPercent(0.5), // minHeight: 200,
              maxHeight: DeviceSize.getHeightByPercent(1), // maxHeight: 400,
              slideDirection: SlideDirection.DOWN,
              borderRadius: BorderRadius.circular(35),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: CupertinoColors.systemGrey,
                  offset: Offset(2, 5),
                  blurRadius: 12.0,
                  spreadRadius: 0.0,
                ),
              ],
              //上拉
              panel: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 30, left: 30, right: 30),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '舟山市位于浙江省东北部，东临东海、西靠杭州湾、北面上海市，是环杭州湾大湾区核心城市、长江流域和长江三角洲对外开放的海上门户和通道，与亚太新兴港口城市呈扇形辐射之势。',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 0, top: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //左边的title
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '舟山渔海',
                                    style: TextStyle(fontSize: 35),
                                  ),
                                  Text(
                                    'FISHERY ZHOUSHAN',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            //右边的position
                            Container(
                              margin: EdgeInsets.only(top: 45, left: 50),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    IconData(0xe677, fontFamily: 'Schyler'),
                                    color: Colors.black,
                                  ),
                                  Text('舟山'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //除了上拉部分
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //重叠式卡片
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: CupertinoColors.systemGrey,
                          offset: Offset(4, 5),
                          blurRadius: 12.0,
                          spreadRadius: 0.0,
                        )
                      ],
                      image: DecorationImage(
                        image: AssetImage('images/zsyh/fishdraw.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    height: DeviceSize.getHeightByPercent(0.96), // height: 400,
                    width: DeviceSize.getWidthByPercent(0.76), // width: 320,
                    margin: EdgeInsets.only(top: 100),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 80,
                                bottom: 40,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(0, 255, 255, 255),
                                    Color.fromARGB((0.3 * 255).floor(), 255, 255, 255),
                                    Color.fromARGB(255, 255, 255, 255),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  // center: Alignment.bottomCenter,
                                  // radius: 2,
                                  stops: [0, 0.15, 0.4],
                                ),
                              ),
                              child: Align(
                                heightFactor: 0,
                                alignment: Alignment.center,
                                child: Text("舟山传统工艺——渔民画"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //播放按钮
                  CupertinoButton(
                      child: Container(
                        height: 55,
                        width: 55,
                        margin: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: CupertinoColors.systemGrey,
                              offset: Offset(3, 5),
                              blurRadius: 8.0,
                              spreadRadius: 0.0,
                            )
                          ],
                          image: DecorationImage(
                            image: AssetImage('images/zsyh/播放.png'),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return SeaCultureCinema();
                        }));
                      }),
                ],
              ),
            ),
            //波浪花纹
            Container(
              height: DeviceSize.getHeightByPercent(0.3), // height: 120,
              margin: EdgeInsets.only(left: 50),
              decoration: BoxDecoration(
                // color: Colors.red,
                image:
                    DecorationImage(image: AssetImage('images/zsyh/bgc01.png'), fit: BoxFit.cover),
              ),
            ),
            // 返回按钮
            Container(
              padding: EdgeInsets.only(
                  left: DeviceSize.getWidthByPercent(0), top: DeviceSize.getHeightByPercent(0.11)),
              child: CupertinoButton(
                padding: EdgeInsets.all(5),
                child: Icon(
                  CupertinoIcons.back,
                  color: CupertinoColors.black,
                  size: 24,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
