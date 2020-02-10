import 'package:dio/dio.dart';
import 'package:wangyiyun/api/api.dart';
import 'package:wangyiyun/utils/config.dart';
import 'package:wangyiyun/model/recommend_list_model.dart';

class CommmonService {
  Future<Response> getBanner(int type) async {
    return await Dio().get("${Api.BANNER}?type=$type", options: _getOptions());
  }

  void getRecommendList(Function callback) async {
    Dio().get(Api.RECOMMEND_LIST, options: _getOptions()).then((response) {
      callback(RecommendListModel.fromJson(response.data));
    });
  }

  Options _getOptions() {
    return Options(headers: Config().getHeader());
  }
}
