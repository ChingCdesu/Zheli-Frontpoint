import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zl_app/utils/device_size.dart';

class FeminineAdornmentHistory extends StatefulWidget {
  FeminineAdornmentHistory({Key key}) : super(key: key);

  @override
  FeminineAdornmentHistoryState createState() => FeminineAdornmentHistoryState();
}

class FeminineAdornmentHistoryState extends State<FeminineAdornmentHistory> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: true,
        middle: Text('历史起源'),
        border: Border(),
        padding: EdgeInsetsDirectional.only(start: 0, end: 10, top: 0, bottom: 0),
        backgroundColor: Colors.white,
        leading: Container(
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
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/slhz/bgc_his.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
            height: double.infinity,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: DeviceSize.getHeightByPercent(0.04),
                ),
                imgtext('images/slhz/his02.jpg',
                    '十里红妆是以浙江省宁海县为主的浙东地区存在的一种传统婚俗，得名于当地嫁女时，所用的嫁妆从床铺家具到针头线脑一应俱全，从而迎送嫁妆的队伍经常从女家一直延伸到夫家，浩浩荡荡，绵延十里，故称“十里红妆”。'),
                imgtext('images/slhz/his03.jpg',
                    '十里红妆的婚俗始于南宋，盛于明清时期。由于经济的富庶，当地富户在嫁女之时，希望女儿在夫家有地位，同时炫耀自家的财富。十里红妆的嫁妆主要为内房用具，与女性的生活相关，多为婚床、箱奁、脚桶、针头线脑等日常生活用具和新娘一生的服饰和内房布置。'),
                imgtext('images/slhz/his04.jpg',
                    '如今十里红妆的热闹场面已成为历史，承传了千百年的妇女境况已彻底改变，曾让古代妇女哭过、恨过、爱过和荣耀过的一切生活方式和生活空间都成为了历史的足迹。十里红妆为研究江南地区婚俗文化提供了实证，是中国传统文化重要的组成部分，同时具有民俗学、社会学以及历史、艺术、人类学等多方面的重要意义。'),
                imgtext('images/slhz/his05.jpg',
                    '一般人家的嫁妆常有近百件，而大户人家能够做到千件不重复，更有“千工床、万工轿”之说。人们常用“良田千亩，十里红妆”形容嫁妆的丰厚。十里红妆规模声势之大，数量之多，门类之齐全，制作工艺之精湛，艺术价值之高，耗费之昂贵，均为全国罕见。'),
              ],
            ),
          )),
    );
  }

  Widget imgtext(String img, String text) {
    return Column(
      children: <Widget>[
        Container(
          child: Image.asset(img),
        ),
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            text,
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
