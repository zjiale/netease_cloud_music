import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/model/search_default_model.dart';
import 'package:netease_cloud_music/model/search_hot_detail_model.dart';
import 'package:netease_cloud_music/model/search_suggest_model.dart';
import 'package:netease_cloud_music/model/search_type.dart';
import 'package:netease_cloud_music/screens/search/search_detail_screens.dart';
import 'package:netease_cloud_music/screens/search/search_history.dart';
import 'package:netease_cloud_music/utils/cache.dart';
import 'package:netease_cloud_music/utils/config.dart';
import 'package:netease_cloud_music/widgets/data_loading.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

class SearchScreens extends StatefulWidget {
  @override
  _SearchScreensState createState() => _SearchScreensState();
}

class _SearchScreensState extends State<SearchScreens>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  TabController _tabController;
  FocusNode _searchFocus = FocusNode();

  int _code = Config.SUCCESS_CODE;
  List<SearchType> _searchType = Config.searchType;

  GlobalKey textFieldKey;
  OverlayEntry searchSuggest;
  double height, width, xPosition, yPosition;

  bool _isInit = false;
  List<String> _searchHistory = [];
  List<String> _keywords = [];
  SearchData _searchDefault;
  List<SearchDetail> _hotDetail = [];

  bool _isSearching = false; // 0为搜索首页,1为搜索详情

  static const String SEARCH_KEY = 'SearchHistory';

  @override
  void initState() {
    textFieldKey = GlobalKey();
    _tabController = TabController(vsync: this, length: _searchType.length);
    var history = SpUtil.preferences.get(SEARCH_KEY);
    if (history != null) {
      List jsonStr = json.decode(json.encode(history));
      for (int i = 0; i < jsonStr.length; i++) {
        _searchHistory.insert(i, jsonStr[i]);
      }
      setState(() {});
    }
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

  Future _getSearcSuggest(String keywords) {
    return CommmonService().getSearchSuggest(keywords).then((res) {
      if (res.statusCode == 200) {
        SearchSuggestModel _bean = SearchSuggestModel.fromJson(res.data);
        if (_bean.code == _code) {
          return _bean;
        }
      }
    });
  }

  OverlayEntry _buildSearchSuggest() {
    // 需要添加头部后退的iconbutton 24.0 + 16.0
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition - 40.0,
        width: width + 40.0,
        top: yPosition + height + 10,
        height: _keywords.length * height,
        child: Material(
          child: Container(
              height: _keywords.length * height,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                ),
              ]),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          _searchController.text = _keywords[index];
                          add2history(_keywords[index]);
                          _searchFocus.unfocus();
                          searchSuggest.remove();
                          searchSuggest = null;
                          setState(() {});
                        },
                        child: SearchItem(
                          text: _keywords[index],
                          itemHeight: height,
                          isFirstItem: index == 0 ? true : false,
                          isLastItem:
                              index == _keywords.length - 1 ? true : false,
                        ));
                  },
                  itemCount: _keywords.length)),
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

  void removeOverlay() {
    searchSuggest.remove();
    searchSuggest = null;
  }

  void add2history(String searchWord) {
    int s = _searchHistory.lastIndexWhere((item) => item == searchWord);

    if (s != -1) _searchHistory.removeAt(s);
    _searchHistory.insert(0, searchWord);
    SpUtil.preferences.setStringList(SEARCH_KEY, _searchHistory);
  }

  void clearCallback(val) {
    if (val) _searchHistory.clear();
    setState(() {});
  }

  @override
  void dispose() {
    _searchController?.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: _isSearching ? 1.0 : 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: TextField(
          key: textFieldKey,
          controller: _searchController,
          focusNode: _searchFocus,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              hintText:
                  _searchDefault != null ? _searchDefault.showKeyword : '',
              suffixIcon: !_searchFocus.hasFocus
                  ? null
                  : _searchController.text.isEmpty
                      ? null
                      : IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            WidgetsBinding.instance.addPostFrameCallback(
                                (_) => _searchController.clear());
                            if (searchSuggest != null) removeOverlay();
                            setState(() {});
                          },
                        ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))),
          onTap: () {
            findDropdownPosition();
            setState(() {});
          },
          onChanged: (value) async {
            if (value.isNotEmpty) {
              SearchSuggestModel search = await _getSearcSuggest(value);
              if (search.result.allMatch != null) {
                _keywords.clear();
                search.result.allMatch.forEach((searchWord) {
                  _keywords.add(searchWord.keyword);
                });
                _keywords.insert(0, value);
              }
              if (searchSuggest != null) removeOverlay();

              searchSuggest = _buildSearchSuggest();
              OverlayState overlayState = Overlay.of(context);
              overlayState.insert(searchSuggest);
            } else {
              if (searchSuggest != null) removeOverlay();
            }
            setState(() {});
          },
        ),
        actions: !_isSearching
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.person_outline),
                  onPressed: () {},
                )
              ]
            : [],
        bottom: !_isSearching
            ? null
            : TabBar(
                isScrollable: true,
                controller: _tabController,
                labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black54,
                indicatorColor: Theme.of(context).primaryColor,
                indicatorSize: TabBarIndicatorSize.label,
                onTap: (index) {
                  // if (_tabIndex == index) return;
                  // setState(() {
                  //   _tabIndex = index;
                  // });
                },
                tabs: _searchType.map((key) {
                  return Tab(
                    text: key.name,
                  );
                }).toList(),
              ),
      ),
      body: !_isSearching
          ? EasyRefresh.custom(
              firstRefresh: true,
              firstRefreshWidget: Container(
                  width: double.infinity,
                  // height: double.infinity,
                  child: DataLoading()),
              topBouncing: !_isInit,
              onRefresh: !_isInit
                  ? () async {
                      SearchDefaultModel searchDefault =
                          await _getSearchDefault();
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
                          _searchHistory.length > 0
                              ? SearchHistory(
                                  list: _searchHistory,
                                  callback: (val) => clearCallback(val))
                              : SizedBox(height: 40.0),
                          Text(
                            '热搜榜',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return InkWell(
                        onTap: () {
                          _searchController.text = _hotDetail[index].searchWord;
                          _isSearching = true;
                          add2history(_hotDetail[index].searchWord);
                          _searchFocus.unfocus();
                          setState(() {});
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '${index + 1}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: index < 3
                                          ? Colors.red
                                          : Colors.black),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  dense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  title: RichText(
                                      text: TextSpan(
                                          text:
                                              '${_hotDetail[index].searchWord}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: index < 3
                                                  ? FontWeight.w600
                                                  : FontWeight.normal),
                                          children: [
                                        WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: _hotDetail[index].iconType !=
                                                    0
                                                ? Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5.0),
                                                    child:
                                                        ExtendedImage.network(
                                                      _hotDetail[index].iconUrl,
                                                      width: _hotDetail[index]
                                                                  .iconType !=
                                                              5
                                                          ? 30.0
                                                          : 12.0,
                                                    ),
                                                  )
                                                : Container())
                                      ])),
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
                                style: TextStyle(
                                    color: Color(0xffcdcdcd), fontSize: 11.0),
                              ),
                            ],
                          ),
                        ),
                      );
                    }, childCount: _hotDetail.length),
                  )
                ])
          : extended.NestedScrollView(
              pinnedHeaderSliverHeightBuilder: () {
                return MediaQuery.of(context).padding.top + kToolbarHeight;
              },
              innerScrollPositionKeyBuilder: () {
                return Key("Tag${_tabController.index}");
              },
              headerSliverBuilder: (context, innerBoxIsScrolled) =>
                  <Widget>[SliverToBoxAdapter()],
              body: TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: _searchType.map((key) {
                  return SearchDetailScreens(
                    keyword: _searchController.text,
                    type: key.type,
                  );
                }).toList(),
              ),
            ),
    );
  }
}

class SearchItem extends StatelessWidget {
  final String text;
  final double itemHeight;
  final bool isFirstItem;
  final bool isLastItem;

  SearchItem({
    Key key,
    this.text,
    this.itemHeight,
    this.isFirstItem,
    this.isLastItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
          border: Border(
              bottom: isLastItem
                  ? BorderSide.none
                  : BorderSide(color: Theme.of(context).dividerColor))),
      child: Row(
        children: <Widget>[
          isFirstItem
              ? SizedBox(
                  width: 12.0,
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.black54,
                    size: 20.0,
                  ),
                ),
          Flexible(
              child: Text(
            isFirstItem ? '搜索 \"$text\"' : text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15.0,
              color: isFirstItem ? Colors.blueAccent : Colors.black54,
            ),
          ))
        ],
      ),
    );
  }
}
