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

class User {
  Account account;
  List<Bindings> bindings;
  int code;
  int loginType;
  String message;
  String msg;
  Profile profile;
  String token;

  User({
    this.account,
    this.bindings,
    this.code,
    this.loginType,
    this.message,
    this.msg,
    this.profile,
    this.token,
  });

  factory User.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Bindings> bindings = jsonRes['bindings'] is List ? [] : null;
    if (bindings != null) {
      for (var item in jsonRes['bindings']) {
        if (item != null) {
          tryCatch(() {
            bindings.add(Bindings.fromJson(item));
          });
        }
      }
    }

    return User(
      account: Account.fromJson(jsonRes['account']),
      bindings: bindings,
      code: convertValueByType(jsonRes['code'], int, stack: "User-code"),
      loginType: convertValueByType(jsonRes['loginType'], int,
          stack: "User-loginType"),
      message:
          convertValueByType(jsonRes['message'], String, stack: "User-message"),
      msg: convertValueByType(jsonRes['msg'], String, stack: "User-msg"),
      profile: Profile.fromJson(jsonRes['profile']),
      token: convertValueByType(jsonRes['token'], String, stack: "User-token"),
    );
  }
  Map<String, dynamic> toJson() => {
        'account': account,
        'bindings': bindings,
        'code': code,
        'loginType': loginType,
        'message': message,
        'msg': msg,
        'profile': profile,
        'token': token,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Account {
  bool anonimousUser;
  int ban;
  int baoyueVersion;
  int createTime;
  int donateVersion;
  int id;
  String salt;
  int status;
  int tokenVersion;
  int type;
  String userName;
  int vipType;
  int viptypeVersion;
  int whitelistAuthority;

  Account({
    this.anonimousUser,
    this.ban,
    this.baoyueVersion,
    this.createTime,
    this.donateVersion,
    this.id,
    this.salt,
    this.status,
    this.tokenVersion,
    this.type,
    this.userName,
    this.vipType,
    this.viptypeVersion,
    this.whitelistAuthority,
  });

  factory Account.fromJson(jsonRes) => jsonRes == null
      ? null
      : Account(
          anonimousUser: convertValueByType(jsonRes['anonimousUser'], bool,
              stack: "Account-anonimousUser"),
          ban: convertValueByType(jsonRes['ban'], int, stack: "Account-ban"),
          baoyueVersion: convertValueByType(jsonRes['baoyueVersion'], int,
              stack: "Account-baoyueVersion"),
          createTime: convertValueByType(jsonRes['createTime'], int,
              stack: "Account-createTime"),
          donateVersion: convertValueByType(jsonRes['donateVersion'], int,
              stack: "Account-donateVersion"),
          id: convertValueByType(jsonRes['id'], int, stack: "Account-id"),
          salt: convertValueByType(jsonRes['salt'], String,
              stack: "Account-salt"),
          status: convertValueByType(jsonRes['status'], int,
              stack: "Account-status"),
          tokenVersion: convertValueByType(jsonRes['tokenVersion'], int,
              stack: "Account-tokenVersion"),
          type: convertValueByType(jsonRes['type'], int, stack: "Account-type"),
          userName: convertValueByType(jsonRes['userName'], String,
              stack: "Account-userName"),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "Account-vipType"),
          viptypeVersion: convertValueByType(jsonRes['viptypeVersion'], int,
              stack: "Account-viptypeVersion"),
          whitelistAuthority: convertValueByType(
              jsonRes['whitelistAuthority'], int,
              stack: "Account-whitelistAuthority"),
        );
  Map<String, dynamic> toJson() => {
        'anonimousUser': anonimousUser,
        'ban': ban,
        'baoyueVersion': baoyueVersion,
        'createTime': createTime,
        'donateVersion': donateVersion,
        'id': id,
        'salt': salt,
        'status': status,
        'tokenVersion': tokenVersion,
        'type': type,
        'userName': userName,
        'vipType': vipType,
        'viptypeVersion': viptypeVersion,
        'whitelistAuthority': whitelistAuthority,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Profile {
  int accountStatus;
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
  int eventCount;
  Object experts;
  Object expertTags;
  bool followed;
  int followeds;
  int follows;
  int gender;
  bool mutual;
  String nickname;
  int playlistBeSubscribedCount;
  int playlistCount;
  int province;
  Object remarkName;
  String signature;
  int userId;
  int userType;
  int vipType;

  Profile({
    this.accountStatus,
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
    this.eventCount,
    this.experts,
    this.expertTags,
    this.followed,
    this.followeds,
    this.follows,
    this.gender,
    this.mutual,
    this.nickname,
    this.playlistBeSubscribedCount,
    this.playlistCount,
    this.province,
    this.remarkName,
    this.signature,
    this.userId,
    this.userType,
    this.vipType,
  });

  factory Profile.fromJson(jsonRes) => jsonRes == null
      ? null
      : Profile(
          accountStatus: convertValueByType(jsonRes['accountStatus'], int,
              stack: "Profile-accountStatus"),
          authority: convertValueByType(jsonRes['authority'], int,
              stack: "Profile-authority"),
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "Profile-authStatus"),
          avatarImgId: convertValueByType(jsonRes['avatarImgId'], int,
              stack: "Profile-avatarImgId"),
          avatarimgidStr: convertValueByType(jsonRes['avatarImgId_str'], String,
              stack: "Profile-avatarImgId_str"),
          avatarImgIdStr: convertValueByType(jsonRes['avatarImgIdStr'], String,
              stack: "Profile-avatarImgIdStr"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "Profile-avatarUrl"),
          backgroundImgId: convertValueByType(jsonRes['backgroundImgId'], int,
              stack: "Profile-backgroundImgId"),
          backgroundImgIdStr: convertValueByType(
              jsonRes['backgroundImgIdStr'], String,
              stack: "Profile-backgroundImgIdStr"),
          backgroundUrl: convertValueByType(jsonRes['backgroundUrl'], String,
              stack: "Profile-backgroundUrl"),
          birthday: convertValueByType(jsonRes['birthday'], int,
              stack: "Profile-birthday"),
          city: convertValueByType(jsonRes['city'], int, stack: "Profile-city"),
          defaultAvatar: convertValueByType(jsonRes['defaultAvatar'], bool,
              stack: "Profile-defaultAvatar"),
          description: convertValueByType(jsonRes['description'], String,
              stack: "Profile-description"),
          detailDescription: convertValueByType(
              jsonRes['detailDescription'], String,
              stack: "Profile-detailDescription"),
          djStatus: convertValueByType(jsonRes['djStatus'], int,
              stack: "Profile-djStatus"),
          eventCount: convertValueByType(jsonRes['eventCount'], int,
              stack: "Profile-eventCount"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "Profile-experts"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "Profile-expertTags"),
          followed: convertValueByType(jsonRes['followed'], bool,
              stack: "Profile-followed"),
          followeds: convertValueByType(jsonRes['followeds'], int,
              stack: "Profile-followeds"),
          follows: convertValueByType(jsonRes['follows'], int,
              stack: "Profile-follows"),
          gender: convertValueByType(jsonRes['gender'], int,
              stack: "Profile-gender"),
          mutual: convertValueByType(jsonRes['mutual'], bool,
              stack: "Profile-mutual"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "Profile-nickname"),
          playlistBeSubscribedCount: convertValueByType(
              jsonRes['playlistBeSubscribedCount'], int,
              stack: "Profile-playlistBeSubscribedCount"),
          playlistCount: convertValueByType(jsonRes['playlistCount'], int,
              stack: "Profile-playlistCount"),
          province: convertValueByType(jsonRes['province'], int,
              stack: "Profile-province"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "Profile-remarkName"),
          signature: convertValueByType(jsonRes['signature'], String,
              stack: "Profile-signature"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "Profile-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "Profile-userType"),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "Profile-vipType"),
        );
  Map<String, dynamic> toJson() => {
        'accountStatus': accountStatus,
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
        'eventCount': eventCount,
        'experts': experts,
        'expertTags': expertTags,
        'followed': followed,
        'followeds': followeds,
        'follows': follows,
        'gender': gender,
        'mutual': mutual,
        'nickname': nickname,
        'playlistBeSubscribedCount': playlistBeSubscribedCount,
        'playlistCount': playlistCount,
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

class Bindings {
  int bindingTime;
  bool expired;
  int expiresIn;
  int id;
  int refreshTime;
  String tokenJsonStr;
  int type;
  String url;
  int userId;

  Bindings({
    this.bindingTime,
    this.expired,
    this.expiresIn,
    this.id,
    this.refreshTime,
    this.tokenJsonStr,
    this.type,
    this.url,
    this.userId,
  });

  factory Bindings.fromJson(jsonRes) => jsonRes == null
      ? null
      : Bindings(
          bindingTime: convertValueByType(jsonRes['bindingTime'], int,
              stack: "Bindings-bindingTime"),
          expired: convertValueByType(jsonRes['expired'], bool,
              stack: "Bindings-expired"),
          expiresIn: convertValueByType(jsonRes['expiresIn'], int,
              stack: "Bindings-expiresIn"),
          id: convertValueByType(jsonRes['id'], int, stack: "Bindings-id"),
          refreshTime: convertValueByType(jsonRes['refreshTime'], int,
              stack: "Bindings-refreshTime"),
          tokenJsonStr: convertValueByType(jsonRes['tokenJsonStr'], String,
              stack: "Bindings-tokenJsonStr"),
          type:
              convertValueByType(jsonRes['type'], int, stack: "Bindings-type"),
          url:
              convertValueByType(jsonRes['url'], String, stack: "Bindings-url"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "Bindings-userId"),
        );
  Map<String, dynamic> toJson() => {
        'bindingTime': bindingTime,
        'expired': expired,
        'expiresIn': expiresIn,
        'id': id,
        'refreshTime': refreshTime,
        'tokenJsonStr': tokenJsonStr,
        'type': type,
        'url': url,
        'userId': userId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
