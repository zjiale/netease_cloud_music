import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:netease_cloud_music/api/api.dart';
import 'package:netease_cloud_music/model/banner_model.dart';
import 'package:netease_cloud_music/model/comment_model.dart';
import 'package:netease_cloud_music/model/event_model.dart';
import 'package:netease_cloud_music/model/follow_model.dart';
import 'package:netease_cloud_music/model/newest_album_model.dart';
import 'package:netease_cloud_music/model/play_list_abstract_model.dart';
import 'package:netease_cloud_music/model/play_list_model.dart';
import 'package:netease_cloud_music/model/play_list_tags_model.dart';
import 'package:netease_cloud_music/model/rank.dart';
import 'package:netease_cloud_music/model/rank_list_model.dart' as rank;
import 'package:netease_cloud_music/model/recommend_list_model.dart' as prefix;
import 'package:netease_cloud_music/model/recommend_song_list_model.dart';
import 'package:netease_cloud_music/model/search_default_model.dart';
import 'package:netease_cloud_music/model/search_hot_detail_model.dart';
import 'package:netease_cloud_music/model/search_suggest_model.dart';
import 'package:netease_cloud_music/model/suscribers_list_model.dart';
import 'package:netease_cloud_music/model/top_quality_play_list_model.dart';
import 'package:netease_cloud_music/model/video_url_model.dart';
import 'package:netease_cloud_music/model/search_album_detail_model.dart'
    as album;
import 'package:netease_cloud_music/model/search_artists_detail_model.dart'
    as artists;
import 'package:netease_cloud_music/model/search_general_detail_model.dart'
    as general;
import 'package:netease_cloud_music/model/search_playlist_detail_model.dart'
    as playlist;
import 'package:netease_cloud_music/model/search_song_detail_model.dart'
    as song;
import 'package:netease_cloud_music/model/search_user_detail_model.dart'
    as user;
import 'package:netease_cloud_music/model/search_video_detail_model.dart'
    as video;
import 'package:netease_cloud_music/utils/config.dart';
import 'package:path_provider/path_provider.dart';

List<Banners> parseBanner(var bannerJson) {
  BannersModel _bean = BannersModel.fromJson(bannerJson);
  return _bean.banners;
}

List<prefix.Recommend> parseRecommend(var recommendListJson) {
  prefix.RecommendListModel _bean =
      prefix.RecommendListModel.fromJson(recommendListJson);
  return _bean.recommend;
}

List<Albums> parseAlbum(var albumJson) {
  NewestAlbumModel _bean = NewestAlbumModel.fromJson(albumJson);
  _bean.albums
    ..shuffle()
    ..removeRange(6, _bean.albums.length);
  return _bean.albums;
}

List<Banners> parseRecommendSongList(var songListJson) {
  RecommendSongListModel _bean = RecommendSongListModel.fromJson(songListJson);

  List recommendSongList = _bean.recommend
    ..shuffle()
    ..removeWhere((song) => song.status == -200 || song.fee == 1)
    ..removeRange(9, _bean.recommend.length);
  String reason = _bean.recommend.first.reason;
  var filter = _bean.recommend.takeWhile((item) => item.reason == reason);
  return recommendSongList;
}

// List<Banners> parseBanner(var urlString) {
//   BannersModel _bean = BannersModel.fromJson(urlString);
//   return _bean.banners;
// }

List<Banners> parseTags(var tagJson) {
  List _tagList = [];
  PlaylistsTagsModel _bean = PlaylistsTagsModel.fromJson(tagJson);
  _tagList..add("推荐")..add("官方");
  _bean.tags.forEach((tag) {
    if (tag.hot == true && (tag.category == 0 || tag.category == 1))
      _tagList.add(tag.name);
  });
  return _tagList;
}

class CommmonService {
  int _code = Config.SUCCESS_CODE;
  static Dio _dio;

  static void init() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cj = PersistCookieJar(dir: tempPath);
    _dio = Dio()..interceptors.add(CookieManager(cj)); // 开启请求日志
  }

  Future<List> getBanner() async {
    int _type;
    if (Platform.isAndroid) {
      _type = 1;
    } else if (Platform.isIOS) {
      _type = 2;
    }
    Response result =
        await _dio.get("${Api.BANNER}?type=$_type", options: _getOptions());
    return compute(parseBanner, result.data);
  }

  Future<List> getRecommendList() async {
    Response result =
        await _dio.get(Api.RECOMMEND_LIST, options: _getOptions());
    return compute(parseRecommend, result.data);
  }

  Future<List> getRecommendSongList() async {
    Response result =
        await _dio.get(Api.RECOMMEND_SONG_LIST, options: _getOptions());
    return compute(parseRecommendSongList, result.data);
  }

  Future<List> getNewestAlbum() async {
    Response result =
        await _dio.get(Api.NEWEST_ALBUM_LIST, options: _getOptions());
    return compute(parseAlbum, result.data);
  }

  Future<PlayListAbstractModel> getRankAbstract() async {
    Response result =
        await _dio.get(Api.RANK_LIST_ABSTRACT, options: _getOptions());
    if (result.statusCode == 200) {
      PlayListAbstractModel _bean = PlayListAbstractModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<List> getRank() async {
    List _rankType = Config.rankType;
    List<Rank> _list = [];

    for (var i in _rankType) {
      Response result = await _dio.get("${Api.RANK_LIST}?idx=${i["type"]}",
          options: _getOptions());
      if (result.statusCode == 200) {
        rank.RankListModel _bean = rank.RankListModel.fromJson(result.data);
        if (_bean.code == _code) {
          List<rank.Tracks> tracks = _bean.playlist.tracks.sublist(0, 3);
          getColorFromUrl(tracks.first.al.picUrl).then((color) {
            return Color.fromRGBO(color[0], color[1], color[2], 1);
          }).then((color) {
            Rank _rank = Rank(
                title: "${i["title"]}",
                content: _bean.playlist.tracks.sublist(0, 3),
                bgColor: color);

            _list.add(_rank);
          });
        }
      }
    }

    return _list;
  }

  Future<List> getPlayLitsTags() async {
    List<String> _tagList = [];
    Response result =
        await _dio.get(Api.PLAY_LIST_TAGS, options: _getOptions());

    return compute(parseTags, result.data);
  }

  Future<List> getPlayList(int id) async {
    Response result =
        await _dio.get("${Api.PLAY_LIST}?uid=$id", options: _getOptions());
    if (result.statusCode == 200) {
      PlayListModel _bean = PlayListModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean.playlist;
      }
    }
  }

  Future<TopQualityPlayListModel> getGroundPlayList(
      {int offset = 0, String cat = ""}) async {
    Response result = await _dio.get(
        "${Api.TOP_PLAY_LIST}?limit=35&offset=$offset&cat=$cat",
        options: _getOptions());
    if (result.statusCode == 200) {
      TopQualityPlayListModel _bean =
          TopQualityPlayListModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<Response> getDetailPlayList(int id) async {
    return await _dio.get("${Api.PLAY_LIST_DETAIL}?id=$id",
        options: _getOptions());
  }

  Future<SubscribersListModel> getSubscribers(int id, {int offset = 0}) async {
    Response result = await _dio.get(
        "${Api.SUBSCRIBERS}?id=$id&limit=20&offset=$offset",
        options: _getOptions());
    if (result.statusCode == 200) {
      SubscribersListModel _bean = SubscribersListModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<EventModel> getEvent({int lasttime = 0}) async {
    // type: 18 分享歌曲  24 分享专栏文章 13 分享歌单 39 发布视频
    Response result = await _dio.get("${Api.EVENT}?lasttime=$lasttime",
        options: _getOptions());
    if (result.statusCode == 200) {
      EventModel _bean = EventModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<List> getFollows() async {
    Response result =
        await _dio.get("${Api.FOLLOWS}?uid=93412043", options: _getOptions());
    if (result.statusCode == 200) {
      FollowModel _bean = FollowModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean.follow
            .sublist(0, _bean.follow.length < 5 ? _bean.follow.length : 5);
      }
    }
  }

  Future<CommentModel> getEventComment(String threadId,
      {int offset = 0}) async {
    Response result = await _dio.get(
        "${Api.EVENT_COMMENT}?threadId=$threadId&offset=$offset",
        options: _getOptions());
    if (result.statusCode == 200) {
      CommentModel _bean = CommentModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<String> getVideoUrl(String id) async {
    Response result =
        await _dio.get("${Api.VIDEO_URL}?id=$id", options: _getOptions());
    if (result.statusCode == 200) {
      VideoUrlModel _bean = VideoUrlModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean.urls.first.url;
      }
    }
  }

  Future<CommentModel> getSongComment(int id, {int offset = 0}) async {
    Response result = await _dio.get(
        "${Api.SONG_COMMENT}?id=$id&offset=$offset",
        options: _getOptions());
    if (result.statusCode == 200) {
      CommentModel _bean = CommentModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<SearchDefaultModel> getSearchDefault() async {
    Response result =
        await _dio.get(Api.SEARCH_DEFAULT, options: _getOptions());
    if (result.statusCode == 200) {
      SearchDefaultModel _bean = SearchDefaultModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<SearchHotDetailModel> getSearchHotDetail() async {
    Response result =
        await _dio.get(Api.SEARCH_HOT_DETAIL, options: _getOptions());
    if (result.statusCode == 200) {
      SearchHotDetailModel _bean = SearchHotDetailModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<SearchSuggestModel> getSearchSuggest(String keywords) async {
    Response result = await _dio.get(
        "${Api.SEARCH_SUGGEST}?keywords=$keywords&type=mobile",
        options: _getOptions());
    if (result.statusCode == 200) {
      SearchSuggestModel _bean = SearchSuggestModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future getSeachDetail(String keywords, int type) async {
    Response result = await _dio.get(
        "${Api.SEARCH_DETAIL}?keywords=$keywords&type=$type",
        options: _getOptions());
    if (result.statusCode == 200) {
      switch (type) {
        case 1018: // 综合
          general.SearchGeneralDetailModel _bean =
              general.SearchGeneralDetailModel.fromJson(result.data);
          if (_bean.code == _code) return _bean.result;
          break;
        case 1: // 单曲
          song.SearchSongDetailModel _bean =
              song.SearchSongDetailModel.fromJson(result.data);
          if (_bean.code == _code) return _bean.result;
          break;
        case 1014: // 视频
          video.SearchVideoDetailModel _bean =
              video.SearchVideoDetailModel.fromJson(result.data);
          if (_bean.code == _code) return _bean.result;
          break;
        case 100: // 歌手
          artists.SearchArtistsDetailModel _bean =
              artists.SearchArtistsDetailModel.fromJson(result.data);
          if (_bean.code == _code) return _bean.result;
          break;
        case 10: // 专辑
          album.SearchAlbumDetailModel _bean =
              album.SearchAlbumDetailModel.fromJson(result.data);
          if (_bean.code == _code) return _bean.result;
          break;
        case 1000: // 歌单
          playlist.SearchPlaylistDetailModel _bean =
              playlist.SearchPlaylistDetailModel.fromJson(result.data);
          if (_bean.code == _code) return _bean.result;
          break;
        case 1002: // 用户
          user.SearchUserDetailModel _bean =
              user.SearchUserDetailModel.fromJson(result.data);
          if (_bean.code == _code) return _bean.result;
          break;
        default:
      }
    }
  }

  Options _getOptions() {
    return Options(headers: Config().getHeader());
  }
}
