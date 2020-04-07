import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/model/top_quality_play_list_model.dart';
import 'package:netease_cloud_music/screens/playlist/top_disc.dart';
import 'package:netease_cloud_music/utils/config.dart';
import 'package:netease_cloud_music/utils/numbers_convert.dart';
import 'package:netease_cloud_music/utils/routes/navigator_util.dart';
import 'package:netease_cloud_music/widgets/data_loading.dart';
import 'package:netease_cloud_music/widgets/play_list_cover.dart';

class OtherSubPlayList extends StatefulWidget {
  final int index;
  final String tag;
  final indexCallback;
  final imgCallback;

  OtherSubPlayList(
      {@required this.index,
      @required this.tag,
      @required this.indexCallback,
      @required this.imgCallback});

  @override
  _OtherSubPlayListState createState() => _OtherSubPlayListState();
}

class _OtherSubPlayListState extends State<OtherSubPlayList>
    with AutomaticKeepAliveClientMixin {
  List<Playlists> _source = [];
  List<Playlists> _top = [];
  int _code = Config.SUCCESS_CODE;

  ScrollController _scrollController;
  EasyRefreshController _controller;

  int _pageIndex = 1;

  @override
  bool get wantKeepAlive => true;

  Future _getPlayList({int offset = 0}) {
    return CommmonService()
        .getGroundPlayList(offset: offset, cat: widget.tag)
        .then((res) {
      if (res.statusCode == 200) {
        TopQualityPlayListModel _bean =
            TopQualityPlayListModel.fromJson(res.data);
        if (_bean.code == _code) {
          return _bean;
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _controller = EasyRefreshController();
  }

  /// 获取轮播图当前index
  void getCurrentIndex(index) {
    widget.indexCallback(index);
  }

  /// 将轮播图第一涨图设置背景图
  void putBgImage(List<Playlists> list) {
    List<String> imgUrl = [];
    list.forEach((playlist) {
      imgUrl.add(playlist.coverImgUrl);
    });
    widget.imgCallback(imgUrl);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
      Key("Tab${widget.index}"),
      Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(20.0)),
        child: EasyRefresh.custom(
            controller: _controller,
            scrollController: _scrollController,
            taskIndependence: true,
            onRefresh: () async {
              var list = await _getPlayList();
              if (widget.index == 0) {
                putBgImage(list.playlists.sublist(0, 3));
                _top = list.playlists.sublist(0, 3);
              }
              if (mounted) {
                _source = widget.index == 0
                    ? list.playlists.sublist(3)
                    : list.playlists;
              }
              setState(() {});
            },
            onLoad: () async {
              var list = await _getPlayList(offset: 35 * _pageIndex);
              if (list.playlists.length > 0) {
                setState(() {
                  _source.addAll(list.playlists);
                  _pageIndex++;
                });
              }
              _controller.finishLoad(noMore: _source.length >= list.total);
            },
            footer: BallPulseFooter(color: Theme.of(context).primaryColor),
            firstRefresh: true,
            firstRefreshWidget: Container(
                width: double.infinity,
                // height: double.infinity,
                child: DataLoading()),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: widget.tag == ""
                    ? TopDisc(
                        source: _top,
                        callback: (index) => getCurrentIndex(index))
                    : Container(),
              ),
              _source.length > 0
                  ? SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: ScreenUtil().setWidth(20.0),
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return InkWell(
                          onTap: () => NavigatorUtil.goPlayListDetailPage(
                            context,
                            expandedHeight: 520,
                            id: _source[index].id,
                            official: widget.index == 1 ? true : false,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                PlayListCoverWidget(_source[index].coverImgUrl,
                                    width: 220,
                                    playCount: NumberUtils.amountConversion(
                                        _source[index].playCount)),
                                SizedBox(height: 5.0),
                                Container(
                                    width: ScreenUtil().setWidth(200.0),
                                    child: Text(_source[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize:
                                                ScreenUtil().setSp(23.0))))
                              ]),
                        );
                      }, childCount: _source.length))
                  : SliverToBoxAdapter(
                      child: Container(),
                    )
            ]),
      ),
    );
  }
}
