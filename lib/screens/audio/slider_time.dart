import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/store/model/play_song_model.dart';

class SliderTime extends StatefulWidget {
  final PlaySongModel model;
  SliderTime(this.model);

  @override
  _SliderTimeState createState() => _SliderTimeState();
}

class _SliderTimeState extends State<SliderTime> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.model.curPositionStream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            var time = DateUtil.formatDateMs(int.parse('${snapshot.data}'),
                format: "mm:ss");
            return _body(context, time, snapshot.data);
          } else {
            return _body(context, '00:00', '0');
          }
        });
  }

  Widget _body(BuildContext context, String curFormatTime, String curTime) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(curFormatTime,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(20.0), color: Colors.white)),
            SizedBox(width: ScreenUtil().setWidth(5.0)),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white54, //进度条滑块左边颜色
                    inactiveTrackColor: Colors.grey, //进度条滑块右边颜色
                    thumbColor: Colors.white, //滑块颜色
                    overlayColor: Colors.white, //滑块拖拽时外圈的颜色
                    overlayShape: RoundSliderOverlayShape(
                      //可继承SliderComponentShape自定义形状
                      overlayRadius: ScreenUtil().setWidth(15.0), //滑块外圈大小
                    ),
                    thumbShape: RoundSliderThumbShape(
                      //可继承SliderComponentShape自定义形状
                      enabledThumbRadius: ScreenUtil().setWidth(8.0), //滑块大小
                    )),
                child: Slider(
                  value: double.parse('$curTime'),
                  max: double.parse('${widget.model.curSong.duration}'),
                  min: 0.0,
                  onChangeStart: (data) {
                    widget.model.stopProgress();
                  },
                  onChanged: (data) {
                    widget.model.sinkProgress(data.toInt());
                  },
                  onChangeEnd: (data) {
                    widget.model.startProgress();
                    widget.model.seek(data.toInt());
                  },
                ),
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(5.0)),
            Text(
                DateUtil.formatDateMs(
                    int.parse('${widget.model.curSong.duration}'),
                    format: "mm:ss"),
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(20.0), color: Colors.grey))
          ]),
    );
  }
}
