import 'package:dio/dio.dart';
import 'package:neteast_cloud_music/api/api.dart';
import 'package:neteast_cloud_music/model/newest_album_model.dart';
import 'package:neteast_cloud_music/model/recommend_song_list_model.dart';
import 'package:neteast_cloud_music/utils/config.dart';
import 'package:neteast_cloud_music/model/recommend_list_model.dart';

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

  Future<Response> getRankAbstrack() async {
    return await Dio().get(Api.RANK_LIST_ABSTRACT, options: _getOptions());
  }

  Future<Response> getRank(int type) async {
    return await Dio()
        .get("${Api.RANK_LIST}?idx=$type", options: _getOptions());
  }

  Future<Response> getPlayListsTags() async {
    return Dio().get(Api.PLAY_LIST_TAGS, options: _getOptions());
  }

  Future<Response> getPlayList(int id) async {
    return await Dio().get("${Api.PLAY_LIST}?uid=$id", options: _getOptions());
  }

  Future<Response> getGroundPlayList(
      {int offset = 0, String cat = "全部"}) async {
    return await Dio().get(
        "${Api.TOP_PLAY_LIST}?limit=35&offset=$offset&cat=$cat",
        options: _getOptions());
  }

  Future<Response> getDetailPlayList(int id) async {
    return await Dio()
        .get("${Api.PLAY_LIST_DETAIL}?id=$id", options: _getOptions());
  }

  Options _getOptions() {
    return Options(headers: Config().getHeader());
  }
}
