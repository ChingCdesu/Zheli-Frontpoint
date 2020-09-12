import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChinaPaperManufacture extends StatefulWidget {
  ChinaPaperManufacture({Key key}) : super(key: key);

  @override
  _ChinaPaperManufactureState createState() => _ChinaPaperManufactureState();
}

class _ChinaPaperManufactureState extends State<ChinaPaperManufacture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(165, 175, 142, 1),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            //pageview
            Container(
              child: Container(
                alignment: Alignment.center,
                child: ContainPageview(),
              ),
            ),
            //底部文字
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '向右滑动查看制作过程 >>',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            //返回图标
            CupertinoButton(
              child: Icon(
                CupertinoIcons.back,
                color: CupertinoColors.black,
                size: 24,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//pageview的类
class ContainPageview extends StatefulWidget {
  ContainPageview({Key key}) : super(key: key);

  @override
  _ContainPageviewState createState() => _ContainPageviewState();
}

class _ContainPageviewState extends State<ContainPageview> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        contain('images/fyzz/process01.png'),
        contain('images/fyzz/process02.png'),
        contain('images/fyzz/process03.png'),
        contain('images/fyzz/process04.png'),
        contain('images/fyzz/process05.png'),
      ],
    );
  }

  Widget contain(String img) {
    return Container(
      padding: EdgeInsets.all(5),
      // child: Image.asset(img),
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover)),
    );
  }
}
