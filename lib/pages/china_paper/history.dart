import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/utils/device_size.dart';

class ChinaPaperHistory extends StatefulWidget {
  ChinaPaperHistory({Key key}) : super(key: key);

  @override
  _ChinaPaperHistoryState createState() => _ChinaPaperHistoryState();
}

class _ChinaPaperHistoryState extends State<ChinaPaperHistory> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        automaticallyImplyMiddle: true,
        middle: Text('历史起源'),
        border: Border(),
        padding: EdgeInsetsDirectional.only(
          end: DeviceSize.getWidthByPercent(0.02),
        ),
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
              //image: NetworkImage(publicUrl + 'assets/china_paper/history/his_bgc.png'),
              image: AssetImage('assets/china_paper/history/his_bgc.png'),
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
                imgtext('assets/china_paper/history/his01.gif',
                    '富阳竹纸，又称为“富春竹纸”或“富阳土纸”，纸张以当年生的嫩毛竹为原料，手工操造而成。富阳土纸薄如蝉衣，韧力似纺绸，品多质优，写字作画滋润而悦目。其中的上品“元书纸”曾被北宋真宗皇帝选为“御用文书纸”，在民间也有“富阳一张纸，行销十八省”的说法。2006年，富阳竹纸制作技艺被列为首批国家级非物质文化遗产代表名录。'),
                imgtext('assets/china_paper/history/his02.jpg',
                    '从富阳泗州宋代造纸遗址可以窥见中国古代造纸技术精细的工艺流程。据说，给皇帝进贡的纸要经过72道工序，而一般百姓用的纸主要经过沤、煮、捣、抄这四道主要工序就可以了。正是复杂费时的工艺，赋予了富阳竹纸质地柔软、不腐不蛀、不易晕墨的特点。'),
                imgtext('assets/china_paper/history/his03.jpg',
                    '富春竹纸在继承我国传统造纸技艺的基础上形成了一整套独具特色的制作技艺，如制浆技艺中的“人尿发酵法”，抄制技艺中的“荡帘打浪法”等，均是富阳竹纸生产的绝艺坑边纸、斗方、桑皮纸、绵纸、桃花纸、蚕种纸、雨伞纸，说起这些纸的名称，大多数人都会感到陌生。然而，在富阳市老一辈造纸艺人的眼里，它们代表了富阳土纸曾经“一纸风行天下”的繁荣。'),
                imgtext('assets/china_paper/history/his04.jpg',
                    '因为古法制造工艺的复杂，使得手工纸的成本远远高于工业纸，许多手工匠人被迫放弃这门技艺，但在国家的扶持和民族文化保护意识的发展下，传统技艺重新走入人们的视野，然而，如何把拥有70多道工序的传统技艺继承下去，还需要一代代人的改革创新。'),
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
