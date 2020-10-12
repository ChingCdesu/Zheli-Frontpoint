import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zl_app/api/interfaces.dart';
import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/api/model_operations.dart' as API;
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/settings/user.dart';
import 'package:zl_app/utils/device_size.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  _VideoPageState();
  VideoPlayerController _videoPlayercontroller;
  ChewieController _chewieController;

  var isLight = false;
  var islikeLight = false;
  var isdislikeLight = false;

  FocusNode _fnComment;
  TextEditingController _txController;

  // API.Video _videoInfo;
  // List<VideoCommentUserView> _comments = List();
  int favId;

  @override
  void initState() {
    super.initState();
    // _videoInfo = ModalRoute.of(context).settings.arguments;
    // getCommentsByVideoIdAsync(_videoInfo.id)
    //     .then((comments) => _comments.addAll(comments as List<VideoCommentUserView>))
    //     .whenComplete(() => setState(() {}));
    _fnComment = FocusNode();
    _txController = TextEditingController();
    print(VideoArguments.comments);
    print(VideoArguments.videoInfo);
    var _videoInfo = VideoArguments.videoInfo;

    _videoPlayercontroller = VideoPlayerController.network(publicUrl + _videoInfo.videoUrl);
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
    _fnComment.dispose();
    _txController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _videoInfo = VideoArguments.videoInfo;
    var _comments = VideoArguments.comments;
    String comment = "";
    // DeviceSize.setDeviceSize(MediaQuery.of(context).size);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: true,
        border: Border(),
        backgroundColor: Colors.white,
        padding: EdgeInsetsDirectional.only(
          end: DeviceSize.getWidthByPercent(0.02),
        ),
        // trailing: this.trailing,
        middle: Text(
          _videoInfo.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
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
              onPressed: () async {
                API.History _h = API.History(
                  userId: Account.userId,
                  videoId: _videoInfo.id,
                );
                var _o = await API.Confirm(_h).doOperation();
                _h.currentTime = _videoPlayercontroller.value.position.inSeconds;
                if (_o.retCode == 21) {
                  // 没有历史记录
                  _o = await API.Create(_h).doOperation();
                  if (_o.hasError) {
                    print(_o.log);
                    Account.localHistory.add(_h);
                  }
                } else if (_o.retCode != 0) {
                  // 出现错误
                  print(_o.log);
                  Account.localHistory.add(_h);
                } else {
                  // 未出现错误, 且有该记录
                  var _res = _o.getResult();
                  var _record_id = _res['values'][0]['ID'];
                  _o = await API.Update(_h).doOperation();
                  if (_o.hasError) {
                    print(_o.log);
                    Account.localHistory.add(_h);
                  }
                }
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            children: [
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
                                                  child: new Text(
                                                    _videoInfo.title,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: CupertinoButton(
                                                // padding: EdgeInsets.fromLTRB(
                                                //     105, 15, 0, 0),
                                                child: Icon(
                                                  isLight
                                                      ? IconData(0xe79e, fontFamily: 'Schyler')
                                                      : IconData(0xe79d, fontFamily: 'Schyler'),
                                                  color: isLight
                                                      ? CupertinoColors.systemYellow
                                                      : CupertinoColors.systemGrey4,
                                                ),
                                                onPressed: () {
                                                  if (this.mounted) {
                                                    setState(() {
                                                      isLight = !isLight;
                                                      // if (isLight) {
                                                      //   var _f = API.Favorite(
                                                      //       userId: Account.userId,
                                                      //       videoId: _videoInfo.id);
                                                      //   var _o = await API.Create(_f).doOperation();
                                                      //   if (_o.hasError) {
                                                      //     print(_o.log);
                                                      //   }
                                                      // } else {
                                                      //   var _o = await API.Destory(
                                                      //           API.Favorite(id: favId))
                                                      //       .doOperation();
                                                      //   if (_o.hasError) {
                                                      //     print(_o.log);
                                                      //   }
                                                      // }
                                                    });
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(10, 4, 10, 10),
                                        child: new Text(
                                          _videoInfo.description,
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
                                        '(${_comments.length})',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //评论列表
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: ListView.builder(
                                  itemCount: _comments.length,
                                  shrinkWrap: true,
                                  physics: RangeMaintainingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      width: DeviceSize.getWidthByPercent(1.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(publicUrl +
                                                      _comments[index].user.avatar), //头像?
                                                ),
                                              ),
                                              Expanded(
                                                flex: 6,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      // alignment: Alignment.topLeft,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            // alignment: Alignment.topLeft,
                                                            margin: EdgeInsets.only(left: 20),
                                                            child: new Text(
                                                              _comments[index].user.username, //用户名
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Container(
                                                      // width: DeviceSize.getWidthByPercent(0.64),
                                                      margin: EdgeInsets.only(left: 20, top: 0),
                                                      child: new Text(
                                                        _comments[index].comment.comment, //评论
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
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
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          //输入框
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
                        onChanged: (value) => comment = value,
                        focusNode: _fnComment,
                        controller: _txController,
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
                        onPressed: () {
                          if (comment.length != 0 && this.mounted) {
                            setState(() {
                              var newComment = VideoCommentUserView();
                              newComment.user = API.User(
                                id: Account.userId,
                                avatar: Account.avatarPath,
                                username: Account.username,
                              );
                              newComment.video = _videoInfo;

                              newComment.comment = API.VideoComment(
                                  comment: comment, userId: Account.userId, videoId: _videoInfo.id);
                              VideoArguments.comments.add(newComment);
                              _fnComment.unfocus();
                              _txController.clear();
                            });
                          }
                        },
                        padding: EdgeInsets.all(5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoArguments {
  VideoArguments._();
  static API.Video videoInfo;
  static List<VideoCommentUserView> comments;
}
