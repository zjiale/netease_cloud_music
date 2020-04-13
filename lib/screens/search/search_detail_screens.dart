import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:netease_cloud_music/utils/numbers_convert.dart';
import 'package:netease_cloud_music/widgets/data_loading.dart';
import 'package:netease_cloud_music/widgets/song_item.dart';
import 'package:netease_cloud_music/widgets/song_subtitle.dart';
import 'package:netease_cloud_music/widgets/song_title.dart';
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

  String _notFound = '';

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
    Widget _title;
    Widget _subTitle;
    switch (type) {
      case 1018:
        return SliverToBoxAdapter(
          child: Container(),
        );
        break;
      default:
        return _source.length > 0
            ? SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  var item = _source[index];
                  if (type == 100 || type == 1002) {
                    _content = SubscriberItem(
                      avatarUrl: type == 100 ? item.img1v1Url : item.avatarUrl,
                      name: type == 100 ? item.name : item.nickname,
                      showGender: type == 100 ? false : true,
                      gender: type == 100 ? -1 : item.gender,
                      showSignature: type == 100 ? false : true,
                      signature: type == 100 ? '' : item.signature,
                    );
                  } else if (type == 1) {
                    String transName =
                        item.alias.length > 0 ? item.alias.first : '';
                    List _list = [];
                    item.artists.forEach((artist) {
                      _list.add(artist.name);
                    });
                    _title = SongTitle(
                      name: item.name,
                      status: item.status,
                      transName: transName,
                    );
                    _subTitle = SongSubTitle(
                      artists: item.artists.length == 1
                          ? item.artists.first.name
                          : Config().formatArtist(_list),
                      album: item.album.name,
                      isVip: item.fee == 1 ? false : true,
                      status: item.status,
                    );

                    _content = SongItem(
                      showIndex: true,
                      isSearch: true,
                      title: _title,
                      subTitle: _subTitle,
                    );
                  } else if (type == 10 || type == 1000) {
                    String transName = type == 10
                        ? item.alias.length > 0 ? item.alias.first : ''
                        : '';
                    String artistsTransName = type == 10
                        ? item.artist.trans != null ? item.artist.trans : ''
                        : '';
                    _title = SongTitle(
                      name: item.name,
                      transName: transName,
                    );
                    _subTitle = type == 10
                        ? Text(
                            '${item.artist.name}($artistsTransName) ${DateUtil.formatDateMs(item.publishTime, format: "yyyy-MM-dd")}',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(20.0),
                                color: Colors.black54),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)
                        : Text(
                            '${item.trackCount}首 by ${item.creator.nickname}, 播放${NumberUtils.formatNum(item.playCount)}次',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(20.0),
                                color: Colors.black54),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis);

                    _content = SongItem(
                      showIndex: true,
                      title: _title,
                      subTitle: _subTitle,
                      picUrl: type == 10 ? item.blurPicUrl : item.coverImgUrl,
                      isSearch: true,
                      type: type == 10 ? 1 : 2,
                    );
                  } else if (type == 1014) {
                    List _list = [];
                    item.creator.forEach((creator) {
                      _list.add(creator.userName);
                    });
                    String creator = Config().formatArtist(_list);
                    _title = SongTitle(
                      name: item.title,
                      isMv: true,
                      type: item.type,
                    );
                    _subTitle = Text(
                        '${DateUtil.formatDateMs(item.durationms, format: "mm:ss")} ${item.type == 0 ? creator : "by $creator"}',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(20.0),
                            color: Colors.black54),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis);

                    _content = Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: SongItem(
                        title: _title,
                        subTitle: _subTitle,
                        picUrl: item.coverUrl,
                        isSearch: true,
                        showIndex: true,
                        type: 4,
                        height: 120.0,
                        playCount: item.playTime,
                      ),
                    );
                  }
                  return _content;
                }, childCount: _source.length),
              )
            : SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: Text(
                      _notFound,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
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
                        _source = searchDetail.songCount != 0 ||
                                searchDetail.songs.length > 0
                            ? searchDetail.songs
                            : [];
                        break;
                      case 10:
                        _source = searchDetail.albumCount != 0
                            ? searchDetail.albums
                            : [];
                        break;
                      case 100:
                        _source = searchDetail.artistCount != 0
                            ? searchDetail.artists
                            : [];
                        break;
                      case 1000:
                        _source = searchDetail.playlistCount != 0
                            ? searchDetail.playlists
                            : [];
                        break;
                      case 1002:
                        _source = searchDetail.userprofileCount != 0
                            ? searchDetail.userprofiles
                            : [];
                        break;
                      case 1014:
                        _source = searchDetail.videoCount != 0
                            ? searchDetail.videos
                            : [];
                        break;
                      default:
                    }
                    _notFound = _source.length == 0
                        ? '未找到与"${widget.keyword}"相关的内容'
                        : '';
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
