import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:netease_cloud_music/api/api.dart';
import 'package:netease_cloud_music/utils/config.dart';
import 'package:path_provider/path_provider.dart';

class CommmonService {
  static Dio _dio;

  static void init() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cj = PersistCookieJar(dir: tempPath);
    _dio = Dio()
      ..interceptors.add(CookieManager(cj))
      ..interceptors.add(LogInterceptor(responseBody: false)); // 开启请求日志
  }

  Future<Response> getBanner(int type) async {
    return await _dio.get("${Api.BANNER}?type=$type", options: _getOptions());
  }

  Future<Response> getRecommendList() async {
    return _dio.get(Api.RECOMMEND_LIST, options: _getOptions());
  }

  Future<Response> getRecommendSongList() async {
    return _dio.get(Api.RECOMMEND_SONG_LIST, options: _getOptions());
  }

  Future<Response> getNewestAlbum() async {
    return _dio.get(Api.NEWEST_ALBUM_LIST, options: _getOptions());
  }

  Future<Response> getRankAbstrack() async {
    return await _dio.get(Api.RANK_LIST_ABSTRACT, options: _getOptions());
  }

  Future<Response> getRank(int type) async {
    return await _dio.get("${Api.RANK_LIST}?idx=$type", options: _getOptions());
  }

  Future<Response> getPlayListsTags() async {
    return _dio.get(Api.PLAY_LIST_TAGS, options: _getOptions());
  }

  Future<Response> getPlayList(int id) async {
    return await _dio.get("${Api.PLAY_LIST}?uid=$id", options: _getOptions());
  }

  Future<Response> getGroundPlayList(
      {int offset = 0, String cat = "全部"}) async {
    return await _dio.get(
        "${Api.TOP_PLAY_LIST}?limit=35&offset=$offset&cat=$cat",
        options: _getOptions());
  }

  Future<Response> getDetailPlayList(int id) async {
    return await _dio.get("${Api.PLAY_LIST_DETAIL}?id=$id",
        options: _getOptions());
  }

  Future<Response> getSubscribers(int id, {int offset = 0}) async {
    return await _dio.get("${Api.SUBSCRIBERS}?id=$id&limit=20&offset=$offset",
        options: _getOptions());
  }

  Future<Response> getEvent({int lasttime = 0}) async {
    return await _dio.get("${Api.EVENT}?lasttime=$lasttime",
        options: _getOptions());
  }

  Future<Response> getFollows() async {
    return await _dio.get("${Api.FOLLOWS}?uid=93412043",
        options: _getOptions());
  }

  Future<Response> getEventComment(String threadId, {int offset = 0}) async {
    return await _dio.get(
        "${Api.EVENT_COMMENT}?threadId=$threadId&offset=$offset",
        options: _getOptions());
  }

  Future<Response> getVideoUrl(String id) async {
    return await _dio.get("${Api.VIDEO_URL}?id=$id", options: _getOptions());
  }

  Future<Response> getSongComment(int id, {int offset = 0}) async {
    return await _dio.get("${Api.SONG_COMMENT}?id=$id&offset=$offset",
        options: _getOptions());
  }

  Future<Response> getSearchDefault() async {
    return _dio.get(Api.SEARCH_DEFAULT, options: _getOptions());
  }

  Future<Response> getSearchHotDetail() async {
    return _dio.get(Api.SEARCH_HOT_DETAIL, options: _getOptions());
  }

  Options _getOptions() {
    return Options(headers: Config().getHeader());
  }
}
