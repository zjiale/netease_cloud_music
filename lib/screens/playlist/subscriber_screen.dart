import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neteast_cloud_music/api/CommonService.dart';
import 'package:neteast_cloud_music/model/suscribers_list_model.dart';
import 'package:neteast_cloud_music/utils/config.dart';
import 'package:neteast_cloud_music/widgets/data_loading.dart';

class SubscriberScreen extends StatefulWidget {
  final int id;
  SubscriberScreen({@required this.id});

  @override
  _SubscriberScreenState createState() => _SubscriberScreenState();
}

class _SubscriberScreenState extends State<SubscriberScreen> {
  int _code = Config.SUCCESS_CODE;

  List<Subscribers> _subscribers = [];
  ScrollController _scrollController;
  EasyRefreshController _controller;

  int _pageIndex = 1;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  Future _getSubscriber({int offset = 0}) {
    return CommmonService()
        .getSubscribers(widget.id, offset: offset)
        .then((res) {
      if (res.statusCode == 200) {
        SubscribersListModel _bean = SubscribersListModel.fromJson(res.data);
        if (_bean.code == _code) {
          return _bean;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text('收藏者',
            style: TextStyle(
                color: Colors.black87, fontSize: ScreenUtil().setSp(35.0))),
        titleSpacing: 0.0,
        elevation: 0.0,
      ),
      body: EasyRefresh.custom(
          controller: _controller,
          firstRefresh: true,
          firstRefreshWidget:
              Container(width: double.infinity, child: DataLoading()),
          onRefresh: !_isInit
              ? () async {
                  var list = await _getSubscriber();
                  if (mounted) {
                    _subscribers = list.subscribers;
                    _isInit = true;
                  }
                  setState(() {});
                }
              : null,
          onLoad: () async {
            var list = await _getSubscriber(offset: (20 * _pageIndex) - 1);
            if (list.subscribers.length > 0) {
              setState(() {
                _subscribers.addAll(list.subscribers);
                _pageIndex++;
              });
            }
            _controller.finishLoad(noMore: !list.more);
          },
          footer: BallPulseFooter(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(20.0),
                      right: ScreenUtil().setWidth(20.0),
                      bottom: ScreenUtil().setWidth(20.0)),
                  child: Row(
                    children: <Widget>[
                      ClipOval(
                          child: ExtendedImage.network(
                        _subscribers[index].avatarUrl,
                        fit: BoxFit.cover,
                        width: ScreenUtil().setWidth(100.0),
                        height: ScreenUtil().setWidth(100.0),
                      )),
                      Expanded(
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(20.0)),
                          title: Row(
                            children: <Widget>[
                              Text(_subscribers[index].nickname,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(28.0))),
                              SizedBox(
                                width: ScreenUtil().setWidth(5.0),
                              ),
                              _subscribers[index].gender != 0
                                  ? Image.asset(
                                      "assets/${_subscribers[index].gender == 1 ? 'male' : 'female'}.png",
                                      width: ScreenUtil().setWidth(20.0))
                                  : Container()
                            ],
                          ),
                          subtitle: _subscribers[index].signature != ''
                              ? Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                          "${_subscribers[index].signature}",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize:
                                                  ScreenUtil().setSp(20.0)),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      )
                    ],
                  ),
                );
              }, childCount: _subscribers.length),
            )
          ]),
    );
  }
}
