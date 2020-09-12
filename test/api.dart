import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:zl_app/api/model_operations.dart' as API;
import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/settings/user.dart';
import 'package:zl_app/utils/crypto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino App',
      home: Container(
        child: CupertinoButton(
          child: Text("doreq"),
          onPressed: () => request2(),
        ),
      ),
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
  print('Your ID: ${Account.userId}');
  print('Your token: ${Account.token}');
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

void request2() async {
  var operation = await API.Get(new API.History(userId: Account.userId)).doOperation();
  if (!operation.hasError) {
    operation.getResult().forEach((history) {
      print(history);
    });
  } else {
    print(operation.log);
  }
}
