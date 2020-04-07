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

class PlaylistsTagsModel {
  List<Tags> tags;
  int code;

  PlaylistsTagsModel({
    this.tags,
    this.code,
  });

  factory PlaylistsTagsModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Tags> tags = jsonRes['tags'] is List ? [] : null;
    if (tags != null) {
      for (var item in jsonRes['tags']) {
        if (item != null) {
          tryCatch(() {
            tags.add(Tags.fromJson(item));
          });
        }
      }
    }

    return PlaylistsTagsModel(
      tags: tags,
      code: convertValueByType(jsonRes['code'], int,
          stack: "PlaylistsTagsModel-code"),
    );
  }
  Map<String, dynamic> toJson() => {
        'tags': tags,
        'code': code,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Tags {
  PlaylistTag playlistTag;
  bool activity;
  bool hot;
  int createTime;
  int usedCount;
  int position;
  int category;
  String name;
  int id;
  int type;

  Tags({
    this.playlistTag,
    this.activity,
    this.hot,
    this.createTime,
    this.usedCount,
    this.position,
    this.category,
    this.name,
    this.id,
    this.type,
  });

  factory Tags.fromJson(jsonRes) => jsonRes == null
      ? null
      : Tags(
          playlistTag: PlaylistTag.fromJson(jsonRes['playlistTag']),
          activity: convertValueByType(jsonRes['activity'], bool,
              stack: "Tags-activity"),
          hot: convertValueByType(jsonRes['hot'], bool, stack: "Tags-hot"),
          createTime: convertValueByType(jsonRes['createTime'], int,
              stack: "Tags-createTime"),
          usedCount: convertValueByType(jsonRes['usedCount'], int,
              stack: "Tags-usedCount"),
          position: convertValueByType(jsonRes['position'], int,
              stack: "Tags-position"),
          category: convertValueByType(jsonRes['category'], int,
              stack: "Tags-category"),
          name: convertValueByType(jsonRes['name'], String, stack: "Tags-name"),
          id: convertValueByType(jsonRes['id'], int, stack: "Tags-id"),
          type: convertValueByType(jsonRes['type'], int, stack: "Tags-type"),
        );
  Map<String, dynamic> toJson() => {
        'playlistTag': playlistTag,
        'activity': activity,
        'hot': hot,
        'createTime': createTime,
        'usedCount': usedCount,
        'position': position,
        'category': category,
        'name': name,
        'id': id,
        'type': type,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class PlaylistTag {
  int id;
  String name;
  int category;
  int usedCount;
  int type;
  int position;
  int createTime;
  int highQuality;
  int highQualityPos;
  int officialPos;

  PlaylistTag({
    this.id,
    this.name,
    this.category,
    this.usedCount,
    this.type,
    this.position,
    this.createTime,
    this.highQuality,
    this.highQualityPos,
    this.officialPos,
  });

  factory PlaylistTag.fromJson(jsonRes) => jsonRes == null
      ? null
      : PlaylistTag(
          id: convertValueByType(jsonRes['id'], int, stack: "PlaylistTag-id"),
          name: convertValueByType(jsonRes['name'], String,
              stack: "PlaylistTag-name"),
          category: convertValueByType(jsonRes['category'], int,
              stack: "PlaylistTag-category"),
          usedCount: convertValueByType(jsonRes['usedCount'], int,
              stack: "PlaylistTag-usedCount"),
          type: convertValueByType(jsonRes['type'], int,
              stack: "PlaylistTag-type"),
          position: convertValueByType(jsonRes['position'], int,
              stack: "PlaylistTag-position"),
          createTime: convertValueByType(jsonRes['createTime'], int,
              stack: "PlaylistTag-createTime"),
          highQuality: convertValueByType(jsonRes['highQuality'], int,
              stack: "PlaylistTag-highQuality"),
          highQualityPos: convertValueByType(jsonRes['highQualityPos'], int,
              stack: "PlaylistTag-highQualityPos"),
          officialPos: convertValueByType(jsonRes['officialPos'], int,
              stack: "PlaylistTag-officialPos"),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'usedCount': usedCount,
        'type': type,
        'position': position,
        'createTime': createTime,
        'highQuality': highQuality,
        'highQualityPos': highQualityPos,
        'officialPos': officialPos,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
