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

class FollowModel {
  int code;
  List<Follow> follow;
  bool more;
  int touchCount;

  FollowModel({
    this.code,
    this.follow,
    this.more,
    this.touchCount,
  });

  factory FollowModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Follow> follow = jsonRes['follow'] is List ? [] : null;
    if (follow != null) {
      for (var item in jsonRes['follow']) {
        if (item != null) {
          tryCatch(() {
            follow.add(Follow.fromJson(item));
          });
        }
      }
    }

    return FollowModel(
      code: convertValueByType(jsonRes['code'], int, stack: "FollowModel-code"),
      follow: follow,
      more:
          convertValueByType(jsonRes['more'], bool, stack: "FollowModel-more"),
      touchCount: convertValueByType(jsonRes['touchCount'], int,
          stack: "FollowModel-touchCount"),
    );
  }
  Map<String, dynamic> toJson() => {
        'code': code,
        'follow': follow,
        'more': more,
        'touchCount': touchCount,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Follow {
  int accountStatus;
  int authStatus;
  String avatarUrl;
  bool blacklist;
  int eventCount;
  Object experts;
  List<String> expertTags;
  bool followed;
  int followeds;
  int follows;
  int gender;
  bool mutual;
  String nickname;
  int playlistCount;
  String py;
  Object remarkName;
  String signature;
  int time;
  int userId;
  int userType;
  VipRights vipRights;
  int vipType;

  Follow({
    this.accountStatus,
    this.authStatus,
    this.avatarUrl,
    this.blacklist,
    this.eventCount,
    this.experts,
    this.expertTags,
    this.followed,
    this.followeds,
    this.follows,
    this.gender,
    this.mutual,
    this.nickname,
    this.playlistCount,
    this.py,
    this.remarkName,
    this.signature,
    this.time,
    this.userId,
    this.userType,
    this.vipRights,
    this.vipType,
  });

  factory Follow.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<String> expertTags = jsonRes['expertTags'] is List ? [] : null;
    if (expertTags != null) {
      for (var item in jsonRes['expertTags']) {
        if (item != null) {
          tryCatch(() {
            expertTags.add(item);
          });
        }
      }
    }

    return Follow(
      accountStatus: convertValueByType(jsonRes['accountStatus'], int,
          stack: "Follow-accountStatus"),
      authStatus: convertValueByType(jsonRes['authStatus'], int,
          stack: "Follow-authStatus"),
      avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
          stack: "Follow-avatarUrl"),
      blacklist: convertValueByType(jsonRes['blacklist'], bool,
          stack: "Follow-blacklist"),
      eventCount: convertValueByType(jsonRes['eventCount'], int,
          stack: "Follow-eventCount"),
      experts: convertValueByType(jsonRes['experts'], Object,
          stack: "Follow-experts"),
      expertTags: expertTags,
      followed: convertValueByType(jsonRes['followed'], bool,
          stack: "Follow-followed"),
      followeds: convertValueByType(jsonRes['followeds'], int,
          stack: "Follow-followeds"),
      follows:
          convertValueByType(jsonRes['follows'], int, stack: "Follow-follows"),
      gender:
          convertValueByType(jsonRes['gender'], int, stack: "Follow-gender"),
      mutual:
          convertValueByType(jsonRes['mutual'], bool, stack: "Follow-mutual"),
      nickname: convertValueByType(jsonRes['nickname'], String,
          stack: "Follow-nickname"),
      playlistCount: convertValueByType(jsonRes['playlistCount'], int,
          stack: "Follow-playlistCount"),
      py: convertValueByType(jsonRes['py'], String, stack: "Follow-py"),
      remarkName: convertValueByType(jsonRes['remarkName'], Object,
          stack: "Follow-remarkName"),
      signature: convertValueByType(jsonRes['signature'], String,
          stack: "Follow-signature"),
      time: convertValueByType(jsonRes['time'], int, stack: "Follow-time"),
      userId:
          convertValueByType(jsonRes['userId'], int, stack: "Follow-userId"),
      userType: convertValueByType(jsonRes['userType'], int,
          stack: "Follow-userType"),
      vipRights: VipRights.fromJson(jsonRes['vipRights']),
      vipType:
          convertValueByType(jsonRes['vipType'], int, stack: "Follow-vipType"),
    );
  }
  Map<String, dynamic> toJson() => {
        'accountStatus': accountStatus,
        'authStatus': authStatus,
        'avatarUrl': avatarUrl,
        'blacklist': blacklist,
        'eventCount': eventCount,
        'experts': experts,
        'expertTags': expertTags,
        'followed': followed,
        'followeds': followeds,
        'follows': follows,
        'gender': gender,
        'mutual': mutual,
        'nickname': nickname,
        'playlistCount': playlistCount,
        'py': py,
        'remarkName': remarkName,
        'signature': signature,
        'time': time,
        'userId': userId,
        'userType': userType,
        'vipRights': vipRights,
        'vipType': vipType,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class VipRights {
  Associator associator;
  Object musicPackage;
  int redVipAnnualCount;

  VipRights({
    this.associator,
    this.musicPackage,
    this.redVipAnnualCount,
  });

  factory VipRights.fromJson(jsonRes) => jsonRes == null
      ? null
      : VipRights(
          associator: Associator.fromJson(jsonRes['associator']),
          musicPackage: convertValueByType(jsonRes['musicPackage'], Object,
              stack: "VipRights-musicPackage"),
          redVipAnnualCount: convertValueByType(
              jsonRes['redVipAnnualCount'], int,
              stack: "VipRights-redVipAnnualCount"),
        );
  Map<String, dynamic> toJson() => {
        'associator': associator,
        'musicPackage': musicPackage,
        'redVipAnnualCount': redVipAnnualCount,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Associator {
  bool rights;
  int vipCode;

  Associator({
    this.rights,
    this.vipCode,
  });

  factory Associator.fromJson(jsonRes) => jsonRes == null
      ? null
      : Associator(
          rights: convertValueByType(jsonRes['rights'], bool,
              stack: "Associator-rights"),
          vipCode: convertValueByType(jsonRes['vipCode'], int,
              stack: "Associator-vipCode"),
        );
  Map<String, dynamic> toJson() => {
        'rights': rights,
        'vipCode': vipCode,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
