import 'dart:convert' show json;
import 'package:flutter/foundation.dart';

dynamic convertValueByType(value, Type type, {String stack: ""}) {
  if (value == null) {
    debugPrint("$stack : value is null");
    if (type == String) {
      return "";
    } else if (type == int) {
      return 0;
    } else if (type == double) {
      return 0.0;
    } else if (type == bool) {
      return false;
    }
    return null;
  }

  if (value.runtimeType == type) {
    return value;
  }
  var valueS = value.toString();
  debugPrint("$stack : ${value.runtimeType} is not $type type");
  if (type == String) {
    return valueS;
  } else if (type == int) {
    return int.tryParse(valueS);
  } else if (type == double) {
    return double.tryParse(valueS);
  } else if (type == bool) {
    valueS = valueS.toLowerCase();
    var intValue = int.tryParse(valueS);
    if (intValue != null) {
      return intValue == 1;
    }
    return valueS == "true";
  }
}

void tryCatch(Function f) {
  try {
    f?.call();
  } catch (e, stack) {
    debugPrint("$e");
    debugPrint("$stack");
  }
}

class SearchHotDetailModel {
  int code;
  List<SearchDetail> data;
  String message;

  SearchHotDetailModel({
    this.code,
    this.data,
    this.message,
  });

  factory SearchHotDetailModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<SearchDetail> data = jsonRes['data'] is List ? [] : null;
    if (data != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          tryCatch(() {
            data.add(SearchDetail.fromJson(item));
          });
        }
      }
    }

    return SearchHotDetailModel(
      code: convertValueByType(jsonRes['code'], int,
          stack: "SearchHotDetailModel-code"),
      data: data,
      message: convertValueByType(jsonRes['message'], String,
          stack: "SearchHotDetailModel-message"),
    );
  }
  Map<String, dynamic> toJson() => {
        'code': code,
        'data': data,
        'message': message,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class SearchDetail {
  String alg;
  String content;
  int iconType;
  String iconUrl;
  int score;
  String searchWord;
  int source;
  String url;

  SearchDetail({
    this.alg,
    this.content,
    this.iconType,
    this.iconUrl,
    this.score,
    this.searchWord,
    this.source,
    this.url,
  });

  factory SearchDetail.fromJson(jsonRes) => jsonRes == null
      ? null
      : SearchDetail(
          alg: convertValueByType(jsonRes['alg'], String,
              stack: "SearchDetail-alg"),
          content: convertValueByType(jsonRes['content'], String,
              stack: "SearchDetail-content"),
          iconType: convertValueByType(jsonRes['iconType'], int,
              stack: "SearchDetail-iconType"),
          iconUrl: convertValueByType(jsonRes['iconUrl'], String,
              stack: "SearchDetail-iconUrl"),
          score: convertValueByType(jsonRes['score'], int,
              stack: "SearchDetail-score"),
          searchWord: convertValueByType(jsonRes['searchWord'], String,
              stack: "SearchDetail-searchWord"),
          source: convertValueByType(jsonRes['source'], int,
              stack: "SearchDetail-source"),
          url: convertValueByType(jsonRes['url'], String,
              stack: "SearchDetail-url"),
        );
  Map<String, dynamic> toJson() => {
        'alg': alg,
        'content': content,
        'iconType': iconType,
        'iconUrl': iconUrl,
        'score': score,
        'searchWord': searchWord,
        'source': source,
        'url': url,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
