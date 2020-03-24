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

class VideoUrlModel {
  int code;
  List<Urls> urls;

  VideoUrlModel({
    this.code,
    this.urls,
  });

  factory VideoUrlModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Urls> urls = jsonRes['urls'] is List ? [] : null;
    if (urls != null) {
      for (var item in jsonRes['urls']) {
        if (item != null) {
          tryCatch(() {
            urls.add(Urls.fromJson(item));
          });
        }
      }
    }

    return VideoUrlModel(
      code:
          convertValueByType(jsonRes['code'], int, stack: "VideoUrlModel-code"),
      urls: urls,
    );
  }
  Map<String, dynamic> toJson() => {
        'code': code,
        'urls': urls,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Urls {
  String id;
  bool needPay;
  Object payInfo;
  int r;
  int size;
  String url;
  int validityTime;

  Urls({
    this.id,
    this.needPay,
    this.payInfo,
    this.r,
    this.size,
    this.url,
    this.validityTime,
  });

  factory Urls.fromJson(jsonRes) => jsonRes == null
      ? null
      : Urls(
          id: convertValueByType(jsonRes['id'], String, stack: "Urls-id"),
          needPay: convertValueByType(jsonRes['needPay'], bool,
              stack: "Urls-needPay"),
          payInfo: convertValueByType(jsonRes['payInfo'], Object,
              stack: "Urls-payInfo"),
          r: convertValueByType(jsonRes['r'], int, stack: "Urls-r"),
          size: convertValueByType(jsonRes['size'], int, stack: "Urls-size"),
          url: convertValueByType(jsonRes['url'], String, stack: "Urls-url"),
          validityTime: convertValueByType(jsonRes['validityTime'], int,
              stack: "Urls-validityTime"),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'needPay': needPay,
        'payInfo': payInfo,
        'r': r,
        'size': size,
        'url': url,
        'validityTime': validityTime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
