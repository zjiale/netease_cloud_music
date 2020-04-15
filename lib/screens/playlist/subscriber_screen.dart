import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/model/suscribers_list_model.dart';
import 'package:netease_cloud_music/widgets/data_loading.dart';
import 'package:netease_cloud_music/widgets/subscriber_item.dart';

class SubscriberScreen extends StatefulWidget {
  final int id;
  SubscriberScreen({@required this.id});

  @override
  _SubscriberScreenState createState() => _SubscriberScreenState();
}

class _SubscriberScreenState extends State<SubscriberScreen> {
  CommmonService api = CommmonService();

  List<Subscribers> _subscribers = [];
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
                  var list = await api.getSubscribers(widget.id);
                  if (mounted) {
                    _subscribers = list.subscribers;
                    _isInit = true;
                  }
                  setState(() {});
                }
              : null,
          onLoad: () async {
            var list = await api.getSubscribers(widget.id,
                offset: (20 * _pageIndex) - 1);
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
                return SubscriberItem(
                  avatarUrl: _subscribers[index].avatarUrl,
                  name: _subscribers[index].nickname,
                  showGender: true,
                  gender: _subscribers[index].gender,
                  showSignature: true,
                  signature: _subscribers[index].signature,
                );
              }, childCount: _subscribers.length),
            )
          ]),
    );
  }
}
