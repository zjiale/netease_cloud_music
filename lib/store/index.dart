import 'package:flutter/material.dart';
import 'package:neteast_cloud_music/store/model/play_video_model.dart';
import 'package:provider/provider.dart';

import 'package:neteast_cloud_music/store/model/play_song_model.dart';
import 'package:neteast_cloud_music/store/model/tag_model.dart';

class Store {
  static BuildContext context;
  static BuildContext widgetCtx;

  //  在main.dart中runAPP实例化init
  static init({context, child}) {
    // if (userInfo != null) {
    //   String id = convert.jsonDecode(userInfo)["id"];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlaySongModel()..init()),
        ChangeNotifierProvider(create: (_) => TagModel()..init()),
        ChangeNotifierProvider(create: (_) => PlayVideoModel())
      ],
      child: child,
    );
    // }
    // else {
    //   return ChangeNotifierProvider(
    //     builder: (_) => LoginInfoModel(),
    //     child: child,
    //   );
    // }
  }

  //  通过Provider.value<T>(context)获取状态数据
  static T value<T>(context) {
    return Provider.of(context);
  }

  //  通过Consumer获取状态数据
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }

  static Consumer2 connect2<A, B>({builder, child}) {
    return Consumer2<A, B>(builder: builder, child: child);
  }

  static Consumer3 connect3<A, B, C>({builder, child}) {
    return Consumer3<A, B, C>(builder: builder, child: child);
  }
}
