import 'dart:ui';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:zl_app/pages/shadow_play/cinema.dart';
import 'package:zl_app/pages/shadow_play/history.dart';
import 'package:zl_app/pages/shadow_play/manufacture.dart';
import 'package:zl_app/pages/shadow_play/video.dart';

import 'package:zl_app/utils/device_size.dart';

class ShadowPlayMain extends StatefulWidget {
  ShadowPlayMain({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ShadowPlayMainState createState() => _ShadowPlayMainState();
}

class _ShadowPlayMainState extends State<ShadowPlayMain> {
  @override
  Widget build(BuildContext context) {
    DeviceSize.setDeviceSize(MediaQuery.of(context).size);
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset('images/pyzg/bgc.jpg', fit: BoxFit.cover),
            ),
          ),
          //back
          Positioned(
            top: 44,
            left: 10,
            child: Container(
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(top: 50),
              // height: 34,
              // width: 50,
              // height: DeviceSize.getHeightByPercent(0.9),
              // width: DeviceSize.getWidthByPercent(0.3),
              child: CupertinoButton(
                padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: Icon(
                  CupertinoIcons.back,
                  color: CupertinoColors.black,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ),
          ),
          //positing
          Positioned(
            top: 70,
            left: 320,
            child: Container(
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
                Icon(
                  IconData(0xe677, fontFamily: 'Schyler'),
                  color: CupertinoColors.black,
                ),
                Text(
                  '海宁',
                  style: TextStyle(fontSize: 16, color: CupertinoColors.black),
                ),
              ]),
            ),
          ),
          //content
          Positioned(
            left: 0,
            right: 0,
            top: 400,
            child: LikePageView(),
          ),
        ],
      ),
    );
  }
}

class LikePageView extends StatefulWidget {
  LikePageView({Key key}) : super(key: key);

  @override
  _LikePageViewState createState() => _LikePageViewState();
}

class _LikePageViewState extends State<LikePageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceSize.getHeightByPercent(1),
      // padding: EdgeInsets.all(20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          myCard2(
            'images/pyzg/bgc01.jpg',
            ' ',
            '浙江海宁市的海宁皮影戏是一门古老的传统艺术，最早诞生在两千年前的西汉，又称羊皮戏，是目前江南仅存的国家级非遗皮影戏艺术，具有典型的南宋风格。',
            null,
          ),
          myCard(
            'images/pyzg/bgc02.jpg',
            ' ',
            '在影院展里我们为你拉起黑布，只留皮影的光亮。你可以从这些图片里了解到许多有趣的皮影故事，比如三打白骨精，白蛇传等等。',
            ShadowPlayCinema(),
          ),
          myCard(
            'images/pyzg/bgc03.jpg',
            ' ',
            '在这里你可以看到整个皮影的制作过程。选皮｜制皮｜画稿｜过稿｜镂刻｜敷彩｜发汗熨平｜缎结完成。',
            ShadowPlayManufacture(),
          ),
          myCard(
            'images/pyzg/bgc04.jpg',
            ' ',
            '欣赏作品||倒马关。倒马关，位于河北唐县西北60公里的倒马关乡倒马关村，最初于战国时置，称鸿之塞。',
            ShadowPlayVideo(),
          ),
          myCard(
            'images/pyzg/bgc05.jpg',
            ' ',
            '海宁皮影戏又称“影子戏”或“灯影戏”,这个将皮影人偶借助灯光投影在幕布演绎的戏剧艺术形式，在民间被称为“手工电影”',
            ShadowPlayHistory(),
          ),
        ],
      ),
    );
  }

//所有的卡片
  Widget myCard(String img, String title, String text, Widget url) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 10, 10, 10),
      child: Container(
        padding: EdgeInsets.all(10),
        width: DeviceSize.getWidthByPercent(0.6), // width: 240,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(35),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CupertinoColors.systemGrey,
              offset: Offset(-2, 2),
              blurRadius: 6.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            //扩展按钮
            Expanded(
              flex: 1,
              child: CupertinoButton(
                padding: EdgeInsets.only(
                    top: DeviceSize.getWidthByPercent(0.7),
                    left: DeviceSize.getWidthByPercent(0.05)),
                child: Icon(
                  IconData(0xe623, fontFamily: 'Schyler'),
                  color: CupertinoColors.black,
                  size: 18,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return url;
                  }));
                },
              ),
            ),
            //文本介绍
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(top: 40),
                child: _verticalText(text, 12),
              ),
            ),
            //标题
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(top: 40, right: 20),
                child: _verticalText(title, 4),
              ),
            ),
          ],
        ),
      ),
    );
  }

//简介——没有按钮的卡片
  Widget myCard2(String img, String title, String text, Widget url) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 10, 10, 10),
      child: Container(
        padding: EdgeInsets.all(10),
        width: DeviceSize.getWidthByPercent(0.6), // width: 240,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(35),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CupertinoColors.systemGrey,
              offset: Offset(-2, 2),
              blurRadius: 6.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            //扩展按钮
            Expanded(
              flex: 1,
              child: Container(),
            ),
            //文本介绍
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(top: 40),
                child: _verticalText(text, 12),
              ),
            ),
            //标题
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(top: 40, right: 20),
                child: _verticalText(title, 4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _verticalText(String text, int maxLineCharacters) {
    List<Widget> ele = List<Widget>();
    for (var p = 0; p < text.length / maxLineCharacters; ++p) {
      ele.add(
        Container(
          padding: EdgeInsets.only(right: 1),
          child: _getALine(
            text.substring(
              maxLineCharacters * p,
              maxLineCharacters * p + min(maxLineCharacters, text.length - maxLineCharacters * p),
            ),
          ),
        ),
      );
    }
    return Container(
      child: Row(
        children: ele.reversed.toList(),
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }

  Widget _getALine(String text) {
    List<Widget> ele = List<Widget>();
    for (var p = 0; p < text.length; ++p) {
      ele.add(Text(
        text[p],
        style: TextStyle(fontSize: 16),
      ));
    }
    return Column(
      children: ele,
    );
  }
}
