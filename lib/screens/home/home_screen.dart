import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wangyiyun/screens/home/title_header.dart';
import 'package:wangyiyun/screens/playlist/play_list_screen.dart';
import 'package:wangyiyun/utils/config.dart';
import 'package:wangyiyun/utils/custom_scroll_physic.dart';
import 'package:wangyiyun/widgets/play_list_cover.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<Tab> _tabsTitle = Config.titleTabs;
  List _type = Config.type;

  TabController _titleTabController;
  int now = new DateTime.now().day;

  // 推荐controller
  ScrollController _controller = new ScrollController();
  // 新碟controller
  ScrollController _newController = new ScrollController();
  // 排行榜controller
  ScrollController _rankController = new ScrollController();

  ScrollPhysics _physics;

  @override
  void initState() {
    super.initState();
    _titleTabController =
        TabController(vsync: this, length: _tabsTitle.length, initialIndex: 1);

    _controller.addListener(() {
      if (_controller.position.haveDimensions && _physics == null) {
        setState(() {
          var dimension = _controller.position.maxScrollExtent / 2;
          _physics = CustomScrollPhysics(itemDimension: dimension);
        });
      }
    });

    _newController.addListener(() {
      if (_newController.position.haveDimensions && _physics == null) {
        setState(() {
          var dimension = _newController.position.maxScrollExtent;
          _physics = CustomScrollPhysics(itemDimension: dimension);
        });
      }
    });

    _rankController.addListener(() {
      if (_rankController.position.haveDimensions && _physics == null) {
        setState(() {
          var dimension = _rankController.position.maxScrollExtent / 4;
          _physics = CustomScrollPhysics(itemDimension: dimension);
        });
      }
    });
  }

  @override
  void dispose() {
    _titleTabController.dispose();
    _controller.dispose();
    _newController.dispose();
    _rankController.dispose();
    super.dispose();
  }

  Widget playType() {
    return Container(
      height: ScreenUtil().setHeight(150.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _type.map((item) {
            return Column(children: <Widget>[
              CircleAvatar(
                  radius: 22.0,
                  backgroundColor: Color(0xffff1916),
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Image.asset(item["image"]),
                    item["index"] == 0
                        ? Align(
                            alignment: FractionalOffset(0.5, 0.55),
                            child: Text(
                              '$now',
                              style: TextStyle(
                                  color: Color(0xffff1916),
                                  fontSize: ScreenUtil().setSp(25.0),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container()
                  ])),
              SizedBox(height: 5.0),
              Text(item["text"],
                  style: TextStyle(fontSize: ScreenUtil().setSp(20.0)))
            ]);
          }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    // gridview的宽高比
    double ratio =
        ScreenUtil().setWidth(100.0) / (MediaQuery.of(context).size.width - 60);

    return SafeArea(
        child: Scaffold(
            body: ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(10.0),
                children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(80.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.menu,
                          color: Colors.black, size: ScreenUtil().setSp(50.0)),
                      onPressed: () {}),
                  Flexible(
                    child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.black,
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        unselectedLabelColor: Colors.black54,
                        unselectedLabelStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        controller: _titleTabController,
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(style: BorderStyle.none)),
                        tabs: _tabsTitle),
                  ),
                  IconButton(
                      icon: Icon(Icons.search,
                          color: Colors.black, size: ScreenUtil().setSp(50.0)),
                      onPressed: () {})
                ]),
          ),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          // 发现页面banner界面
          Container(
            padding: EdgeInsets.only(left: 10.0),
            height: ScreenUtil().setHeight(300.0),
            child: Swiper(
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: new Image.network(
                        "https://uploads.5068.com/allimg/151109/48-151109110K6-50.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                itemCount: 8,
                pagination: SwiperPagination()),
          ),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          // 发现页面类型
          playType(),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          // 发现页面推荐歌单
          TitleHeader(),
          Container(
            height: ScreenUtil().setHeight(260.0),
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayListScreen()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Column(children: <Widget>[
                      PlayListCoverWidget(
                          "https://uploads.5068.com/allimg/151109/48-151109110K6-50.jpg"),
                      SizedBox(height: 5.0),
                      Container(
                          width: ScreenUtil().setWidth(200.0),
                          child: Text(
                            'adsadasdsadasdasdasdasdsada',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ))
                    ]),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          TitleHeader(),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          Container(
            height: ScreenUtil().setHeight(300.0),
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                itemCount: 9,
                physics: _physics,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //横轴元素个数
                    crossAxisCount: 3,
                    //纵轴间距
                    mainAxisSpacing: 5.0,
                    //横轴间距
                    crossAxisSpacing: 10.0,
                    //子组件宽高长度比例
                    childAspectRatio: ratio),
                itemBuilder: (BuildContext context, int index) {
                  //Widget Function(BuildContext context, int index)
                  return Column(children: <Widget>[
                    Row(children: <Widget>[
                      PlayListCoverWidget(
                        "https://uploads.5068.com/allimg/151109/48-151109110K6-50.jpg",
                        width: 100,
                      ),
                      Expanded(child: Text('$index')),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.play_arrow, size: 30.0),
                      )
                    ])
                  ]);
                }),
          ),
          TitleHeader(),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          Container(
            height: ScreenUtil().setHeight(300.0),
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                controller: _newController,
                itemCount: 6,
                physics: _physics,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //横轴元素个数
                    crossAxisCount: 3,
                    //纵轴间距
                    mainAxisSpacing: 5.0,
                    //横轴间距
                    crossAxisSpacing: 10.0,
                    //子组件宽高长度比例
                    childAspectRatio: ratio),
                itemBuilder: (BuildContext context, int index) {
                  //Widget Function(BuildContext context, int index)
                  return Column(children: <Widget>[
                    Row(children: <Widget>[
                      PlayListCoverWidget(
                        "https://uploads.5068.com/allimg/151109/48-151109110K6-50.jpg",
                        width: 100,
                      ),
                      Expanded(child: Text('$index')),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.play_arrow, size: 30.0),
                      )
                    ])
                  ]);
                }),
          ),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          TitleHeader(),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          Container(
            height: ScreenUtil().setHeight(380.0),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _rankController,
                itemCount: 5,
                physics: _physics,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: MediaQuery.of(context).size.width - 60,
                    margin: EdgeInsets.only(right: 10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Color(0xfff1f1f1),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('云音乐说唱排行榜',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(28.0),
                                        fontWeight: FontWeight.bold)),
                                Icon(Icons.keyboard_arrow_right,
                                    size: ScreenUtil().setSp(45.0))
                              ]),
                          Container(
                            height: ScreenUtil().setHeight(300.0),
                            padding: EdgeInsets.only(top: 5.0),
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: Row(children: <Widget>[
                                      PlayListCoverWidget(
                                        "https://uploads.5068.com/allimg/151109/48-151109110K6-50.jpg",
                                        width: 100,
                                      ),
                                      Expanded(child: Text('$index')),
                                      Icon(Icons.play_arrow, size: 30.0)
                                    ]),
                                  );
                                }),
                          )
                        ]),
                  );
                }),
          ),
          // TabBarView(
          //   controller: _titleTabController,
          //   children: _tabsTitle.map((Tab tab) {
          //     final String label = tab.text.toLowerCase();
          //     return Center(
          //       child: Text(
          //         'This is the $label tab',
          //         style: const TextStyle(fontSize: 36),
          //       ),
          //     );
          //   }).toList(),
          // )
        ])));
  }
}
