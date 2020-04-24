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

class SearchUserDetailModel {
  int code;
  Result result;

  SearchUserDetailModel({
    this.code,
    this.result,
  });

  factory SearchUserDetailModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : SearchUserDetailModel(
          code: convertValueByType(jsonRes['code'], int,
              stack: "SearchUserDetailModel-code"),
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
  int userprofileCount;
  List<Userprofiles> userprofiles;

  Result({
    this.userprofileCount,
    this.userprofiles,
  });

  factory Result.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Userprofiles> userprofiles =
        jsonRes['userprofiles'] is List ? [] : null;
    if (userprofiles != null) {
      for (var item in jsonRes['userprofiles']) {
        if (item != null) {
          tryCatch(() {
            userprofiles.add(Userprofiles.fromJson(item));
          });
        }
      }
    }

    return Result(
      userprofileCount: convertValueByType(jsonRes['userprofileCount'], int,
          stack: "Result-userprofileCount"),
      userprofiles: userprofiles,
    );
  }
  Map<String, dynamic> toJson() => {
        'userprofileCount': userprofileCount,
        'userprofiles': userprofiles,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Userprofiles {
  int accountStatus;
  String alg;
  bool anchor;
  int authenticationTypes;
  int authority;
  int authStatus;
  int avatarImgId;
  String avatarimgidStr;
  String avatarImgIdStr;
  String avatarUrl;
  int backgroundImgId;
  String backgroundImgIdStr;
  String backgroundUrl;
  int birthday;
  int city;
  bool defaultAvatar;
  String description;
  String detailDescription;
  int djStatus;
  Object experts;
  Object expertTags;
  bool followed;
  int gender;
  bool mutual;
  String nickname;
  int province;
  Object remarkName;
  String signature;
  int userId;
  int userType;
  int vipType;

  Userprofiles({
    this.accountStatus,
    this.alg,
    this.anchor,
    this.authenticationTypes,
    this.authority,
    this.authStatus,
    this.avatarImgId,
    this.avatarimgidStr,
    this.avatarImgIdStr,
    this.avatarUrl,
    this.backgroundImgId,
    this.backgroundImgIdStr,
    this.backgroundUrl,
    this.birthday,
    this.city,
    this.defaultAvatar,
    this.description,
    this.detailDescription,
    this.djStatus,
    this.experts,
    this.expertTags,
    this.followed,
    this.gender,
    this.mutual,
    this.nickname,
    this.province,
    this.remarkName,
    this.signature,
    this.userId,
    this.userType,
    this.vipType,
  });

  factory Userprofiles.fromJson(jsonRes) => jsonRes == null
      ? null
      : Userprofiles(
          accountStatus: convertValueByType(jsonRes['accountStatus'], int,
              stack: "Userprofiles-accountStatus"),
          alg: convertValueByType(jsonRes['alg'], String,
              stack: "Userprofiles-alg"),
          anchor: convertValueByType(jsonRes['anchor'], bool,
              stack: "Userprofiles-anchor"),
          authenticationTypes: convertValueByType(
              jsonRes['authenticationTypes'], int,
              stack: "Userprofiles-authenticationTypes"),
          authority: convertValueByType(jsonRes['authority'], int,
              stack: "Userprofiles-authority"),
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "Userprofiles-authStatus"),
          avatarImgId: convertValueByType(jsonRes['avatarImgId'], int,
              stack: "Userprofiles-avatarImgId"),
          avatarimgidStr: convertValueByType(jsonRes['avatarImgId_str'], String,
              stack: "Userprofiles-avatarImgId_str"),
          avatarImgIdStr: convertValueByType(jsonRes['avatarImgIdStr'], String,
              stack: "Userprofiles-avatarImgIdStr"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "Userprofiles-avatarUrl"),
          backgroundImgId: convertValueByType(jsonRes['backgroundImgId'], int,
              stack: "Userprofiles-backgroundImgId"),
          backgroundImgIdStr: convertValueByType(
              jsonRes['backgroundImgIdStr'], String,
              stack: "Userprofiles-backgroundImgIdStr"),
          backgroundUrl: convertValueByType(jsonRes['backgroundUrl'], String,
              stack: "Userprofiles-backgroundUrl"),
          birthday: convertValueByType(jsonRes['birthday'], int,
              stack: "Userprofiles-birthday"),
          city: convertValueByType(jsonRes['city'], int,
              stack: "Userprofiles-city"),
          defaultAvatar: convertValueByType(jsonRes['defaultAvatar'], bool,
              stack: "Userprofiles-defaultAvatar"),
          description: convertValueByType(jsonRes['description'], String,
              stack: "Userprofiles-description"),
          detailDescription: convertValueByType(
              jsonRes['detailDescription'], String,
              stack: "Userprofiles-detailDescription"),
          djStatus: convertValueByType(jsonRes['djStatus'], int,
              stack: "Userprofiles-djStatus"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "Userprofiles-experts"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "Userprofiles-expertTags"),
          followed: convertValueByType(jsonRes['followed'], bool,
              stack: "Userprofiles-followed"),
          gender: convertValueByType(jsonRes['gender'], int,
              stack: "Userprofiles-gender"),
          mutual: convertValueByType(jsonRes['mutual'], bool,
              stack: "Userprofiles-mutual"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "Userprofiles-nickname"),
          province: convertValueByType(jsonRes['province'], int,
              stack: "Userprofiles-province"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "Userprofiles-remarkName"),
          signature: convertValueByType(jsonRes['signature'], String,
              stack: "Userprofiles-signature"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "Userprofiles-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "Userprofiles-userType"),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "Userprofiles-vipType"),
        );
  Map<String, dynamic> toJson() => {
        'accountStatus': accountStatus,
        'alg': alg,
        'anchor': anchor,
        'authenticationTypes': authenticationTypes,
        'authority': authority,
        'authStatus': authStatus,
        'avatarImgId': avatarImgId,
        'avatarImgId_str': avatarimgidStr,
        'avatarImgIdStr': avatarImgIdStr,
        'avatarUrl': avatarUrl,
        'backgroundImgId': backgroundImgId,
        'backgroundImgIdStr': backgroundImgIdStr,
        'backgroundUrl': backgroundUrl,
        'birthday': birthday,
        'city': city,
        'defaultAvatar': defaultAvatar,
        'description': description,
        'detailDescription': detailDescription,
        'djStatus': djStatus,
        'experts': experts,
        'expertTags': expertTags,
        'followed': followed,
        'gender': gender,
        'mutual': mutual,
        'nickname': nickname,
        'province': province,
        'remarkName': remarkName,
        'signature': signature,
        'userId': userId,
        'userType': userType,
        'vipType': vipType,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
