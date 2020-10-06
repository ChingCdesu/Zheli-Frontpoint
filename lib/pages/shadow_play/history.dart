import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/utils/device_size.dart';

class ShadowPlayHistory extends StatefulWidget {
  ShadowPlayHistory({Key key}) : super(key: key);

  @override
  _ShadowPlayHistoryState createState() => _ShadowPlayHistoryState();
}

class _ShadowPlayHistoryState extends State<ShadowPlayHistory> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: true,
        middle: Text('历史起源'),
        border: Border(),
        padding: EdgeInsetsDirectional.only(start: 0, end: 10, top: 0, bottom: 0),
        backgroundColor: Colors.white,
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
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              //image: NetworkImage(publicUrl + 'assets/shadow_play/history/his_bgc.png'),
              image: AssetImage('assets/images/shadow_play/his_bgc.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
            height: double.infinity,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: DeviceSize.getHeightByPercent(0.04),
                ),
                imgtext('assets/images/shadow_play/his01.gif',
                    '皮影戏，又称“影子戏”或“灯影戏”，老北京人叫它“驴皮影”，是中国民间古老的传统艺术，这个将皮影人偶借助灯光投影在幕布演绎的戏剧艺术形式，在民间被称为“手工电影”，通过吹拉弹唱演全能的皮影戏艺人完整的呈现一个个有趣的故事，具有浓厚的乡土气息。在2011年，中国皮影戏更是入选人类非物质文化遗产代表作名录。'),
                imgtext('assets/images/shadow_play/his02.gif',
                    '据史书记载，皮影戏始于西汉，兴于唐朝，盛于清代，元代时期传至西亚和欧洲。皮影经过层层手工制作，最后完成的人偶道具都活灵活现，结合剪纸与脸谱的技艺，利用透明的皮质经过雕刻上色。在过去还没有电影、电视的年代，皮影戏曾是十分受欢迎的民间娱乐活动之一，承载了许多孩子的童年。'),
                imgtext('assets/images/shadow_play/his01.jpg',
                    '皮影戏在中国流传地域广阔，范围广泛，并因各地所演的声腔不同而形成多种多样的皮影戏，在不同区域的长期演化过程中逐渐形成了不同的流派。各地皮影的音乐唱腔风格与韵律都吸收了各自地方戏曲、曲艺、民歌小调、音乐体系的精华，从而形成了溢彩纷呈的众多派别。'),
                imgtext('assets/images/shadow_play/his02.jpg',
                    '有的人说皮影戏是比电影还要有灵魂的动作片，而在电子影视和流行文化的冲击下，现在的很多孩子没有机会亲眼观看皮影戏，或许仅仅在电视或者网络有所了解，这个对于大家既熟悉又陌生的民间艺术表演形式也希望能有更多的人用心去感受，了解和传承。'),
              ],
            ),
          )),
    );
  }

  Widget imgtext(String img, String text) {
    return Column(
      children: <Widget>[
        Container(
          //child: Image.network(publicUrl + img),
          child: Image.asset(img),
        ),
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            text,
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
