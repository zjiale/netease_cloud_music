import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeBanner extends StatelessWidget {
  final List bannerList;

  HomeBanner(this.bannerList);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      height: ScreenUtil().setHeight(230.0),
      child: Swiper(
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: new ExtendedImage.network(bannerList[index].pic,
                    fit: BoxFit.fill),
              ),
            );
          },
          itemCount: bannerList.length,
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  color: Color(0xffcdcdcd),
                  size: ScreenUtil().setHeight(10.0),
                  activeSize: ScreenUtil().setHeight(10.0)))),
    );
  }
}
