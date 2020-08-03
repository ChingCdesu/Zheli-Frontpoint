import 'package:zl_app/pages/history_page.dart';
import 'package:zl_app/pages/video_page.dart';
import 'package:flutter/cupertino.dart';

// Todo: 添加图片到ImageLibrary
// Todo: 调整页面自适应
// Todo: 从参数content获取UI内容
class ContentPage extends StatefulWidget {
  ContentPage({Key key, this.content}) : super(key: key);
  final Content content;
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/zsyh.png"),
              fit: BoxFit.cover,
            ),
          ),
          //padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.fromLTRB(6, 40, 0, 0),
                height: 34,
                width: 50,
                child: CupertinoButton(
                  padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Icon(
                    CupertinoIcons.back,
                    color: CupertinoColors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, CupertinoPageRoute(builder: (context) => HistoryPage()));
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(18, 100, 0, 10),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '舟山渔海',
                          style: TextStyle(
                              fontSize: 36,
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'The sea and fisheery',
                          style: TextStyle(
                              fontSize: 20,
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(60, 44, 0, 0),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
                        Icon(
                          CupertinoIcons.location,
                          color: CupertinoColors.white,
                        ),
                        Text(
                          '舟山',
                          style: TextStyle(fontSize: 14, color: CupertinoColors.white),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(18, 6, 18, 0),
                  child: Text(
                    '舟山市位于浙江省东北部，东临东海、西靠杭州湾、北面上海市，是环杭州湾大湾区核心城市、长江流域和长江三角洲对外开放的海上门户和通道，与亚太新兴港口城市呈扇形辐射之势。',
                    style: TextStyle(
                        fontSize: 14, color: CupertinoColors.white, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          height: 368,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(18, 20, 0, 6),
                child: Text(
                  '微课视频',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(6, 0, 16, 0),
                height: 390,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(children: _getAllClasses()),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  List<Widget> _getAllClasses() {
    List<Widget> classes = List<Widget>();
    widget.content.videos.forEach((_, value) {
      classes.add(_getClassWidget(value));
    });
    return classes;
  }

  Widget _getClassWidget(Video video) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 5,
              color: CupertinoColors.systemGrey4,
              offset: Offset.fromDirection(45, 10),
              spreadRadius: 4)
        ],
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: CupertinoColors.systemGrey5,
      ),
      height: 140,
      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(10, 10, 12, 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Image.asset(video.image),
            height: 110,
            decoration: BoxDecoration(),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  video.title,
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text(
                    video.description,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CupertinoColors.systemYellow,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 60,
                      height: 24,
                      child: Text(
                        '播放',
                        style: TextStyle(color: CupertinoColors.white, fontSize: 14),
                      ),
                    ),
                    onPressed: () {
                      Account.histories.add(History(0, video));
                      Navigator.push(
                          context, CupertinoPageRoute(builder: (context) => VideoPage()));
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
