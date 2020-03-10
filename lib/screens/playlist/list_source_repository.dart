import 'package:dio/dio.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:wangyiyun/api/api.dart';
import 'package:wangyiyun/model/top_quality_play_list_model.dart';
import 'package:wangyiyun/utils/config.dart';

class ListSourceRepository extends LoadingMoreBase<Playlists> {
  int before;
  int pageindex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;

  final String tag;
  final List firstData;
  bool isInit;
  ListSourceRepository({this.firstData, this.isInit = false, this.tag = ""});

  @override
  bool get hasMore => _hasMore || forceRefresh;

  @override
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    _hasMore = true;
    pageindex = 1;
    //force to refresh list when you don't want clear list before request
    //for the case, if your list already has 20 items.
    forceRefresh = !clearBeforeRequest;
    var result = await super.refresh(clearBeforeRequest);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    List<Playlists> source = [];
    String url = "";

    if (this.length == 0) {
      url = "${Api.TOP_PLAY_LIST}?limit=30&cat=$tag";
    } else {
      url = "${Api.TOP_PLAY_LIST}?limit=30&cat=$tag&before=$before";
    }
    bool isSuccess = false;
    try {
      //to show loading more clearly, in your app,remove this
      await Future.delayed(Duration(milliseconds: 500));

      if (!this.isInit) {
        var result = await Dio()
            .get(url, options: Options(headers: Config().getHeader()));

        if (result.statusCode == 200) {
          TopQualityPlayListModel _bean =
              TopQualityPlayListModel.fromJson(result.data);
          if (_bean.code == Config.SUCCESS_CODE) {
            source = _bean.playlists;
          }
        }
      } else {
        source = firstData;
      }

      if (pageindex == 1) {
        this.clear();
      }
      for (var item in source) {
        if (!this.contains(item) && hasMore) this.add(item);
      }
      _hasMore = source.length >= 30;
      pageindex++;
      before = source.last.updateTime;
      isSuccess = true;
    } catch (exception, stack) {
      isSuccess = false;
      print(exception);
      print(stack);
    }
    return isSuccess;
  }
}
