import 'dart:ui';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/api/interfaces.dart';
import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/api/model_operations.dart' as API;

// import 'package:zl_app/pages/sea_culture/cinema.dart';
// import 'package:zl_app/pages/sea_culture/video.dart';

import 'package:zl_app/utils/device_size.dart';
import 'data.dart';

List<API.Video> _vs = new List();

class SeaCultureMain extends StatefulWidget {
  SeaCultureMain({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SeaCultureMainState createState() => _SeaCultureMainState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _SeaCultureMainState extends State<SeaCultureMain> {
  var currentPage = images.length - 1.0;

  @override
  void initState() {
    super.initState();
    getVideosByModuleIdAsync(1)
        .then((value) => _vs = value.reversed.toList())
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
        print(currentPage.floor());
      });
    });
    return CupertinoPageScaffold(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            //image: NetworkImage(publicUrl + 'assets/sea_culture/main/bgc.png'),
            image: AssetImage('assets/images/sea_culture/bgc.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: <Widget>[
            //拉动+卡片+按钮
            SlidingUpPanel(
              minHeight: DeviceSize.getHeightByPercent(0.5), // minHeight: 200,
              maxHeight: DeviceSize.getHeightByPercent(0.8), // maxHeight: 400,
              slideDirection: SlideDirection.DOWN,
              borderRadius: BorderRadius.circular(35),
              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //     color: CupertinoColors.systemGrey,
              //     offset: Offset(2, 5),
              //     blurRadius: 12.0,
              //     spreadRadius: 0.0,
              //   ),
              // ],
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
                        padding: EdgeInsets.only(bottom: 30, left: 50, right: 50),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '舟山市位于浙江省东北部，东临东海、西靠杭州湾、北面上海市，是长江流域和长江三角洲对外开放的海上门户和通道。',
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
                              margin: EdgeInsets.only(top: 5),
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
                                    IconData(0xe75a, fontFamily: 'Schyler'),
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
                  SizedBox(
                    height: DeviceSize.getHeightByPercent(0.3),
                  ),
                  Stack(
                    children: <Widget>[
                      CardScrollWidget(currentPage),
                      Positioned.fill(
                        child: PageView.builder(
                          itemCount: images.length,
                          controller: controller,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Container();
                          },
                        ),
                      )
                    ],
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
                            // BoxShadow(
                            //   color: CupertinoColors.systemGrey,
                            //   offset: Offset(3, 5),
                            //   blurRadius: 8.0,
                            //   spreadRadius: 0.0,
                            // )
                          ],
                          image: DecorationImage(
                              //image: NetworkImage(publicUrl + 'assets/sea_culture/main/播放.png'),
                              image: AssetImage('assets/images/sea_culture/play.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/pages/sea_culture/video',
                            arguments: _vs[currentPage.floor()]);
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
                image: DecorationImage(
                  //image: NetworkImage(publicUrl + 'assets/sea_culture/main/bgc01.png'),
                  image: AssetImage('assets/images/sea_culture/bgc01.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 返回按钮
            Container(
              padding: EdgeInsets.only(
                left: DeviceSize.getWidthByPercent(0),
                top: DeviceSize.getHeightByPercent(0.11),
              ),
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

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start =
              padding + max(primaryCardLeft - horizontalInset * -delta * (isOnRight ? 15 : 1), 0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(color: Colors.black12, offset: Offset(3.0, 6.0), blurRadius: 10.0)
                  // ],
                ),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.network(
                        publicUrl + _vs[i].imageUrl,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Text(
                                _vs[i].title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: "SF-Pro-Text-Regular"),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                            //     decoration: BoxDecoration(
                            //         color: Colors.blueAccent,
                            //         borderRadius: BorderRadius.circular(20.0)),
                            //     child: Text("Read Later", style: TextStyle(color: Colors.white)),
                            //   ),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
