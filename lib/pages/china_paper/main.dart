import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:zl_app/pages/china_paper/manufacture.dart';
import 'package:zl_app/pages/china_paper/history.dart';

import 'package:zl_app/utils/device_size.dart';

class ChinaPaperMain extends StatefulWidget {
  ChinaPaperMain({Key key}) : super(key: key);

  @override
  _ChinaPaperMainState createState() => _ChinaPaperMainState();
}

class _ChinaPaperMainState extends State<ChinaPaperMain> {
  @override
  Widget build(BuildContext context) {
    DeviceSize.setDeviceSize(MediaQuery.of(context).size);
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Container(
            height: DeviceSize.getHeightByPercent(0.8),
            child: Image.asset(
              'images/fyzz/head.jpg',
              fit: BoxFit.fill,
            ),
          ),
          //back icon
          Positioned(
              left: DeviceSize.getWidthByPercent(0),
              top: DeviceSize.getHeightByPercent(0.11),
              child: CupertinoButton(
                padding: EdgeInsets.all(5),
                child: Icon(
                  CupertinoIcons.back,
                  color: CupertinoColors.black,
                  size: 24,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )),
          //card
          Positioned(
            left: 0,
            right: 0,
            top: 280,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CardPage(),
            ),
          ),
        ],
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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //title subtitle
                    Text(
                      '富阳竹纸',
                      style: TextStyle(
                          fontSize: 36, color: CupertinoColors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'The sea and fisheery',
                      style: TextStyle(
                          fontSize: 20, color: CupertinoColors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                //location
                Container(
                  padding: EdgeInsets.fromLTRB(50, 44, 0, 0),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
                    Icon(
                      IconData(0xe677, fontFamily: 'Schyler'),
                      color: CupertinoColors.black,
                    ),
                    Text(
                      '富阳',
                      style: TextStyle(fontSize: 14, color: CupertinoColors.black),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          //main introduce
          Container(
            padding: EdgeInsets.fromLTRB(30, 6, 40, 10),
            child: Text(
              '舟山市位于浙江省东北部，东临东海、西靠杭州湾、北面上海市，是环杭州湾大湾区核心城市、长江流域和长江三角洲对外开放的海上门户和通道，与亚太新兴港口城市呈扇形辐射之势。',
              style: TextStyle(
                  fontSize: 14, color: CupertinoColors.black, fontWeight: FontWeight.bold),
            ),
          ),
          //3card
          Column(
            children: <Widget>[
              getpyzgCard('制作过程', 'images/fyzz/bgc.png', ChinaPaperManufacture()),
              getpyzgCard('历史起源', 'images/fyzz/bgc.png', ChinaPaperHistory()),
            ],
          ),
        ],
      ),
    );
  }

//三个卡片的封装
  Widget getpyzgCard(String title, String img, Widget url) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 15),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: CupertinoColors.systemGrey,
            offset: Offset(2, 5),
            blurRadius: 12.0,
            spreadRadius: 0.0,
          )
        ],
        image: new DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
      height: DeviceSize.getHeightByPercent(0.2),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.all(5),
              child: Icon(
                CupertinoIcons.forward,
                color: CupertinoColors.black,
                size: 24,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return url;
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}
