import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// Todo: 添加图片到ImageLibrary
// Todo: 调整页面自适应
// Todo: 从参数content获取UI内容
class VideoPage extends StatefulWidget {
  VideoPage({Key key, this.video}) : super(key: key);
  final Video video;

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _videoPlayercontroller;
  ChewieController _chewieController;

  bool isLight = false;
  bool islikeLight = false;
  bool isdislikeLight = false;

  List<Widget> _getComments() {
    List<Widget> ret = List<Widget>();
    var comments = widget.video.comments;
    comments.forEach((_, element) {
      ret.insert(0, _getSingleComment(element));
    });
    return ret;
  }

  static Widget _getSingleComment(Comment comment) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(comment.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              comment.username,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 164,
                            ),
                            child: CupertinoButton(
                                padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                child: Icon(
                                  CupertinoIcons.heart_solid,
                                  color: comment.islike
                                      ? CupertinoColors.systemGrey4
                                      : CupertinoColors.destructiveRed,
                                ),
                                onPressed: () {
                                  //setState(() {
                                  comment.islike = !comment.islike;
                                  //});
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 240,
                      margin: EdgeInsets.only(left: 20, top: 0),
                      child: Text(
                        comment.contant,
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

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
    return CupertinoPageScaffold(
      child: SlidingUpPanel(
        minHeight: 370,
        maxHeight: 516,
        panel: Container(
          padding: EdgeInsets.only(top: 20, left: 16),
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(10, 00, 0, 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '评论',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 4, left: 6),
                        child: Text('(0)',
                            style: TextStyle(
                              fontSize: 14,
                            )),
                      ),
                    ],
                  )),
              Container(
                height: 462,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: _getComments(),
                  ),
                ),
              )
            ],
          ),
        ),
        borderRadius: BorderRadius.circular(35),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(235, 180, 113, 1),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.all(
                          //       Radius.circular(15.0),
                          //     ),
                          //     color: CupertinoColors.white),
                          margin: EdgeInsets.fromLTRB(6, 40, 0, 0),
                          //color: CupertinoColors.white,
                          height: 34,
                          width: 50,
                          child: CupertinoButton(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                              child: Icon(
                                CupertinoIcons.back,
                                //color: CupertinoColors.black,
                                color: CupertinoColors.white,
                                size: 28,
                              ),
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                );
                              }),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(15.0),
                              // ),
                              // color: Color.fromRGBO(182, 194, 154, 1)
                              ),
                          margin: EdgeInsets.fromLTRB(250, 40, 0, 0),
                          height: 34,
                          width: 50,
                          child: CupertinoButton(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                              child: Icon(
                                CupertinoIcons.tag,
                                color: CupertinoColors.white,
                              ),
                              onPressed: () {}),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              height: 86,
            ),
            Container(
              padding: EdgeInsets.all(0),
              height: 210,
              color: Color.fromRGBO(44, 44, 4, 1),
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            Container(
              //padding: EdgeInsets.only(top: 10),
              height: 512,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '视频简介',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 2, left: 14),
                              child: Text('舟山渔海-宣传片',
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                            ),
                            Container(
                                child: CupertinoButton(
                                    padding: EdgeInsets.fromLTRB(100, 10, 0, 0),
                                    child: Icon(
                                      CupertinoIcons.heart_solid,
                                      color: isLight
                                          ? CupertinoColors.systemGrey4
                                          : CupertinoColors.destructiveRed,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isLight = !isLight;
                                      });
                                    }))
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 4, 10, 10),
                      child: Text(
                        '视频内容：舟山市位于浙江深东北部，东临东海、西靠杭州湾、北面上海市，是环杭州湾大湾区核心城市、长江流域和���江三角洲对外开放的海上门户和通���，与亚太新兴港口城市……',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
