import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/model/play_list_abstract_model.dart';
import 'package:netease_cloud_music/screens/playlist/play_list_detail_screen.dart';
import 'package:netease_cloud_music/widgets/data_loading.dart';
import 'package:netease_cloud_music/widgets/play_list_cover.dart';

class RankListScreens extends StatefulWidget {
  @override
  _RankListScreensState createState() => _RankListScreensState();
}

class _RankListScreensState extends State<RankListScreens>
    with AutomaticKeepAliveClientMixin {
  CommmonService api = CommmonService();

  List<AbstractList> _main = [];
  List<AbstractList> _other = [];

  bool isInit = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
          '排行榜',
          style: TextStyle(
              color: Colors.black, fontSize: ScreenUtil().setSp(35.0)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(40.0),
            vertical: ScreenUtil().setWidth(20.0)),
        child: EasyRefresh.custom(
          firstRefresh: true,
          firstRefreshWidget:
              Container(width: double.infinity, child: DataLoading()),
          topBouncing: !isInit ? false : true,
          onRefresh: !isInit
              ? () async {
                  PlayListAbstractModel total = await api.getRankAbstract();
                  if (mounted) {
                    total.list.forEach((item) {
                      item.tracks.length > 0
                          ? _main.add(item)
                          : _other.add(item);
                    });
                    isInit = true;
                  }
                  setState(() {});
                }
              : null,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text("${_main.length > 0 ? '官方榜' : ''}",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(32.0),
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayListDetailScreen(
                                  expandedHeight: 520,
                                  id: _main[index].id,
                                )));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        PlayListCoverWidget(
                          _main[index].coverImgUrl,
                          width: 190.0,
                          circular: 5.0,
                          updateTime: _main[index].updateFrequency,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(20.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _main[index]
                                .tracks
                                .asMap()
                                .entries
                                .map((MapEntry e) {
                              return Text(
                                '${e.key + 1}.${_main[index].tracks[e.key].first} - ${_main[index].tracks[e.key].second}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(
                                    forceStrutHeight: true, height: 2.0),
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: ScreenUtil().setSp(23.0)),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }, childCount: _main.length),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(20.0), bottom: 15.0),
                child: Text("${_other.length > 0 ? '更多榜单' : ''}",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(32.0),
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SliverGrid(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                // mainAxisSpacing: ScreenUtil().setWidth(20.0),
                crossAxisSpacing: ScreenUtil().setWidth(20.0), //副轴中间间距
                childAspectRatio: 0.75, //item 宽高比
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建子widget
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayListDetailScreen(
                                    expandedHeight: 520,
                                    id: _other[index].id,
                                  )));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PlayListCoverWidget(
                          _other[index].coverImgUrl,
                          circular: 5.0,
                          updateTime: _other[index].updateFrequency,
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(5.0),
                        ),
                        Text(_other[index].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(23.0)))
                      ],
                    ),
                  );
                },
                childCount: _other.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
