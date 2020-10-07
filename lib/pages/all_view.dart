import 'package:flutter/material.dart';

class AllView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AllViewState();
}

class AllViewState extends State<AllView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '全景',
          style: TextStyle(
            color: Color.fromRGBO(108, 100, 78, 1),
          ),
        ),
        backgroundColor: Color.fromRGBO(232, 221, 190, 1),
      ),
    );
  }
}
