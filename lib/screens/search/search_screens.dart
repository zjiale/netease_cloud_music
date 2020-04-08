import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/model/search_default_model.dart';
import 'package:netease_cloud_music/model/search_hot_detail_model.dart';
import 'package:netease_cloud_music/screens/search/search_history.dart';
import 'package:netease_cloud_music/utils/config.dart';
import 'package:netease_cloud_music/widgets/data_loading.dart';
import 'package:netease_cloud_music/widgets/song_item.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SearchScreens extends StatefulWidget {
  @override
  _SearchScreensState createState() => _SearchScreensState();
}

class _SearchScreensState extends State<SearchScreens> {
  GlobalKey textFieldKey;
  OverlayEntry searchTips;
  double height, width, xPosition, yPosition;
  bool isDropdownOpened = false;

  List<String> _items = ["a", "b", "c"];

  int _code = Config.SUCCESS_CODE;
  bool _isInit = false;
  SearchData _searchDefault;
  List<SearchDetail> _hotDetail = [];

  @override
  void initState() {
    textFieldKey = GlobalKey();
    super.initState();
  }

  Future _getSearchDefault() {
    return CommmonService().getSearchDefault().then((res) {
      if (res.statusCode == 200) {
        SearchDefaultModel _bean = SearchDefaultModel.fromJson(res.data);
        if (_bean.code == _code) {
          return _bean;
        }
      }
    });
  }

  Future _getSearcHotDetail() {
    return CommmonService().getSearchHotDetail().then((res) {
      if (res.statusCode == 200) {
        SearchHotDetailModel _bean = SearchHotDetailModel.fromJson(res.data);
        if (_bean.code == _code) {
          return _bean;
        }
      }
    });
  }

  OverlayEntry _buildSearchTips() {
    // 需要添加头部后退的iconbutton 24.0 + 16.0
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition - 40.0,
        width: width + 40.0,
        top: yPosition + height + 10,
        height: _items.length * height,
        child: Material(
          child: Container(
            height: _items.length * height,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 5.0,
              ),
            ]),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Text('${_items[index]}');
              },
              itemCount: _items.length,
            ),
          ),
        ),
      );
    });
  }

  void findDropdownPosition() {
    RenderBox renderBox = textFieldKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f1f1),
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        backgroundColor: Color(0xfff1f1f1),
        title: TextField(
          key: textFieldKey,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              hintText:
                  _searchDefault != null ? _searchDefault.showKeyword : '',
              suffixIcon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))),
          onTap: () {},
          onChanged: (value) {
            setState(() {
              if (isDropdownOpened) {
                searchTips.remove();
              } else {
                findDropdownPosition();
                OverlayState overlayState = Overlay.of(context);
                searchTips = _buildSearchTips();
                overlayState.insert(searchTips);
              }

              isDropdownOpened = !isDropdownOpened;
            });
          },
          // onSubmitted: (value) {
          //   print(value);
          // },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {},
          )
        ],
      ),
      body: EasyRefresh.custom(
          firstRefresh: true,
          firstRefreshWidget: Container(
              width: double.infinity,
              // height: double.infinity,
              child: DataLoading()),
          onRefresh: !_isInit
              ? () async {
                  SearchDefaultModel searchDefault = await _getSearchDefault();
                  SearchHotDetailModel searchDetail =
                      await _getSearcHotDetail();

                  if (mounted) {
                    _isInit = true;
                    _searchDefault = searchDefault.data;
                    _hotDetail = searchDetail.data;
                  }
                  setState(() {});
                }
              : null,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SearchHistory(),
                    Text(
                      '热搜榜',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '${index + 1}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: index < 3 ? Colors.red : Colors.black),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.0),
                          title: Text(
                            '${_hotDetail[index].searchWord}',
                            style: TextStyle(
                                fontWeight: index < 3
                                    ? FontWeight.w600
                                    : FontWeight.normal),
                          ),
                          subtitle: Text(
                            '${_hotDetail[index].content}',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 11.0),
                          ),
                        ),
                      ),
                      Text(
                        '${_hotDetail[index].score}',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xffcdcdcd), fontSize: 11.0),
                      ),
                    ],
                  ),
                );
              }, childCount: _hotDetail.length),
            )
          ]),
    );
  }
}
