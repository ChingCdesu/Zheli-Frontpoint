import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/utils/device_size.dart';

class ShadowPlayCinema extends StatefulWidget {
  ShadowPlayCinema({Key key}) : super(key: key);

  @override
  _ShadowPlayCinemaState createState() => _ShadowPlayCinemaState();
}

class _ShadowPlayCinemaState extends State<ShadowPlayCinema> {
  // TODO: like和favorite不能同时用一个变量
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
          padding: EdgeInsets.only(top: 50),
          color: Color.fromRGBO(50, 50, 50, 1),
          child: Column(
            children: <Widget>[
              //卡片
              Expanded(
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    placeListView('assets/images/shadow_play/cnm_01.png', '家里来了皮影戏'),
                    placeListView('assets/images/shadow_play/cnm_02.png', '老手艺人进行皮影戏演出'),
                    placeListView('assets/images/shadow_play/cnm_03.png', '亲手制作皮影戏纸偶'),
                    placeListView('assets/images/shadow_play/cnm_04.png', '与孩子一起体验皮影'),
                    placeListView('assets/images/shadow_play/cnm_05.png', '江南风格皮影戏纸偶'),
                    placeListView('assets/images/shadow_play/cnm_06.png', '西安一家商店里的皮影道具'),
                    placeListView('assets/images/shadow_play/cnm_07.png', '老手艺人进行皮影戏演出'),
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
          // buttom(),
        ],
      ),
    );
  }

  Widget buttom() {
    return Container(
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
                    ? IconData(0xe780, fontFamily: 'Schyler')
                    : IconData(0xe757, fontFamily: 'Schyler'),
                size: 50,
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
                    ? IconData(0xe779, fontFamily: 'Schyler')
                    : IconData(0xe745, fontFamily: 'Schyler'),
                size: 50,
                color: Colors.white,
              ),
              onPressed: () {
                favoriteImg();
              },
            ),
          ),
        ],
      ),
    );
  }
}
