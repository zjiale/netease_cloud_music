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

class CommmonService {
  int _code = Config.SUCCESS_CODE;
  static Dio _dio;

  static void init() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cj = PersistCookieJar(dir: tempPath);
    _dio = Dio()..interceptors.add(CookieManager(cj)); // 开启请求日志
  }

  static Future<Response> _get(
    String url, {
    Map<String, dynamic> params,
  }) async {
    try {
      return await _dio.get(url,
          queryParameters: params, options: _getOptions());
    } on DioError catch (e) {
      if (e == null) {
        return Future.error(Response(data: -1));
      } else if (e.response != null) {
        if (e.response.statusCode >= 300 && e.response.statusCode < 400) {
          return Future.error(Response(data: -1));
        } else {
          return Future.value(e.response);
        }
      } else {
        return Future.error(Response(data: -1));
      }
    } finally {}
  }

  static Options _getOptions() {
    return Options(headers: Config().getHeader());
  }

  Future<List> getBanner() async {
    int _type;
    if (Platform.isAndroid) {
      _type = 1;
    } else if (Platform.isIOS) {
      _type = 2;
    }
    Response result = await _get("${Api.BANNER}?type=$_type");
    BannersModel _bean = BannersModel.fromJson(result.data);
    List<Banners> _banners = _bean.banners;
    return _banners;
  }

  Future<List> getRecommendList() async {
    Response result = await _get(Api.RECOMMEND_LIST);
    prefix.RecommendListModel _bean =
        prefix.RecommendListModel.fromJson(result.data);

    List<prefix.Recommend> _recommendList = _bean.recommend;
    return _recommendList;
  }

  Future<List> getRecommendSongList() async {
    Response result = await _get(Api.RECOMMEND_SONG_LIST);
    RecommendSongListModel _bean = RecommendSongListModel.fromJson(result.data);

    List recommendSongList = _bean.recommend
      ..shuffle()
      ..removeWhere((song) => song.status == -200 || song.fee == 1)
      ..removeRange(9, _bean.recommend.length);
    String reason = _bean.recommend.first.reason;
    var filter = _bean.recommend.takeWhile((item) => item.reason == reason);
    return recommendSongList;
  }

  Future<List> getNewestAlbum() async {
    Response result = await _get(Api.NEWEST_ALBUM_LIST);
    NewestAlbumModel _bean = NewestAlbumModel.fromJson(result.data);
    _bean.albums
      ..shuffle()
      ..removeRange(6, _bean.albums.length);

    List<Albums> _albums = _bean.albums;
    return _albums;
  }

  Future<PlayListAbstractModel> getRankAbstract() async {
    Response result = await _get(Api.RANK_LIST_ABSTRACT);
    if (result.statusCode == 200) {
      PlayListAbstractModel _bean = PlayListAbstractModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  static List<rank.Tracks> parseRank(var rankJson) {
    rank.RankListModel _bean = rank.RankListModel.fromJson(rankJson);
    return _bean.playlist.tracks.sublist(0, 3);
  }

  Future<Rank> getRank(var rankType) async {
    Rank _rank;
    Response result = await _get(
      "${Api.RANK_LIST}?idx=${rankType["type"]}",
    );
    // rank.RankListModel _bean = rank.RankListModel.fromJson(result.data);
    List<rank.Tracks> tracks = await compute(parseRank, result.data);

    var getColor = await getColorFromUrl(tracks.first.al.picUrl);
    Color _color = Color.fromRGBO(getColor[0], getColor[1], getColor[2], 1);

    _rank = Rank(title: rankType["title"], content: tracks, bgColor: _color);

    return _rank;
  }

  Future<List> getPlayLitsTags() async {
    List _tagList = [];
    Response result = await _get(Api.PLAY_LIST_TAGS);

    PlaylistsTagsModel _bean = PlaylistsTagsModel.fromJson(result.data);
    _tagList..add("推荐")..add("官方");
    _bean.tags.forEach((tag) {
      if (tag.hot == true && (tag.category == 0 || tag.category == 1))
        _tagList.add(tag.name);
    });
    return _tagList;
  }

  Future<List> getPlayList(int id) async {
    Response result = await _get("${Api.PLAY_LIST}?uid=$id");
    if (result.statusCode == 200) {
      PlayListModel _bean = PlayListModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean.playlist;
      }
    }
  }

  Future<TopQualityPlayListModel> getGroundPlayList(
      {int offset = 0, String cat = ""}) async {
    Response result = await _get(
      "${Api.TOP_PLAY_LIST}?limit=35&offset=$offset&cat=$cat",
    );
    if (result.statusCode == 200) {
      TopQualityPlayListModel _bean =
          TopQualityPlayListModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<Response> getDetailPlayList(int id) async {
    return await _get(
      "${Api.PLAY_LIST_DETAIL}?id=$id",
    );
  }

  Future<SubscribersListModel> getSubscribers(int id, {int offset = 0}) async {
    Response result = await _get(
      "${Api.SUBSCRIBERS}?id=$id&limit=20&offset=$offset",
    );
    if (result.statusCode == 200) {
      SubscribersListModel _bean = SubscribersListModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<EventModel> getEvent({int lasttime = 0}) async {
    // type: 18 分享歌曲  24 分享专栏文章 13 分享歌单 39 发布视频
    Response result = await _get(
      "${Api.EVENT}?lasttime=$lasttime",
    );
    if (result.statusCode == 200) {
      EventModel _bean = EventModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<List> getFollows() async {
    Response result = await _get("${Api.FOLLOWS}?uid=93412043");
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
    Response result = await _get(
      "${Api.EVENT_COMMENT}?threadId=$threadId&offset=$offset",
    );
    if (result.statusCode == 200) {
      CommentModel _bean = CommentModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<String> getVideoUrl(String id) async {
    Response result = await _get("${Api.VIDEO_URL}?id=$id");
    if (result.statusCode == 200) {
      VideoUrlModel _bean = VideoUrlModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean.urls.first.url;
      }
    }
  }

  Future<CommentModel> getSongComment(int id, {int offset = 0}) async {
    Response result = await _get(
      "${Api.SONG_COMMENT}?id=$id&offset=$offset",
    );
    if (result.statusCode == 200) {
      CommentModel _bean = CommentModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<SearchDefaultModel> getSearchDefault() async {
    Response result = await _get(Api.SEARCH_DEFAULT);
    if (result.statusCode == 200) {
      SearchDefaultModel _bean = SearchDefaultModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<SearchHotDetailModel> getSearchHotDetail() async {
    Response result = await _get(Api.SEARCH_HOT_DETAIL);
    if (result.statusCode == 200) {
      SearchHotDetailModel _bean = SearchHotDetailModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future<SearchSuggestModel> getSearchSuggest(String keywords) async {
    Response result = await _get(
      "${Api.SEARCH_SUGGEST}?keywords=$keywords&type=mobile",
    );
    if (result.statusCode == 200) {
      SearchSuggestModel _bean = SearchSuggestModel.fromJson(result.data);
      if (_bean.code == _code) {
        return _bean;
      }
    }
  }

  Future getSeachDetail(String keywords, int type) async {
    Response result = await _get(
      "${Api.SEARCH_DETAIL}?keywords=$keywords&type=$type",
    );
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
}
