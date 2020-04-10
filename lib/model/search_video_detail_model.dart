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

class SearchVideoDetailModel {
  int code;
  Result result;

  SearchVideoDetailModel({
    this.code,
    this.result,
  });

  factory SearchVideoDetailModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : SearchVideoDetailModel(
          code: convertValueByType(jsonRes['code'], int,
              stack: "SearchVideoDetailModel-code"),
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
  int videoCount;
  List<Videos> videos;

  Result({
    this.videoCount,
    this.videos,
  });

  factory Result.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Videos> videos = jsonRes['videos'] is List ? [] : null;
    if (videos != null) {
      for (var item in jsonRes['videos']) {
        if (item != null) {
          tryCatch(() {
            videos.add(Videos.fromJson(item));
          });
        }
      }
    }

    return Result(
      videoCount: convertValueByType(jsonRes['videoCount'], int,
          stack: "Result-videoCount"),
      videos: videos,
    );
  }
  Map<String, dynamic> toJson() => {
        'videoCount': videoCount,
        'videos': videos,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Videos {
  String alg;
  Object aliaName;
  String coverUrl;
  List<Creator> creator;
  int durationms;
  List<int> markTypes;
  int playTime;
  String title;
  Object transName;
  int type;
  String vid;

  Videos({
    this.alg,
    this.aliaName,
    this.coverUrl,
    this.creator,
    this.durationms,
    this.markTypes,
    this.playTime,
    this.title,
    this.transName,
    this.type,
    this.vid,
  });

  factory Videos.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Creator> creator = jsonRes['creator'] is List ? [] : null;
    if (creator != null) {
      for (var item in jsonRes['creator']) {
        if (item != null) {
          tryCatch(() {
            creator.add(Creator.fromJson(item));
          });
        }
      }
    }

    List<int> markTypes = jsonRes['markTypes'] is List ? [] : null;
    if (markTypes != null) {
      for (var item in jsonRes['markTypes']) {
        if (item != null) {
          tryCatch(() {
            markTypes.add(item);
          });
        }
      }
    }

    return Videos(
      alg: convertValueByType(jsonRes['alg'], String, stack: "Videos-alg"),
      aliaName: convertValueByType(jsonRes['aliaName'], Object,
          stack: "Videos-aliaName"),
      coverUrl: convertValueByType(jsonRes['coverUrl'], String,
          stack: "Videos-coverUrl"),
      creator: creator,
      durationms: convertValueByType(jsonRes['durationms'], int,
          stack: "Videos-durationms"),
      markTypes: markTypes,
      playTime: convertValueByType(jsonRes['playTime'], int,
          stack: "Videos-playTime"),
      title:
          convertValueByType(jsonRes['title'], String, stack: "Videos-title"),
      transName: convertValueByType(jsonRes['transName'], Object,
          stack: "Videos-transName"),
      type: convertValueByType(jsonRes['type'], int, stack: "Videos-type"),
      vid: convertValueByType(jsonRes['vid'], String, stack: "Videos-vid"),
    );
  }
  Map<String, dynamic> toJson() => {
        'alg': alg,
        'aliaName': aliaName,
        'coverUrl': coverUrl,
        'creator': creator,
        'durationms': durationms,
        'markTypes': markTypes,
        'playTime': playTime,
        'title': title,
        'transName': transName,
        'type': type,
        'vid': vid,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Creator {
  int userId;
  String userName;

  Creator({
    this.userId,
    this.userName,
  });

  factory Creator.fromJson(jsonRes) => jsonRes == null
      ? null
      : Creator(
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "Creator-userId"),
          userName: convertValueByType(jsonRes['userName'], String,
              stack: "Creator-userName"),
        );
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userName': userName,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
