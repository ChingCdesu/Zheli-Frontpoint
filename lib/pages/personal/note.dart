import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NotePage extends StatefulWidget {
  NotePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: CupertinoColors.white,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(6, 40, 0, 0),
                        height: 34,
                        width: 50,
                        child: CupertinoButton(
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              CupertinoIcons.back,
                              color: CupertinoColors.black,
                              size: 28,
                            ),
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            }),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.fromLTRB(0, 46, 0, 0),
                        child: Text(
                          '我的笔记',
                          style: TextStyle(
                              fontSize: 20,
                              color: CupertinoColors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        margin: EdgeInsets.fromLTRB(0, 40, 6, 0),
                        height: 34,
                        width: 50,
                        child: CupertinoButton(
                          padding: EdgeInsets.all(0),
                          child: Icon(
                            CupertinoIcons.tag,
                            color: CupertinoColors.black,
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            height: 86,
          ),
          Container(
            height: 726,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                  // children: NoteInfo.getWidgets()
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
