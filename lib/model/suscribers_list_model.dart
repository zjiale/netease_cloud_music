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

class SubscribersListModel {
  int code;
  bool more;
  List<Subscribers> subscribers;

  SubscribersListModel({
    this.code,
    this.more,
    this.subscribers,
  });

  factory SubscribersListModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Subscribers> subscribers = jsonRes['subscribers'] is List ? [] : null;
    if (subscribers != null) {
      for (var item in jsonRes['subscribers']) {
        if (item != null) {
          tryCatch(() {
            subscribers.add(Subscribers.fromJson(item));
          });
        }
      }
    }

    return SubscribersListModel(
      code: convertValueByType(jsonRes['code'], int,
          stack: "SubscribersListModel-code"),
      more: convertValueByType(jsonRes['more'], bool,
          stack: "SubscribersListModel-more"),
      subscribers: subscribers,
    );
  }
  Map<String, dynamic> toJson() => {
        'code': code,
        'more': more,
        'subscribers': subscribers,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Subscribers {
  bool defaultAvatar;
  int province;
  int authStatus;
  bool followed;
  String avatarUrl;
  int accountStatus;
  int gender;
  int city;
  int birthday;
  int userId;
  int userType;
  String nickname;
  String signature;
  String description;
  String detailDescription;
  int avatarImgId;
  int backgroundImgId;
  String backgroundUrl;
  int authority;
  bool mutual;
  Object expertTags;
  Object experts;
  int djStatus;
  int vipType;
  Object remarkName;
  String avatarImgIdStr;
  String backgroundImgIdStr;
  String avatarImgId_str;

  Subscribers({
    this.defaultAvatar,
    this.province,
    this.authStatus,
    this.followed,
    this.avatarUrl,
    this.accountStatus,
    this.gender,
    this.city,
    this.birthday,
    this.userId,
    this.userType,
    this.nickname,
    this.signature,
    this.description,
    this.detailDescription,
    this.avatarImgId,
    this.backgroundImgId,
    this.backgroundUrl,
    this.authority,
    this.mutual,
    this.expertTags,
    this.experts,
    this.djStatus,
    this.vipType,
    this.remarkName,
    this.avatarImgIdStr,
    this.backgroundImgIdStr,
    this.avatarImgId_str,
  });

  factory Subscribers.fromJson(jsonRes) => jsonRes == null
      ? null
      : Subscribers(
          defaultAvatar: convertValueByType(jsonRes['defaultAvatar'], bool,
              stack: "Subscribers-defaultAvatar"),
          province: convertValueByType(jsonRes['province'], int,
              stack: "Subscribers-province"),
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "Subscribers-authStatus"),
          followed: convertValueByType(jsonRes['followed'], bool,
              stack: "Subscribers-followed"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "Subscribers-avatarUrl"),
          accountStatus: convertValueByType(jsonRes['accountStatus'], int,
              stack: "Subscribers-accountStatus"),
          gender: convertValueByType(jsonRes['gender'], int,
              stack: "Subscribers-gender"),
          city: convertValueByType(jsonRes['city'], int,
              stack: "Subscribers-city"),
          birthday: convertValueByType(jsonRes['birthday'], int,
              stack: "Subscribers-birthday"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "Subscribers-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "Subscribers-userType"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "Subscribers-nickname"),
          signature: convertValueByType(jsonRes['signature'], String,
              stack: "Subscribers-signature"),
          description: convertValueByType(jsonRes['description'], String,
              stack: "Subscribers-description"),
          detailDescription: convertValueByType(
              jsonRes['detailDescription'], String,
              stack: "Subscribers-detailDescription"),
          avatarImgId: convertValueByType(jsonRes['avatarImgId'], int,
              stack: "Subscribers-avatarImgId"),
          backgroundImgId: convertValueByType(jsonRes['backgroundImgId'], int,
              stack: "Subscribers-backgroundImgId"),
          backgroundUrl: convertValueByType(jsonRes['backgroundUrl'], String,
              stack: "Subscribers-backgroundUrl"),
          authority: convertValueByType(jsonRes['authority'], int,
              stack: "Subscribers-authority"),
          mutual: convertValueByType(jsonRes['mutual'], bool,
              stack: "Subscribers-mutual"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "Subscribers-expertTags"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "Subscribers-experts"),
          djStatus: convertValueByType(jsonRes['djStatus'], int,
              stack: "Subscribers-djStatus"),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "Subscribers-vipType"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "Subscribers-remarkName"),
          avatarImgIdStr: convertValueByType(jsonRes['avatarImgIdStr'], String,
              stack: "Subscribers-avatarImgIdStr"),
          backgroundImgIdStr: convertValueByType(
              jsonRes['backgroundImgIdStr'], String,
              stack: "Subscribers-backgroundImgIdStr"),
          avatarImgId_str: convertValueByType(
              jsonRes['avatarImgId_str'], String,
              stack: "Subscribers-avatarImgId_str"),
        );
  Map<String, dynamic> toJson() => {
        'defaultAvatar': defaultAvatar,
        'province': province,
        'authStatus': authStatus,
        'followed': followed,
        'avatarUrl': avatarUrl,
        'accountStatus': accountStatus,
        'gender': gender,
        'city': city,
        'birthday': birthday,
        'userId': userId,
        'userType': userType,
        'nickname': nickname,
        'signature': signature,
        'description': description,
        'detailDescription': detailDescription,
        'avatarImgId': avatarImgId,
        'backgroundImgId': backgroundImgId,
        'backgroundUrl': backgroundUrl,
        'authority': authority,
        'mutual': mutual,
        'expertTags': expertTags,
        'experts': experts,
        'djStatus': djStatus,
        'vipType': vipType,
        'remarkName': remarkName,
        'avatarImgIdStr': avatarImgIdStr,
        'backgroundImgIdStr': backgroundImgIdStr,
        'avatarImgId_str': avatarImgId_str,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
