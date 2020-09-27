import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zl_app/settings/user.dart';
import 'package:zl_app/utils/crypto.dart';
import 'package:zl_app/utils/device_size.dart';

import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/api/model_operations.dart' as API;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //焦点
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _userNameController = new TextEditingController();

  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _password = ''; //用户名
  var _username = ''; //密码
  var _isShowPwd = false; //是否显示密码
  var _isShowClear = false; //是否显示输入框尾部的清除按钮

  @override
  void initState() {
    //设置焦点监听
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
    //监听用户名框的输入改变
    _userNameController.addListener(() {
      print(_userNameController.text);

      // 监听文本框输入变化，当有内容的时候，显示尾部清除按钮，否则不显示
      if (_userNameController.text.length > 0) {
        _isShowClear = true;
      } else {
        _isShowClear = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // 移除焦点监听
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
    super.dispose();
  }

  // 监听焦点
  Future<Null> _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      print("用户名框获取焦点");
      // 取消密码框的焦点状态
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      print("密码框获取焦点");
      // 取消用户名框焦点状态
      _focusNodeUserName.unfocus();
    }
  }

  //验证用户名
  String validateUserName(value) {
    // 正则匹配手机号
    RegExp exp =
        RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '用户名不能为空!';
    } else if (!exp.hasMatch(value)) {
      return '请输入正确手机号';
    }
    return null;
  }

  //验证密码
  String validatePassWord(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    } else if (value.trim().length < 6 || value.trim().length > 18) {
      return '密码长度不正确';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    DeviceSize.setDeviceSize(MediaQuery.of(context).size);

    // logo 图片区域
    Widget logoImageArea = new Container(
      alignment: Alignment.topCenter,
      // 设置图片为圆形
      child: ClipOval(
        child: Image.asset(
          "images/zsyh01.png",
          height: DeviceSize.getHeightByPercent(0.3),
          width: DeviceSize.getWidthByPercent(0.3),
          fit: BoxFit.cover,
        ),
      ),
    );

    //输入文本框区域
    Widget inputTextArea = new Container(
      height: DeviceSize.getHeightByPercent(0.4),
      margin: EdgeInsets.only(left: 36, right: 46),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //手机号
            Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    new CupertinoTextField(
                      padding: EdgeInsets.all(2),
                      // new TextFormField(
                      controller: _userNameController,
                      focusNode: _focusNodeUserName,
                      //设置键盘类型
                      keyboardType: TextInputType.number,
                      placeholder: '手机号',
                      prefix: CupertinoButton(
                        child: Icon(
                          Icons.person,
                        ),
                        onPressed: () {},
                        pressedOpacity: 1,
                      ),
                      suffix: (_isShowClear)
                          ? CupertinoButton(
                              child: Icon(CupertinoIcons.clear),
                              onPressed: () {
                                setState(() {
                                  _userNameController.clear();
                                });
                              },
                            )
                          : null,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(26.0),
                        ),
                      ),
                      // // 验证用户名
                      // validator: validateUserName,
                      //保存数据
                      onSubmitted: (String value) {
                        _username = value;
                        print(value);
                      },
                      //验证用户名
                      // validator: validateUserName,
                      // //保存数据
                      // onSaved: (String value) {
                      //   _username = value;
                      // },

                      // decoration: InputDecoration(
                      //   focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(
                      //           color: CupertinoColors.systemGrey, width: 2)),
                      //   icon: Icon(Icons.person),
                      //   // labelText: "手机号",
                      //   // labelStyle: TextStyle(color: CupertinoColors.systemGrey),
                      //   hintText: "手机号",
                      //   hintStyle: TextStyle(fontSize: 14),
                      //   //尾部添加清除按钮
                      //   suffixIcon: (_isShowClear)
                      //       ? IconButton(
                      //           icon: Icon(Icons.clear),
                      //           onPressed: () {
                      //             // 清空输入框内容
                      //             _userNameController.clear();
                      //           },
                      //         )
                      //       : null,
                      // ),
                      // 验证用户名
                      // validator: validateUserName,
                      // //保存数据
                      // onSaved: (String value) {
                      //   _username = value;
                      // },
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: 50,
                          right: 0,
                        ),
                        height: DeviceSize.getHeightByPercent(0.004), //120
                        width: DeviceSize.getWidthByPercent(1), // 1.0
                        color: CupertinoColors.systemGrey2)
                  ],
                )),
            //密码
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  new CupertinoTextField(
                    padding: EdgeInsets.all(2),
                    // TextFormField(
                    //controller: _userNameController,
                    focusNode: _focusNodePassWord,
                    //设置键盘类型
                    keyboardType: TextInputType.text,
                    placeholder: '密码',
                    prefix: CupertinoButton(
                      child: Icon(Icons.lock),
                      onPressed: () {},
                    ),
                    suffix: CupertinoButton(
                      child: Icon((_isShowPwd) ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isShowPwd = !_isShowPwd;
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(26.0),
                      ),
                    ),
                    obscureText: !_isShowPwd,
                    //     TextFormField(
                    //   focusNode: _focusNodePassWord,
                    //   decoration: InputDecoration(
                    //       focusedBorder: UnderlineInputBorder(
                    //           borderSide: BorderSide(
                    //               color: CupertinoColors.systemGrey, width: 2)),
                    //       icon: Icon(Icons.lock),
                    //       focusColor: CupertinoColors.systemGrey,
                    //       // labelText: "密码",
                    //       hintText: "密码",
                    //       hintStyle: TextStyle(fontSize: 14),
                    //       // 是否显示密码
                    //       suffixIcon: IconButton(
                    //         icon: Icon(
                    //             (_isShowPwd) ? Icons.visibility : Icons.visibility_off),
                    //         // 点击改变显示或隐藏密码
                    //         onPressed: () {
                    //           setState(() {
                    //             _isShowPwd = !_isShowPwd;
                    //           });
                    //         },
                    //       )),
                    //   obscureText: !_isShowPwd,
                    //   //密码验证
                    //   validator: validatePassWord,
                    //   //保存数据
                    //   onSaved: (String value) {
                    //     _password = value;
                    //   },
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        left: 50,
                        right: 0,
                      ),
                      height: DeviceSize.getHeightByPercent(0.004), //120
                      width: DeviceSize.getWidthByPercent(1), // 1.0
                      color: CupertinoColors.systemGrey2)
                ],
              ),
            )
          ],
        ),
      ),
    );

    // 登录按钮区域
    Widget loginButtonArea = new Container(
      //alignment: Alignment.topCenter,
      margin: EdgeInsets.only(left: 20, right: 20),
      height: DeviceSize.getHeightByPercent(0.12), //45
      width: DeviceSize.getWidthByPercent(0.7), // 300
      child: new RaisedButton(
        color: Color.fromRGBO(172, 192, 198, 1),
        child: Text(
          "登录",
          style: TextStyle(color: CupertinoColors.white, fontSize: 22),
        ),
        // 设置按钮圆角
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: () async {
          //点击登录按钮，解除焦点，回收键盘
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();

          if (_formKey.currentState.validate()) {
            //只有输入通过验证，才会执行这里
            _formKey.currentState.save();

            print("$_username + $_password");
            API.User login = new API.User(
              phone: _username,
              password: generateMd5(_password),
            );

            var operation = await API.Confirm(login).doOperation();
            if (!operation.hasError) {
              var result = operation.getResult();
              Account.userId = result['values'][0]['ID'];
            } else {
              SnackBar(
                content: Text("登录失败"),
              );
              return;
            }
          }
        },
      ),
    );

    //第三方登录区域
    Widget thirdLoginArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: DeviceSize.getHeightByPercent(0.001), //120
                width: DeviceSize.getWidthByPercent(0.3), // 1.0
                color: Colors.grey,
              ),
              Text(
                'or',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              Container(
                height: DeviceSize.getHeightByPercent(0.001), //120
                width: DeviceSize.getWidthByPercent(0.3), // 1.0
                color: Colors.grey,
              ),
            ],
          ),
          new SizedBox(
            height: DeviceSize.getHeightByPercent(0.04), //18
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CupertinoButton(
                child: Icon(
                  FontAwesomeIcons.weixin,
                  size: 30,
                ),
                onPressed: () {},
              ),
              CupertinoButton(
                child: Icon(
                  FontAwesomeIcons.weibo,
                  size: 30,
                ),
                onPressed: () {},
              ),
              CupertinoButton(
                child: Icon(
                  FontAwesomeIcons.qq,
                  size: 30,
                ),
                onPressed: () {},
              ),
              CupertinoButton(
                child: Icon(
                  Icons.mail,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );

    //忘记密码  立即注册
    Widget bottomArea = new Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(right: 50, left: 40),
      height: DeviceSize.getHeightByPercent(0.46), //height: 180,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            child: Text(
              "忘记密码?",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            //忘记密码按钮，点击执行事件
            onPressed: () {},
          ),
          FlatButton(
            child: Text(
              "立刻注册",
              style: TextStyle(
                //decoration: ,
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            //点击快速注册、执行事件
            onPressed: () {
              Navigator.pushNamed(context, '/personal/register');
            },
          )
        ],
      ),
    );

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // 外层添加一个手势，用于点击空白部分，回收键盘
      child: new GestureDetector(
        onTap: () {
          // 点击空白区域，回收键盘
          print("点击了空白区域");
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/login01.png"),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  new SizedBox(
                    height: DeviceSize.getHeightByPercent(0.18),
                  ),
                  logoImageArea,
                  new SizedBox(
                    height: DeviceSize.getHeightByPercent(0.12),
                  ),
                  inputTextArea,
                  new SizedBox(
                    height: DeviceSize.getHeightByPercent(0.1),
                  ),
                  loginButtonArea,
                  new SizedBox(
                    height: DeviceSize.getHeightByPercent(0.08),
                  ),
                  bottomArea,
                  thirdLoginArea,
                  new SizedBox(
                    height: DeviceSize.getHeightByPercent(0.08),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
