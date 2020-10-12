import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zl_app/api/dio_singleton.dart';

class FeminineAdornmentObject extends StatefulWidget {
  FeminineAdornmentObject({Key key}) : super(key: key);

  @override
  _FeminineAdornmentObjectState createState() => _FeminineAdornmentObjectState();
}

class _FeminineAdornmentObjectState extends State<FeminineAdornmentObject> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(200, 173, 174, 1),
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
                '向右滑动查看红妆物件 >>',
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
        contain('assets/images/feminine_adornment/object01.png'),
        contain('assets/images/feminine_adornment/object02.png'),
        contain('assets/images/feminine_adornment/object03.png'),
        contain('assets/images/feminine_adornment/object04.png'),
      ],
    );
  }

  Widget contain(String img) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          image: DecorationImage(
              // image: NetworkImage(publicUrl + img),
              image: AssetImage(img),
              fit: BoxFit.cover)),
    );
  }
}
