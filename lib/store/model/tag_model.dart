import 'package:flutter/material.dart';
import 'package:neteast_cloud_music/api/CommonService.dart';
import 'package:neteast_cloud_music/model/play_list_tags_model.dart';
import 'package:neteast_cloud_music/utils/config.dart';

class TagModel with ChangeNotifier {
  int _code = Config.SUCCESS_CODE;
  List<String> _tagList = [];

  List<String> get allTags => _tagList; // 当前播放列表

  void init() {
    CommmonService().getPlayListsTags().then((res) {
      if (res.statusCode == 200) {
        PlaylistsTagsModel _bean = PlaylistsTagsModel.fromJson(res.data);
        if (_bean.code == _code) {
          _tagList..add("推荐")..add("官方");
          _bean.tags.forEach((tag) {
            if (tag.hot == true && (tag.category == 0 || tag.category == 1))
              _tagList.add(tag.name);
          });
        }
      }
    });
  }
}
