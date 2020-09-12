import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zl_app/settings/user.dart';
import 'package:zl_app/utils/device_size.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/api/model_operations.dart' as API;

class ShadowPlayVideo extends StatefulWidget {
  ShadowPlayVideo({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ShadowPlayVideoState createState() => _ShadowPlayVideoState();
}

class _ShadowPlayVideoState extends State<ShadowPlayVideo> {
  VideoPlayerController _videoPlayercontroller;
  ChewieController _chewieController;

  var isLight = false;
  var islikeLight = false;
  var isdislikeLight = false;

  API.Video _videoInfo;
  int favId;

  @override
  void initState() {
    super.initState();
    _videoPlayercontroller = VideoPlayerController.asset('video/zsyh01.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayercontroller,
      autoPlay: true,
      aspectRatio: 16 / 9.0,
    );
  }

  @override
  void dispose() {
    _videoPlayercontroller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeviceSize.setDeviceSize(MediaQuery.of(context).size);
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
          automaticallyImplyMiddle: true,
          border: Border(),
          backgroundColor: Colors.white,
          padding: EdgeInsetsDirectional.only(
            end: DeviceSize.getWidthByPercent(0.02),
          ),
          //trailing: this.trailing,
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
        child: Stack(children: <Widget>[
          Column(children: [
            //视频播放
            Container(
              padding: EdgeInsets.all(0),
              color: Color.fromRGBO(44, 44, 4, 1),
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            //评论
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  //评论列表
                  Expanded(
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: Container(
                        margin: EdgeInsets.only(bottom: DeviceSize.getHeightByPercent(0.2)),
                        child: ListView(
                          children: <Widget>[
                            //视频简介
                            Container(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(
                                    left: DeviceSize.getWidthByPercent(0.02),
                                    right: DeviceSize.getWidthByPercent(0.02)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: DeviceSize.getWidthByPercent(0.02)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                new Text(
                                                  '视频简介',
                                                  style: TextStyle(
                                                      fontSize: 20, fontWeight: FontWeight.bold),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: DeviceSize.getWidthByPercent(0.04)),
                                                  child: new Text('皮影之光 -《盗马关》作品展示',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: CupertinoButton(
                                                // padding: EdgeInsets.fromLTRB(
                                                //     105, 15, 0, 0),
                                                child: Icon(
                                                  isLight
                                                      ? IconData(0xe68a, fontFamily: 'Schyler')
                                                      : IconData(0xe672, fontFamily: 'Schyler'),
                                                  color: isLight
                                                      ? CupertinoColors.systemYellow
                                                      : CupertinoColors.systemGrey4,
                                                ),
                                                onPressed: () {
                                                  setState(() async {
                                                    isLight = !isLight;
                                                    if (isLight) {
                                                      var _f = API.Favorite(
                                                        userId: Account.userId,
                                                        videoId: this._videoInfo.id,
                                                      );
                                                      var _o = await API.Create(_f).doOperation();
                                                      if (_o.hasError) {
                                                        print(_o.log);
                                                      }
                                                    } else {
                                                      var _o =
                                                          await API.Destory(API.Favorite(id: favId))
                                                              .doOperation();
                                                      if (_o.hasError) {
                                                        print(_o.log);
                                                      }
                                                    }
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 4, 10, 10),
                                      child: new Text(
                                        '视频内容：皮影戏，起源于西汉时期，是中国民间古老的传统艺术，通过灯光，将皮影人偶投影在幕布上来演绎戏剧，2011年，中国皮影戏更是入选人类非物质文化遗产代表作名录。《盗马关》则是皮影的一个经典剧目。',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //评论
                            Container(
                              padding: EdgeInsets.only(
                                left: DeviceSize.getWidthByPercent(0.05),
                              ),
                              child: Row(
                                children: <Widget>[
                                  new Text(
                                    '评论',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: DeviceSize.getWidthByPercent(0.02)),
                                    child: new Text(
                                      '(0)',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 10,
                left: 10,
                right: 10,
                top: 8,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black26,
                    width: 1.0,
                  ),
                ),
                color: Colors.white,
              ),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: CupertinoTextField(
                        padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.black12,
                        ),
                        cursorColor: CupertinoColors.activeBlue,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CupertinoButton(
                        child: Text(
                          "发送",
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                        onPressed: () {},
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
