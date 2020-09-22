import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:zl_app/api/model_operations.dart' as API;
import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/settings/user.dart';
import 'package:zl_app/utils/crypto.dart';
import 'package:zl_app/api/asset_library.dart' as AssetLibrary;

void main() {
  runApp(Test());
}

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Widget image;
  void _request3() async {
    API.User login = new API.User(
      email: '172368@qq.com',
      password: generateMd5('changedPassword'),
    );

    var operation = await API.Confirm(login).doOperation();
    if (!operation.hasError) {
      var result = operation.getResult();
      Account.userId = result['values'][0]['ID'];
    } else {
      print(operation.log);
      return;
    }
    await Future.delayed(Duration(seconds: 1));

    // var loader = AssetLoader.getInstance();
    // var response = await loader.get('http://localhost:7001/public/upload/avatar/1.png');
    // print(response.data.stream);
    // var s = response.data as ResponseBody;
    // var length = 0;
    // var data = List<int>();
    // s.stream.listen(
    //   (event) {
    //     length += event.length;
    //     data.addAll(event);
    //     print('loaded: $length bytes');
    //   },
    //   onDone: () {
    //     print('done');
    //     image = Image.memory(Uint8List.fromList(data));
    //     setState(() {});
    //   },
    // );
    image = await AssetLibrary.AImage.network('http://localhost:7001/public/upload/avatar/1.png');
    setState(() {});
  }

  void _request2() async {
    API.User login = new API.User(
      email: '172368@qq.com',
      password: generateMd5('changedPassword'),
    );

    var operation = await API.Confirm(login).doOperation();
    if (!operation.hasError) {
      var result = operation.getResult();
      Account.userId = result['values'][0]['ID'];
    } else {
      print(operation.log);
      return;
    }
    await Future.delayed(Duration(seconds: 1));

    // operation = await API.Create(new API.History(userId: Account.userId, videoId: 2, currentTime: 20))
    //     .doOperation();
    // if (!operation.hasError) {
    //   print(operation.getResult());
    // } else {
    //   print(operation.log);
    // }

    operation = await API.Confirm(new API.History(userId: Account.userId)).doOperation();
    if (!operation.hasError) {
      var _s = operation.getResult()['values'] as List<dynamic>;
      for (var e in _s) {
        API.History _h;
        API.Video _v;
        await API.Get(new API.History(id: e['ID'])).doOperation().then((_o) async {
          if (_o.hasError) {
            print(_o.log);
            return;
          }
          _h = _o.fromJson(_o.getResult());
          print(_h.toJson());
          _v = API.Video(id: _h.videoId);
          await API.Get(_v).doOperation().then((_o) {
            if (_o.hasError) {
              print(_o.log);
              return;
            }
            // _v = _o.fromJson(_o.getResult());
            print(_v.toJson());
          });
        });
      }
    } else {
      print(operation.log);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino App',
      home: Container(
          child: Row(
        children: [
          CupertinoButton(
            child: Text("doreq"),
            onPressed: () => _request2(),
          ),
          Container(
            child: image,
          ),
        ],
      )),
      initialRoute: '/',
    );
  }
}

void request() async {
  // Demo: 注册
  // API.User newUser = new API.User(
  //   username: '_ChingC2',
  //   email: '172368@qq.com',
  //   phone: '12345678910',
  //   password: generateMd5('myPassword'),
  // );

  // var operation = await API.Create(newUser).doOperation();
  // if (!operation.hasError) {
  //   print(operation.getResult());
  //   print(operation.log);
  // } else {
  //   print(operation.log);
  // }

  API.User login = new API.User(
    email: '172368@qq.com',
    password: generateMd5('changedPassword'),
  );

  var operation = await API.Confirm(login).doOperation();
  if (!operation.hasError) {
    var result = operation.getResult();
    Account.userId = result['values'][0]['ID'];
  } else {
    print(operation.log);
    return;
  }
  await Future.delayed(Duration(seconds: 5));
  // Demo: 修改密码
  API.User updatePassword = new API.User(
    id: Account.userId,
    password: generateMd5('changedPassword'),
  );
  operation = await API.Update(updatePassword).doOperation();
  if (!operation.hasError) {
    print(operation.msg);
  } else {
    print(operation.log);
  }

  // // Demo: 退出登录
  // API.User logout = new API.User(
  //   id: 1,
  //   Token: "",
  // );
  // operation = API.Update(logout).doOperation();
  // if (!operation.hasError) {
  //   print(operation.getResult());
  // } else {
  //   print(operation.log);
  // }

  // // Demo: 获取个人数据
  // API.User getInfo = new API.User(id: 1);
  // operation = API.Get(getInfo).doOperation();
  // if (!operation.hasError) {
  //   print(operation.getResult());
  // } else {
  //   print(operation.log);
  // }
}
