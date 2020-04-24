import 'dart:convert' show json;
import 'package:flutter/foundation.dart';

dynamic convertValueByType(value, Type type, {String stack: ""}) {
  if (value == null) {
    // debugPrint("$stack : value is null");
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
  // debugPrint("$stack : ${value.runtimeType} is not $type type");
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

class SearchSuggestModel {
  int code;
  Result result;

  SearchSuggestModel({
    this.code,
    this.result,
  });

  factory SearchSuggestModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : SearchSuggestModel(
          code: convertValueByType(jsonRes['code'], int,
              stack: "SearchSuggestModel-code"),
          result: Result.fromJson(jsonRes['result']),
        );
  Map<String, dynamic> toJson() => {
        'code': code,
        'result': result,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Result {
  List<AllMatch> allMatch;

  Result({
    this.allMatch,
  });

  factory Result.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<AllMatch> allMatch = jsonRes['allMatch'] is List ? [] : null;
    if (allMatch != null) {
      for (var item in jsonRes['allMatch']) {
        if (item != null) {
          tryCatch(() {
            allMatch.add(AllMatch.fromJson(item));
          });
        }
      }
    }

    return Result(
      allMatch: allMatch,
    );
  }
  Map<String, dynamic> toJson() => {
        'allMatch': allMatch,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class AllMatch {
  String alg;
  String keyword;
  String lastKeyword;
  int type;

  AllMatch({
    this.alg,
    this.keyword,
    this.lastKeyword,
    this.type,
  });

  factory AllMatch.fromJson(jsonRes) => jsonRes == null
      ? null
      : AllMatch(
          alg:
              convertValueByType(jsonRes['alg'], String, stack: "AllMatch-alg"),
          keyword: convertValueByType(jsonRes['keyword'], String,
              stack: "AllMatch-keyword"),
          lastKeyword: convertValueByType(jsonRes['lastKeyword'], String,
              stack: "AllMatch-lastKeyword"),
          type:
              convertValueByType(jsonRes['type'], int, stack: "AllMatch-type"),
        );
  Map<String, dynamic> toJson() => {
        'alg': alg,
        'keyword': keyword,
        'lastKeyword': lastKeyword,
        'type': type,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
