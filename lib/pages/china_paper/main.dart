import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zl_app/api/dio_singleton.dart';

import 'package:zl_app/utils/device_size.dart';
import 'package:zl_app/api/interfaces.dart';
import 'package:zl_app/api/models.dart' as API;

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
            // child: Image.network(
            //   publicUrl + 'assets/china_paper/main/head.jpg',
            //   fit: BoxFit.fill,
            // ),
            child: Image.asset('assets/images/china_paper/head.jpg'),
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
                      'china paper',
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
                      IconData(0xe75a, fontFamily: 'Schyler'),
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
              '富阳竹纸始于魏晋南北朝时期（317-581）。以世代相传，迄今已有一千多年。清光绪《富阳县志》记载：“邑人率造纸为业，老少勤做，昼夜不休”、“富阳竹纸一项每年约可博六七十万金”。',
              style: TextStyle(
                  fontSize: 14, color: CupertinoColors.black, fontWeight: FontWeight.bold),
            ),
          ),
          //3card
          Column(
            children: <Widget>[
              getpyzgCard(
                  '制作过程', 'assets/images/china_paper/bgc.png', '/pages/china_paper/manufacture'),
              getpyzgCard(
                  '历史起源', 'assets/images/china_paper/bgc.png', '/pages/china_paper/history'),
            ],
          ),
        ],
      ),
    );
  }

//三个卡片的封装
  Widget getpyzgCard(String title, String img, String url) {
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
          //image: NetworkImage(publicUrl + img),
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
                Navigator.pushNamed(context, url);
              },
            ),
          ),
        ],
      ),
    );
  }
}
