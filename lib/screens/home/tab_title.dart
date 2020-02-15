import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/utils/my_behavior.dart';

class TabTitle extends StatefulWidget {
  List<String> datas;
  void Function(void Function(int)) setCall;
  void Function(int) itemClick;
  TabTitle(this.datas, {this.setCall, this.itemClick});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabTitleState(datas, setCall: setCall, itemClick: itemClick);
  }
}

class TabTitleState extends State<TabTitle> {
  List<String> datas;
  List<GlobalKey> keys = <GlobalKey>[];
  ScrollController _controller = ScrollController();
  void Function(void Function(int)) setCall;
  void Function(int) itemClick;
  int curItem = 1;

  TabTitleState(this.datas, {this.setCall, this.itemClick}) {
    setCall(bodyPageChange);
    for (int i = 0; i < datas.length; i++) {
      keys.add(GlobalKey(debugLabel: i.toString()));
    }
  }

  /*
  * 1,手动滑动body页面，触发这个函数
  * 2，当点击title Item时，会调用itemClick，itemClick中会滚动body内容到指定页面，然后触发这个函数
  * */
  void bodyPageChange(int pos) {
    setState(() {
      curItem = pos;
    });
    scrollItemToCenter(pos);
  }

  //滚动Item到指定位置，这里滚动到屏幕正中间
  void scrollItemToCenter(int pos) {
    //获取item的尺寸和位置
    RenderBox box = keys[pos].currentContext.findRenderObject();
    Offset os = box.localToGlobal(Offset.zero);

//    double h=box.size.height;
    double w = box.size.width;
    double x = os.dx;
//    double y=os.dy;
//   获取屏幕宽高
    double windowW = MediaQuery.of(context).size.width;
//    double windowH=MediaQuery.of(context).size.height;

    //就算当前item距离屏幕中央的相对偏移量
    double rlOffset = windowW / 2 - (x + w / 2);

    //计算_controller应该滚动的偏移量
    double offset = _controller.offset - rlOffset;
    _controller.animateTo(offset,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  Widget initItemView(BuildContext context, String tab, int pos) {
    return Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.bottomCenter,
      //将key设置进去，后面通过key获取指定item的位置和尺寸
      key: keys[pos],
      child: GestureDetector(
        onTap: () {
          itemClick(pos);
        },
        child: Text(
          tab,
          style: TextStyle(
              fontSize: curItem == pos
                  ? ScreenUtil().setSp(35.0)
                  : ScreenUtil().setSp(30.0),
              color: curItem == 0
                  ? Colors.white
                  : curItem == pos ? Colors.black : Colors.grey,
              fontWeight: curItem == pos ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }

  Widget initView() {
    return Container(
      height: ScreenUtil().setHeight(80.0),
      // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          shrinkWrap: true,
          controller: _controller,
          scrollDirection: Axis.horizontal,
          itemCount: datas.length,
          itemBuilder: (context, pos) {
            return initItemView(context, datas[pos], pos);
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return initView();
  }
}
