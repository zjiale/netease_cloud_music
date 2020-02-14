import 'package:dio/dio.dart';
import 'package:wangyiyun/api/api.dart';
import 'package:wangyiyun/model/newest_album_model.dart';
import 'package:wangyiyun/model/recommend_song_list_model.dart';
import 'package:wangyiyun/utils/config.dart';
import 'package:wangyiyun/model/recommend_list_model.dart';

class CommmonService {
  Future<Response> getBanner(int type) async {
    return await Dio().get("${Api.BANNER}?type=$type", options: _getOptions());
  }

  Future<Response> getRecommendList() async {
    return Dio().get(Api.RECOMMEND_LIST, options: _getOptions());
  }

  Future<Response> getRecommendSongList() async {
    return Dio().get(Api.RECOMMEND_SONG_LIST, options: _getOptions());
  }

  Future<Response> getNewestAlbum() async {
    return Dio().get(Api.NEWEST_ALBUM_LIST, options: _getOptions());
  }

  Future<Response> getRank(int type) async {
    return await Dio()
        .get("${Api.RANK_LIST}?idx=$type", options: _getOptions());
  }

  Future<Response> getPlayList(int id) async {
    return await Dio().get("${Api.PLAY_LIST}?uid=$id", options: _getOptions());
  }

  Options _getOptions() {
    return Options(headers: Config().getHeader());
  }
}
