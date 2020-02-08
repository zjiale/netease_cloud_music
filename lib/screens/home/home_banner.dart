import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      height: ScreenUtil().setHeight(300.0),
      child: Swiper(
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: new Image.network(
                  "https://uploads.5068.com/allimg/151109/48-151109110K6-50.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
          itemCount: 8,
          pagination: SwiperPagination()),
    );
  }
}
