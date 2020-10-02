import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/utils/device_size.dart';

class SeaCultureCinema extends StatefulWidget {
  SeaCultureCinema({Key key}) : super(key: key);

  @override
  _SeaCultureCinemaState createState() => _SeaCultureCinemaState();
}

class _SeaCultureCinemaState extends State<SeaCultureCinema> {
  bool like = false;
  bool favorite = false;
  void likeImg() {
    setState(() {
      like = !like;
    });
  }

  void favoriteImg() {
    setState(() {
      favorite = !favorite;
    });
  }

  PageController pageController;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
          automaticallyImplyMiddle: true,
          middle: Text(
            '影院展',
            style: TextStyle(color: CupertinoColors.white, fontSize: 20),
          ),
          border: Border(),
          padding: EdgeInsetsDirectional.only(
            end: DeviceSize.getWidthByPercent(0.02),
          ),
          backgroundColor: Color.fromRGBO(50, 50, 50, 1),
          //trailing: this.trailing,
          leading: Container(
              child: Material(
            color: Colors.transparent,
            child: CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Icon(
                  CupertinoIcons.back,
                  color: CupertinoColors.white,
                  size: 25,
                ),
                onPressed: () => Navigator.of(context).pop()),
          )),
        ),
        child: Container(
          color: Color.fromRGBO(50, 50, 50, 1),
          child: Column(
            children: <Widget>[
              //卡片
              Expanded(
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    placeListView('assets/sea_culture/360°2.gif', '360°船模展示'),
                    placeListView('assets/sea_culture/360°3.gif', '360°船模展示'),
                    placeListView('assets/sea_culture/360°1.gif', '360°船模展示'),
                    placeListView('assets/sea_culture/cnm_01.jpg', '舟山海景'),
                    placeListView('assets/sea_culture/cnm_02.png', '舟山渔民在码头舞龙祈福'),
                    placeListView('assets/sea_culture/cnm_03.png', '舟山渔港'),
                    placeListView('assets/sea_culture/cnm_04.png', '舟山群岛'),
                    placeListView('assets/sea_culture/cnm_05.png', '手艺人在编织渔绳结'),
                    placeListView('assets/sea_culture/cnm_06.png', '海雾笼罩中的舟山城'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget placeListView(String img, String title) {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              //font
              Container(
                width: DeviceSize.getWidthByPercent(0.82), // width: 340,
                height: DeviceSize.getHeightByPercent(1), // height: 410,
                margin: EdgeInsets.only(top: 80, left: 20, right: 20),
                padding: EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(title),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(227, 212, 184, 1),
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
              //image
              Container(
                margin: EdgeInsets.only(top: 80, left: 20, right: 20),
                width: DeviceSize.getWidthByPercent(0.82),
                height: DeviceSize.getHeightByPercent(0.8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CupertinoColors.black,
                      offset: Offset(0, 4),
                      blurRadius: 15.0,
                      spreadRadius: 0.0,
                    )
                  ],
                  image: DecorationImage(
                    // image: NetworkImage(
                    //   publicUrl + img,
                    // ),
                    image: AssetImage(img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          //按钮
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: CupertinoButton(
                    child: Icon(
                      like
                          ? IconData(0xebaa, fontFamily: 'Schyler')
                          : IconData(0xeb97, fontFamily: 'Schyler'),
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      likeImg();
                    },
                  ),
                ),
                Container(
                  child: CupertinoButton(
                    child: Icon(
                      favorite
                          ? IconData(0xe68a, fontFamily: 'Schyler')
                          : IconData(0xe672, fontFamily: 'Schyler'),
                      size: 42,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      favoriteImg();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
