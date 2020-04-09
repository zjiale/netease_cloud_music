import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/model/search_default_model.dart';
import 'package:netease_cloud_music/model/search_hot_detail_model.dart';
import 'package:netease_cloud_music/model/search_suggest_model.dart';
import 'package:netease_cloud_music/screens/search/search_history.dart';
import 'package:netease_cloud_music/utils/cache.dart';
import 'package:netease_cloud_music/utils/config.dart';
import 'package:netease_cloud_music/widgets/data_loading.dart';
import 'package:netease_cloud_music/widgets/song_item.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SearchScreens extends StatefulWidget {
  @override
  _SearchScreensState createState() => _SearchScreensState();
}

class _SearchScreensState extends State<SearchScreens> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocus = FocusNode();

  GlobalKey textFieldKey;
  OverlayEntry searchSuggest;
  double height, width, xPosition, yPosition;

  int _code = Config.SUCCESS_CODE;
  bool _isInit = false;
  List<String> _searchHistory = [];
  List<AllMatch> _keywords = [];
  SearchData _searchDefault;
  List<SearchDetail> _hotDetail = [];

  static const String SEARCH_KEY = 'SearchHistory';

  @override
  void initState() {
    textFieldKey = GlobalKey();
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
          return _bean.result.allMatch;
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
                          _searchController.text = _keywords[index].keyword;
                          _searchFocus.unfocus();
                          searchSuggest.remove();
                          searchSuggest = null;
                          setState(() {});
                        },
                        child: SearchItem(
                          text: _keywords[index].keyword,
                          itemHeight: height,
                          isLastItem: false,
                        ));
                  },
                  // separatorBuilder: (context, index) => Divider(),
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

  @override
  void dispose() {
    _searchController?.dispose();
    _searchFocus.dispose();
    super.dispose();
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
              _keywords = await _getSearcSuggest(value);
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
          topBouncing: !_isInit,
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
                    SearchHistory(list: _searchHistory),
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
                return InkWell(
                  onTap: () {
                    _searchController.text = _hotDetail[index].searchWord;
                    int s = _searchHistory.lastIndexWhere(
                        (item) => item == _hotDetail[index].searchWord);
                    if (s != -1) {
                      _searchHistory.removeAt(s);
                      _searchHistory.insert(0, _hotDetail[index].searchWord);
                      SpUtil.preferences
                          .setStringList(SEARCH_KEY, _searchHistory);
                    }

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
                                color: index < 3 ? Colors.red : Colors.black),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            dense: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            title: RichText(
                                text: TextSpan(
                                    text: '${_hotDetail[index].searchWord}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: index < 3
                                            ? FontWeight.w600
                                            : FontWeight.normal),
                                    children: [
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: _hotDetail[index].iconType != 0
                                          ? Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              child: ExtendedImage.network(
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
          ]),
    );
  }
}

class SearchItem extends StatelessWidget {
  final String text;
  final double itemHeight;
  final bool isLastItem;

  SearchItem({
    Key key,
    this.text,
    this.itemHeight,
    this.isLastItem,
  }) : super(key: key);

  factory SearchItem.last({String text, bool isLastItem}) {
    return SearchItem(
      text: text,
      isLastItem: true,
    );
  }

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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.search,
              color: Colors.black54,
              size: 18.0,
            ),
          ),
          Flexible(
              child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black54,
            ),
          ))
        ],
      ),
    );
  }
}
