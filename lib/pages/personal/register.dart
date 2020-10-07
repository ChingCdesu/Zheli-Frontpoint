import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/utils/crypto.dart';
import 'package:zl_app/utils/device_size.dart';
import 'package:zl_app/ui_libraries/toast.dart';

import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/api/model_operations.dart' as API;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //焦点
  FocusNode _mobileFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  // FocusNode _veriFocus = new FocusNode();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _mobileController = new TextEditingController();
  // TextEditingController _passwordController = new TextEditingController();
  TextEditingController _veriController = new TextEditingController();
  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _password = ''; //密码
  var _username = ''; //用户名
  var _veri = ''; //验证码
  var _isShowPwd = false; //是否显示密码
  var _isShowClear = false; //是否显示输入框尾部的清除按钮

  Timer _timer;
  int _start = 60;
  void countdown() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel(); //定时器清除
            _start = 60;
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    //设置焦点监听
    _mobileFocus.addListener(_focusNodeListener);
    _passwordFocus.addListener(_focusNodeListener);
    // _veriFocus.addListener(_focusNodeListener);
    //监听手机号框的输入改变
    _mobileController.addListener(() {
      // 监听文本框输入变化，当有内容的时候，显示尾部清除按钮，否则不显示
      // if (_mobileController.text.length > 0) {
      //   _isShowClear = true;
      // } else {
      //   _isShowClear = false;
      // }
      // setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    // 移除焦点监听
    _mobileFocus.removeListener(_focusNodeListener);
    _passwordFocus.removeListener(_focusNodeListener);
    // _veriFocus.removeListener(_focusNodeListener);
    _mobileController.dispose();
    super.dispose();
  }

  // 监听焦点
  Future<Null> _focusNodeListener() async {
    if (_mobileFocus.hasFocus) {
      // 取消密码框和验证码的焦点状态
      _passwordFocus.unfocus();
      // _veriFocus.unfocus();
    }
    if (_passwordFocus.hasFocus) {
      // 取消用户名和验证码框焦点状态
      _mobileFocus.unfocus();
      // _veriFocus.unfocus();
    }
    // if (_veriFocus.hasFocus) {
    //   print("验证码框获取焦点");
    //   // 取消用户名和密码框焦点状态
    //   _mobileFocus.unfocus();
    //   _passwordFocus.unfocus();
    // }
  }

  //验证手机号
  String validatePhoneNumber(value) {
    // 正则匹配手机号
    RegExp exp =
        RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '手机号不能为空';
    } else if (!exp.hasMatch(value)) {
      return '请输入正确手机号';
    }
    return null;
  }

  //密码验证
  String validatePassWord(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    } else if (value.trim().length < 6 || value.trim().length > 18) {
      return '密码长度不正确';
    }
    return null;
  }

  //验证码验证
  String validateVeri(value) {
    if (value.isEmpty) {
      return '验证码不能为空';
    } else if (value.trim().length != 6) {
      return '验证码长度不正确';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // logo 图片区域
    Widget logoImageArea = new Container(
      alignment: Alignment.topCenter,
      // 设置图片为圆形
      child: ClipOval(
        // child: Image.network(
        //   "assets/images/zsyh01.png",
        //   height: DeviceSize.getHeightByPercent(0.3),
        //   width: DeviceSize.getWidthByPercent(0.3),
        //   fit: BoxFit.cover,
        // ),
        child: Image.asset(
          'assets/images/sea_culture/zsyh.png,',
          height: DeviceSize.getHeightByPercent(0.3),
          width: DeviceSize.getWidthByPercent(0.3),
          fit: BoxFit.cover,
        ),
      ),
    );

    //输入文本框区域
    Widget inputTextArea = new Container(
      height: DeviceSize.getHeightByPercent(0.38),
      margin: EdgeInsets.only(left: 36, right: 46),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //手机号栏
            Container(
              height: DeviceSize.getHeightByPercent(0.14),
              // flex: 2,
              child: new CupertinoTextField(
                padding: EdgeInsets.fromLTRB(26, 2, 2, 2),
                controller: _mobileController,
                focusNode: _mobileFocus, //设置键盘类型
                keyboardType: TextInputType.text,
                placeholder: '用户名',
                style: TextStyle(
                  fontFamily: "PingFang SC",
                ),
                suffix: (_isShowClear)
                    ? CupertinoButton(
                        child: Icon(CupertinoIcons.clear),
                        onPressed: () {
                          setState(() {
                            _mobileController.clear();
                          });
                        },
                      )
                    : null,
                decoration: BoxDecoration(
                    // color: CupertinoColors.activeBlue,
                    // borderRadius: BorderRadius.all(
                    //   Radius.circular(26.0),
                    // ),
                    ),
                onSubmitted: (String value) {
                  _username = value;
                },
              ),
            ),
            //密码
            Container(
                // flex: 2,
                child: Column(
              children: <Widget>[
                new CupertinoTextField(
                  padding: EdgeInsets.fromLTRB(26, 0, 2, 0),
                  keyboardType: TextInputType.text, //设置键盘类型
                  focusNode: _passwordFocus,
                  placeholder: '密码',
                  suffix: CupertinoButton(
                    child: Icon((_isShowPwd) ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isShowPwd = !_isShowPwd;
                      });
                    },
                  ),
                  decoration: BoxDecoration(
                    // color: CupertinoColors.activeGreen,
                    borderRadius: BorderRadius.all(
                      Radius.circular(26.0),
                    ),
                  ),
                  obscureText: !_isShowPwd,
                ),
              ],
            )),
            //验证码
          ],
        ),
      ),
    );

    // 注册按钮区域
    Widget registerButtonArea = new Container(
      //alignment: Alignment.topCenter,
      margin: EdgeInsets.only(left: 20, right: 20),
      height: DeviceSize.getHeightByPercent(0.12), //45
      width: DeviceSize.getWidthByPercent(0.7), // 300
      child: new RaisedButton(
        color: Color.fromRGBO(172, 192, 198, 1),
        child: Text(
          "注册",
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 22,
          ),
        ),
        // 设置按钮圆角
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        onPressed: () async {
          //点击登录按钮，解除焦点，回收键盘
          _mobileFocus.unfocus();
          _passwordFocus.unfocus();
          // _veriFocus.unfocus();

          if (_formKey.currentState.validate()) {
            // 只有输入通过验证，才会执行这里
            _formKey.currentState.save();
            var _u = API.User(
              username: _username,
              // phone: _username,
              password: generateMd5(_password),
            );
            var _o = await API.Create(_u).doOperation();
            // TODO: 注册页面的阴间验证码
            if (!_o.hasError) {
              // SnackBar(
              //   content: Text("注册成功"),
              // );
              Toast.show("注册成功", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
            } else {
              // SnackBar(
              //   content: Text("注册失败"),
              // );
              Toast.show("注册失败", context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
              print(_o.log);
            }
          }
        },
      ),
    );

    //已有账号立即登录
    Widget bottomArea = new Container(
      alignment: Alignment.bottomCenter,
      // margin: EdgeInsets.only(right: 50, left: 40),
      // child: Container(
      height: DeviceSize.getHeightByPercent(0.1), //height: 180,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "已有账户?",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          ),
          FlatButton(
            child: Text(
              "点击立即登录",
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            //忘记密码按钮，点击执行事件
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      // ),
    );

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // 外层添加一个���势，用于点击空白部分，回收键盘
      child: new GestureDetector(
        onTap: () {
          // 点击空白区域，回收键盘
          _mobileFocus.unfocus();
          _passwordFocus.unfocus();
          // _veriFocus.unfocus();
        },
        child: new Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
                //image: NetworkImage(publicUrl + "assets/images/login01.png"), fit: BoxFit.cover),
                image: AssetImage('assets/images/home_page/login01.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: <Widget>[
              // new SizedBox(
              //   height: DeviceSize.getHeightByPercent(0.2),
              // ),
              // logoImageArea
              new SizedBox(
                height: DeviceSize.getHeightByPercent(0.3),
              ),
              inputTextArea,
              new SizedBox(
                height: DeviceSize.getHeightByPercent(0.1),
              ),
              registerButtonArea,
              new SizedBox(
                //height: DeviceSize.getHeightByPercent(0.24),
                height: DeviceSize.getHeightByPercent(0.1),
              ),
              bottomArea,
            ],
          ),
        ),
      ),
    );
  }
}
