import 'package:flutter/material.dart';

class ArPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ArPageState();
}

class ArPageState extends State<ArPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AR',
          style: TextStyle(
            color: Color.fromRGBO(108, 100, 78, 1),
          ),
        ),
        backgroundColor: Color.fromRGBO(232, 221, 190, 1),
      ),
    );
  }
}
