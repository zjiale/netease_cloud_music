import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/model/music_song_model.dart';
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
import 'package:netease_cloud_music/widgets/data_loading.dart';
import 'package:netease_cloud_music/widgets/song_item.dart';
import 'package:netease_cloud_music/widgets/subscriber_item.dart';

class SearchDetailScreens extends StatefulWidget {
  final String keyword;
  final int type;
  SearchDetailScreens({@required this.keyword, @required this.type});

  @override
  _SearchDetailScreensState createState() => _SearchDetailScreensState();
}

class _SearchDetailScreensState extends State<SearchDetailScreens>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController;
  EasyRefreshController _controller;

  int _code = Config.SUCCESS_CODE;

  bool _isInit = false;
  List _source = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _controller = EasyRefreshController();
  }

  Future _getSearcDetail() {
    return CommmonService()
        .getSearchDetail(widget.keyword, widget.type)
        .then((res) {
      if (res.statusCode == 200) {
        switch (widget.type) {
          case 1018: // 综合
            general.SearchGeneralDetailModel _bean =
                general.SearchGeneralDetailModel.fromJson(res.data);
            if (_bean.code == _code) return _bean.result;
            break;
          case 1: // 单曲
            song.SearchSongDetailModel _bean =
                song.SearchSongDetailModel.fromJson(res.data);
            if (_bean.code == _code) return _bean.result;
            break;
          case 1014: // 视频
            video.SearchVideoDetailModel _bean =
                video.SearchVideoDetailModel.fromJson(res.data);
            if (_bean.code == _code) return _bean.result;
            break;
          case 100: // 歌手
            artists.SearchArtistsDetailModel _bean =
                artists.SearchArtistsDetailModel.fromJson(res.data);
            if (_bean.code == _code) return _bean.result;
            break;
          case 10: // 专辑
            album.SearchAlbumDetailModel _bean =
                album.SearchAlbumDetailModel.fromJson(res.data);
            if (_bean.code == _code) return _bean.result;
            break;
          case 1000: // 歌单
            playlist.SearchPlaylistDetailModel _bean =
                playlist.SearchPlaylistDetailModel.fromJson(res.data);
            if (_bean.code == _code) return _bean.result;
            break;
          case 1002: // 用户
            user.SearchUserDetailModel _bean =
                user.SearchUserDetailModel.fromJson(res.data);
            if (_bean.code == _code) return _bean.result;
            break;
          default:
        }
      }
    });
  }

  Widget _buildDetail() {
    int type = widget.type;
    Widget _content;
    switch (type) {
      case 1018:
        return SliverToBoxAdapter(
          child: Container(),
        );
        break;
      default:
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (type == 100 || type == 1002) {
              _content = SubscriberItem(
                avatarUrl: type == 100
                    ? _source[index].img1v1Url
                    : _source[index].avatarUrl,
                name:
                    type == 100 ? _source[index].name : _source[index].nickname,
                showGender: type == 100 ? false : true,
                gender: type == 100 ? -1 : _source[index].gender,
                showSignature: type == 100 ? false : true,
                signature: type == 100 ? '' : _source[index].signature,
              );
            }
            if (type == 1) {
              MusicSong song = MusicSong(
                  id: _source[index].id,
                  mvid: _source[index].mvid,
                  total: _source[index].duration,
                  name: _source[index].name,
                  subName: _source[index].alias.length > 0
                      ? _source[index].alias.first
                      : '',
                  artists: _source[index].artists.length == 1
                      ? _source[index].artists.first.name
                      : Config().formateArtist(_source[index].artists),
                  album: _source[index].album.name,
                  isVip: _source[index].fee == 1 ? true : false);
              _content = SongItem(
                showIndex: true,
                detail: song,
                isSearch: true,
              );
            }
            if (type == 10 || type == 1000) {
              MusicSong song = MusicSong(
                  id: _source[index].id,
                  name: _source[index].name,
                  subName: type == 10
                      ? _source[index].alias.length > 0
                          ? _source[index].alias.first
                          : ''
                      : '',
                  artists: type == 10
                      ? _source[index].artist.name
                      : _source[index].creator.nickname,
                  artistsTrans: type == 10
                      ? _source[index].artist.trans != null
                          ? _source[index].artist.trans
                          : ''
                      : '',
                  picUrl: type == 10
                      ? _source[index].blurPicUrl
                      : _source[index].coverImgUrl,
                  total: type == 10 ? -1 : _source[index].trackCount,
                  count: type == 10 ? -1 : _source[index].playCount,
                  publishTime: type == 10 ? _source[index].publishTime : -1);
              _content = SongItem(
                showIndex: true,
                showPic: true,
                detail: song,
                isSearch: true,
                type: type == 10 ? 1 : 2,
              );
            }
            return _content;
          }, childCount: _source.length),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
      Key("Tab${widget.type}"),
      Padding(
        padding: EdgeInsets.all(10.0),
        child: EasyRefresh.custom(
            controller: _controller,
            scrollController: _scrollController,
            taskIndependence: true,
            topBouncing: !_isInit,
            onRefresh: _isInit
                ? null
                : () async {
                    int type = widget.type;
                    var searchDetail = await _getSearcDetail();
                    switch (type) {
                      case 1:
                        _source = searchDetail.songs;
                        break;
                      case 10:
                        _source = searchDetail.albums;
                        break;
                      case 100:
                        _source = searchDetail.artists;
                        break;
                      case 1000:
                        _source = searchDetail.playlists;
                        String data = _source.first.name;
                        print(data.contains(widget.keyword));
                        break;
                      case 1002:
                        _source = searchDetail.userprofiles;
                        break;
                      default:
                    }
                    setState(() {});
                  },
            onLoad: () async {},
            footer: BallPulseFooter(color: Theme.of(context).primaryColor),
            firstRefresh: true,
            firstRefreshWidget:
                Container(width: double.infinity, child: DataLoading()),
            slivers: <Widget>[_buildDetail()]),
      ),
    );
  }
}
