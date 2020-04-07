import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/screens/home/home_screen.dart';
import 'package:netease_cloud_music/screens/login/login_screen.dart';
import 'package:netease_cloud_music/store/model/play_video_model.dart';
import 'package:netease_cloud_music/store/model/user_model.dart';

class SplashScreens extends StatefulWidget {
  final PlayVideoModel videoModel;
  final UserModel userModel;

  SplashScreens({@required this.videoModel, @required this.userModel});
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), goPage);
  }

  goPage() {
    if (widget.userModel.user != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => HomeScreen(model: widget.videoModel)),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    CommmonService.init();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset('assets/splash_img.jpg', fit: BoxFit.cover),
      ),
    );
  }
}
