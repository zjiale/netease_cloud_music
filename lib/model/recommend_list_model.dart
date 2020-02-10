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

class RecommendListModel {
  int code;
  bool featureFirst;
  bool haveRcmdSongs;
  List<Recommend> recommend;

  RecommendListModel({
    this.code,
    this.featureFirst,
    this.haveRcmdSongs,
    this.recommend,
  });

  factory RecommendListModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Recommend> recommend = jsonRes['recommend'] is List ? [] : null;
    if (recommend != null) {
      for (var item in jsonRes['recommend']) {
        if (item != null) {
          tryCatch(() {
            recommend.add(Recommend.fromJson(item));
          });
        }
      }
    }

    return RecommendListModel(
      code: convertValueByType(jsonRes['code'], int,
          stack: "RecommendListModel-code"),
      featureFirst: convertValueByType(jsonRes['featureFirst'], bool,
          stack: "RecommendListModel-featureFirst"),
      haveRcmdSongs: convertValueByType(jsonRes['haveRcmdSongs'], bool,
          stack: "RecommendListModel-haveRcmdSongs"),
      recommend: recommend,
    );
  }
  Map<String, dynamic> toJson() => {
        'code': code,
        'featureFirst': featureFirst,
        'haveRcmdSongs': haveRcmdSongs,
        'recommend': recommend,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Recommend {
  int id;
  int type;
  String name;
  String copywriter;
  String picUrl;
  int playcount;
  int createTime;
  Creator creator;
  int trackCount;
  int userId;
  String alg;

  Recommend({
    this.id,
    this.type,
    this.name,
    this.copywriter,
    this.picUrl,
    this.playcount,
    this.createTime,
    this.creator,
    this.trackCount,
    this.userId,
    this.alg,
  });

  factory Recommend.fromJson(jsonRes) => jsonRes == null
      ? null
      : Recommend(
          id: convertValueByType(jsonRes['id'], int, stack: "Recommend-id"),
          type:
              convertValueByType(jsonRes['type'], int, stack: "Recommend-type"),
          name: convertValueByType(jsonRes['name'], String,
              stack: "Recommend-name"),
          copywriter: convertValueByType(jsonRes['copywriter'], String,
              stack: "Recommend-copywriter"),
          picUrl: convertValueByType(jsonRes['picUrl'], String,
              stack: "Recommend-picUrl"),
          playcount: convertValueByType(jsonRes['playcount'], int,
              stack: "Recommend-playcount"),
          createTime: convertValueByType(jsonRes['createTime'], int,
              stack: "Recommend-createTime"),
          creator: Creator.fromJson(jsonRes['creator']),
          trackCount: convertValueByType(jsonRes['trackCount'], int,
              stack: "Recommend-trackCount"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "Recommend-userId"),
          alg: convertValueByType(jsonRes['alg'], String,
              stack: "Recommend-alg"),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'name': name,
        'copywriter': copywriter,
        'picUrl': picUrl,
        'playcount': playcount,
        'createTime': createTime,
        'creator': creator,
        'trackCount': trackCount,
        'userId': userId,
        'alg': alg,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Creator {
  int accountStatus;
  int userId;
  String avatarUrl;
  int authStatus;
  int userType;
  String nickname;
  int vipType;
  int province;
  int gender;
  int birthday;
  int city;
  int avatarImgId;
  int backgroundImgId;
  String avatarImgIdStr;
  String backgroundImgIdStr;
  String detailDescription;
  bool defaultAvatar;
  Object expertTags;
  int djStatus;
  bool followed;
  String backgroundUrl;
  String description;
  bool mutual;
  Object remarkName;
  String signature;
  int authority;

  Creator({
    this.accountStatus,
    this.userId,
    this.avatarUrl,
    this.authStatus,
    this.userType,
    this.nickname,
    this.vipType,
    this.province,
    this.gender,
    this.birthday,
    this.city,
    this.avatarImgId,
    this.backgroundImgId,
    this.avatarImgIdStr,
    this.backgroundImgIdStr,
    this.detailDescription,
    this.defaultAvatar,
    this.expertTags,
    this.djStatus,
    this.followed,
    this.backgroundUrl,
    this.description,
    this.mutual,
    this.remarkName,
    this.signature,
    this.authority,
  });

  factory Creator.fromJson(jsonRes) => jsonRes == null
      ? null
      : Creator(
          accountStatus: convertValueByType(jsonRes['accountStatus'], int,
              stack: "Creator-accountStatus"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "Creator-userId"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "Creator-avatarUrl"),
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "Creator-authStatus"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "Creator-userType"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "Creator-nickname"),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "Creator-vipType"),
          province: convertValueByType(jsonRes['province'], int,
              stack: "Creator-province"),
          gender: convertValueByType(jsonRes['gender'], int,
              stack: "Creator-gender"),
          birthday: convertValueByType(jsonRes['birthday'], int,
              stack: "Creator-birthday"),
          city: convertValueByType(jsonRes['city'], int, stack: "Creator-city"),
          avatarImgId: convertValueByType(jsonRes['avatarImgId'], int,
              stack: "Creator-avatarImgId"),
          backgroundImgId: convertValueByType(jsonRes['backgroundImgId'], int,
              stack: "Creator-backgroundImgId"),
          avatarImgIdStr: convertValueByType(jsonRes['avatarImgIdStr'], String,
              stack: "Creator-avatarImgIdStr"),
          backgroundImgIdStr: convertValueByType(
              jsonRes['backgroundImgIdStr'], String,
              stack: "Creator-backgroundImgIdStr"),
          detailDescription: convertValueByType(
              jsonRes['detailDescription'], String,
              stack: "Creator-detailDescription"),
          defaultAvatar: convertValueByType(jsonRes['defaultAvatar'], bool,
              stack: "Creator-defaultAvatar"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "Creator-expertTags"),
          djStatus: convertValueByType(jsonRes['djStatus'], int,
              stack: "Creator-djStatus"),
          followed: convertValueByType(jsonRes['followed'], bool,
              stack: "Creator-followed"),
          backgroundUrl: convertValueByType(jsonRes['backgroundUrl'], String,
              stack: "Creator-backgroundUrl"),
          description: convertValueByType(jsonRes['description'], String,
              stack: "Creator-description"),
          mutual: convertValueByType(jsonRes['mutual'], bool,
              stack: "Creator-mutual"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "Creator-remarkName"),
          signature: convertValueByType(jsonRes['signature'], String,
              stack: "Creator-signature"),
          authority: convertValueByType(jsonRes['authority'], int,
              stack: "Creator-authority"),
        );
  Map<String, dynamic> toJson() => {
        'accountStatus': accountStatus,
        'userId': userId,
        'avatarUrl': avatarUrl,
        'authStatus': authStatus,
        'userType': userType,
        'nickname': nickname,
        'vipType': vipType,
        'province': province,
        'gender': gender,
        'birthday': birthday,
        'city': city,
        'avatarImgId': avatarImgId,
        'backgroundImgId': backgroundImgId,
        'avatarImgIdStr': avatarImgIdStr,
        'backgroundImgIdStr': backgroundImgIdStr,
        'detailDescription': detailDescription,
        'defaultAvatar': defaultAvatar,
        'expertTags': expertTags,
        'djStatus': djStatus,
        'followed': followed,
        'backgroundUrl': backgroundUrl,
        'description': description,
        'mutual': mutual,
        'remarkName': remarkName,
        'signature': signature,
        'authority': authority,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
