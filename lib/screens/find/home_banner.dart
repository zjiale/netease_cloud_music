import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:netease_cloud_music/model/banner_model.dart';

class HomeBanner extends StatelessWidget {
  final List<Banners> bannerList;

  HomeBanner(this.bannerList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(230.0),
      child: Swiper(
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40.0)),
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
