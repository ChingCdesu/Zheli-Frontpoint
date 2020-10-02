import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/utils/device_size.dart';

class FeminineAdornmentMain extends StatefulWidget {
  FeminineAdornmentMain({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FeminineAdornmentMainState createState() => _FeminineAdornmentMainState();
}

class _FeminineAdornmentMainState extends State<FeminineAdornmentMain> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(publicUrl + 'assets/feminine_adornment/main/bgc.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // back
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: DeviceSize.getHeightByPercent(0.108)),
                width: DeviceSize.getWidthByPercent(0.12), // 50
                child: CupertinoButton(
                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Icon(
                    CupertinoIcons.back,
                    color: CupertinoColors.black,
                    size: 28,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                width: double.infinity,
                height: DeviceSize.getHeightByPercent(0.8),
                child: PageView(
                  controller: PageController(
                    initialPage: 1, //默认第一页开始
                    viewportFraction: 0.6,
                  ),
                  children: <Widget>[
                    myPage(
                        'assets/feminine_adornment/main/title_object.png',
                        '这些红妆器物马桶开道，花轿居中，棺材压阵，浩浩荡荡，绵延数里，生死一生，十里尽显。这些精雕细琢，髹朱漆金的红嫁妆被称为“十里红妆”，其造型的独特、工艺的精湛，极具华美的视觉效果，沉淀了数百年岁月的恍惚旧梦。',
                        'assets/feminine_adornment/main/bgc01.png',
                        '/pages/feminine_adornment/object'),
                    myPage(
                        'assets/feminine_adornment/main/title_video.png',
                        '十里红妆是以浙江省宁海县为主的浙东地区存在的一种传统婚俗，得名于当地嫁女时，所用的嫁妆从床铺家具到针头线脑一应俱全，从而迎送嫁妆的队伍经常从女家一直延伸到夫家，浩浩荡荡，绵延十里，故称“十里红妆”。',
                        'assets/feminine_adornment/main/bgc03.png',
                        '/pages/feminine_adornment/video'),
                    myPage(
                        'assets/feminine_adornment/main/title_history.png',
                        '红妆艺术是一种传统艺术，但它同时也展示了当时人们的一种文化态度、生活方式。旧时宁海大户富庶，才能负担起丰厚的嫁妆。新娘的嫁妆贵重与否决定了以后在夫家的地位。于是，小到针头线脑，大到婚床花轿、箱、柜、桌、椅、盆、桶、铜锡器，无一不是描龙画凤，样样齐全。',
                        'assets/feminine_adornment/main/bgc02.png',
                        '/pages/feminine_adornment/history'),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            publicUrl + 'assets/feminine_adornment/main/img_person.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: null,
                  ))
            ],
          )),
    );
  }

  Widget myPage(String title, String contant, String img, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        height: DeviceSize.getHeightByPercent(0.7),
        width: DeviceSize.getHeightByPercent(0.4),
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(publicUrl + img),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                color: CupertinoColors.systemGrey3,
                offset: Offset.fromDirection(45, 10),
                spreadRadius: 4)
          ],
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: CupertinoColors.white,
        ),
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                  top: 20,
                ),
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Image.network(publicUrl + title)),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                contant,
                //textAlign: TextAlign.center,  //字体居中
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
