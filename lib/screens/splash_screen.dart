import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/netease_cloud_music_route.dart' as prefix;
import 'package:netease_cloud_music/store/model/play_video_model.dart';
import 'package:netease_cloud_music/store/model/user_model.dart';

@FFRoute(
    name: "neteasecloudmusic://splashscreen",
    routeName: "SplashScreen",
    argumentNames: ["videoModel", "userModel"],
    pageRouteType: PageRouteType.transparent,
    description: "videoModel提前获取值让homescreen中使用,userModel判断当前用户是否有登录")
class SplashScreen extends StatefulWidget {
  final PlayVideoModel videoModel;
  final UserModel userModel;

  SplashScreen({@required this.videoModel, @required this.userModel});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), goPage);
  }

  goPage() {
    if (widget.userModel.user != null) {
      Navigator.pushNamedAndRemoveUntil(
          context,
          prefix.Routes.NETEASECLOUDMUSIC_HOMESCREEN,
          (Route<dynamic> route) => false,
          arguments: {"model": widget.videoModel});
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context,
          prefix.Routes.NETEASECLOUDMUSIC_LOGINSCREEN,
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
