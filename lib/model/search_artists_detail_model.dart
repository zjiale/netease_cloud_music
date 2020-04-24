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

class SearchArtistsDetailModel {
  int code;
  Result result;

  SearchArtistsDetailModel({
    this.code,
    this.result,
  });

  factory SearchArtistsDetailModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : SearchArtistsDetailModel(
          code: convertValueByType(jsonRes['code'], int,
              stack: "SearchArtistsDetailModel-code"),
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
  int artistCount;
  List<Artists> artists;

  Result({
    this.artistCount,
    this.artists,
  });

  factory Result.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Artists> artists = jsonRes['artists'] is List ? [] : null;
    if (artists != null) {
      for (var item in jsonRes['artists']) {
        if (item != null) {
          tryCatch(() {
            artists.add(Artists.fromJson(item));
          });
        }
      }
    }

    return Result(
      artistCount: convertValueByType(jsonRes['artistCount'], int,
          stack: "Result-artistCount"),
      artists: artists,
    );
  }
  Map<String, dynamic> toJson() => {
        'artistCount': artistCount,
        'artists': artists,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Artists {
  int accountId;
  int albumSize;
  String alg;
  List<String> alia;
  List<String> alias;
  bool followed;
  int id;
  int img1v1;
  String img1v1Url;
  int mvSize;
  String name;
  int picId;
  String picUrl;
  Object trans;

  Artists({
    this.accountId,
    this.albumSize,
    this.alg,
    this.alia,
    this.alias,
    this.followed,
    this.id,
    this.img1v1,
    this.img1v1Url,
    this.mvSize,
    this.name,
    this.picId,
    this.picUrl,
    this.trans,
  });

  factory Artists.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<String> alia = jsonRes['alia'] is List ? [] : null;
    if (alia != null) {
      for (var item in jsonRes['alia']) {
        if (item != null) {
          tryCatch(() {
            alia.add(item);
          });
        }
      }
    }

    List<String> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          tryCatch(() {
            alias.add(item);
          });
        }
      }
    }

    return Artists(
      accountId: convertValueByType(jsonRes['accountId'], int,
          stack: "Artists-accountId"),
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "Artists-albumSize"),
      alg: convertValueByType(jsonRes['alg'], String, stack: "Artists-alg"),
      alia: alia,
      alias: alias,
      followed: convertValueByType(jsonRes['followed'], bool,
          stack: "Artists-followed"),
      id: convertValueByType(jsonRes['id'], int, stack: "Artists-id"),
      img1v1:
          convertValueByType(jsonRes['img1v1'], int, stack: "Artists-img1v1"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "Artists-img1v1Url"),
      mvSize:
          convertValueByType(jsonRes['mvSize'], int, stack: "Artists-mvSize"),
      name: convertValueByType(jsonRes['name'], String, stack: "Artists-name"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Artists-picId"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "Artists-picUrl"),
      trans:
          convertValueByType(jsonRes['trans'], Object, stack: "Artists-trans"),
    );
  }
  Map<String, dynamic> toJson() => {
        'accountId': accountId,
        'albumSize': albumSize,
        'alg': alg,
        'alia': alia,
        'alias': alias,
        'followed': followed,
        'id': id,
        'img1v1': img1v1,
        'img1v1Url': img1v1Url,
        'mvSize': mvSize,
        'name': name,
        'picId': picId,
        'picUrl': picUrl,
        'trans': trans,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
