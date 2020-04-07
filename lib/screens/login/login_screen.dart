import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/screens/home/home_screen.dart';
import 'package:netease_cloud_music/store/index.dart';
import 'package:netease_cloud_music/store/model/play_video_model.dart';
import 'package:netease_cloud_music/store/model/user_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _phone, _password;
  FocusNode _phoneFocus, _pwFocus;
  GlobalKey<FormState> _inputInfo = new GlobalKey<FormState>(); //获取form对象

  ShapeBorder _shape = const RoundedRectangleBorder(
      side: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(50)));

  @override
  void initState() {
    _phoneFocus = FocusNode();
    _pwFocus = FocusNode();
    super.initState();
  }

  Widget inputInfo() {
    return Form(
      key: _inputInfo,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
                maxLength: 11,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.phone,
                focusNode: _phoneFocus,
                // 键盘回车键的操作
                textInputAction: TextInputAction.next,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.smartphone,
                      color: Colors.black54,
                    ),
                    hintText: "请输入手机号码"),
                validator: (phone) => phone.length < 11 ? '请输入正确的手机号' : null,
                onFieldSubmitted: (input) {
                  _phoneFocus.unfocus();
                  FocusScope.of(context).requestFocus(_pwFocus);
                },
                onSaved: (phone) => _phone = phone),
            TextFormField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black54,
                    ),
                    hintText: "请输入密码"),
                focusNode: _pwFocus,
                obscureText: true,
                // 键盘回车键的操作
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (input) {
                  _pwFocus.unfocus();
                },
                onSaved: (passowrd) => _password = passowrd),
          ]),
    );
  }

  Widget loginButton(BuildContext context) {
    return Store.connect2<UserModel, PlayVideoModel>(
        builder: (context, userModel, videoModel, child) {
      return Expanded(
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          shape: _shape,
          child: Text('登录',
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(30.0))),
          onPressed: () {
            var _form = _inputInfo.currentState;
            if (_form.validate()) {
              // 触发text得onsave方法
              _form.save();
              FocusScope.of(context).requestFocus(FocusNode());
              userModel.login(int.parse(_phone), _password).then((res) {
                if (res != null) {
                  userModel.setUser(res);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(model: videoModel)));
                }
              });
            }
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: ScreenUtil().setHeight(150.0)),
            Image.asset('assets/icon_logo.png',
                width: ScreenUtil().setWidth(100.0),
                height: ScreenUtil().setHeight(100.0)),
            SizedBox(height: ScreenUtil().setHeight(30.0)),
            Text('WelCome Back!',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(50.0),
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            SizedBox(height: ScreenUtil().setHeight(10.0)),
            Text('The Flutter Netease Cloud Music App',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(20.0), color: Colors.black54)),
            SizedBox(height: 15.0),
            inputInfo(),
            SizedBox(height: 50.0),
            Row(
              children: <Widget>[
                loginButton(context),
              ],
            )
          ]),
    ));
  }
}
