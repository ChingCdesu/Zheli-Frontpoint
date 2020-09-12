import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zl_app/utils/device_size.dart';

import 'package:zl_app/pages/feminine_adornment/video.dart';
import 'package:zl_app/pages/feminine_adornment/object.dart';
import 'package:zl_app/pages/feminine_adornment/history.dart';

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
              image: AssetImage('images/slhz/bgc.png'),
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
                        'images/slhz/红妆物件.png',
                        '这里是鄣吴竹扇的制作流程，欢迎观看这里是鄣吴竹扇的制作流程，欢迎观看这里是鄣吴竹扇的制作流程，欢迎观看这里是鄣吴竹扇的制作流程，欢迎观看',
                        'images/slhz/bgc01.png',
                        FeminineAdornmentObject()),
                    myPage(
                        'images/slhz/宣传片.png',
                        '这里是鄣吴竹扇的制作流程，欢迎观看这里是鄣吴竹扇的制作流程，欢迎观看这里是鄣吴竹扇的制作流程，欢迎观看这里是鄣吴竹扇的制作流程，欢迎观看',
                        'images/slhz/bgc03.png',
                        FeminineAdornmentVideo()),
                    myPage(
                        'images/slhz/历史起源.png',
                        '这里是鄣吴竹扇的制作流程，欢迎观看这里是鄣吴竹扇的制作流程，欢迎观看这里是鄣吴竹扇的制作流程，欢迎观看这里是鄣吴竹扇的制作流程，欢迎观看',
                        'images/slhz/bgc02.png',
                        FeminineAdornmentHistory()),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/slhz/img_person.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: null,
                  ))
            ],
          )),
    );
  }

  Widget myPage(String title, String contant, String img, Widget route) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
      },
      child: Container(
        height: DeviceSize.getHeightByPercent(0.7),
        width: DeviceSize.getHeightByPercent(0.4),
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
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
                child: Image.asset(title)),
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
