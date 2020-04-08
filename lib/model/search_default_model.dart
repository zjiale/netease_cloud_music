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

class SearchDefaultModel {
  int code;
  SearchData data;

  SearchDefaultModel({
    this.code,
    this.data,
  });

  factory SearchDefaultModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : SearchDefaultModel(
          code: convertValueByType(jsonRes['code'], int,
              stack: "SearchDefaultModel-code"),
          data: SearchData.fromJson(jsonRes['data']),
        );
  Map<String, dynamic> toJson() => {
        'code': code,
        'data': data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class SearchData {
  int action;
  String alg;
  int gap;
  String realkeyword;
  int searchType;
  String showKeyword;

  SearchData({
    this.action,
    this.alg,
    this.gap,
    this.realkeyword,
    this.searchType,
    this.showKeyword,
  });

  factory SearchData.fromJson(jsonRes) => jsonRes == null
      ? null
      : SearchData(
          action: convertValueByType(jsonRes['action'], int,
              stack: "SearchData-action"),
          alg: convertValueByType(jsonRes['alg'], String,
              stack: "SearchData-alg"),
          gap: convertValueByType(jsonRes['gap'], int, stack: "SearchData-gap"),
          realkeyword: convertValueByType(jsonRes['realkeyword'], String,
              stack: "SearchData-realkeyword"),
          searchType: convertValueByType(jsonRes['searchType'], int,
              stack: "SearchData-searchType"),
          showKeyword: convertValueByType(jsonRes['showKeyword'], String,
              stack: "SearchData-showKeyword"),
        );
  Map<String, dynamic> toJson() => {
        'action': action,
        'alg': alg,
        'gap': gap,
        'realkeyword': realkeyword,
        'searchType': searchType,
        'showKeyword': showKeyword,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
