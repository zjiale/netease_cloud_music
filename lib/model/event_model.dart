import 'dart:convert' show json;
import 'dart:convert' as formate;
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

class EventModel {
  int code;
  List<Events> event;
  int lasttime;
  bool more;

  EventModel({
    this.code,
    this.event,
    this.lasttime,
    this.more,
  });

  factory EventModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Events> event = jsonRes['event'] is List ? [] : null;
    if (event != null) {
      for (var item in jsonRes['event']) {
        if (item != null) {
          tryCatch(() {
            event.add(Events.fromJson(item));
          });
        }
      }
    }

    return EventModel(
      code: convertValueByType(jsonRes['code'], int, stack: "EventModel-code"),
      event: event,
      lasttime: convertValueByType(jsonRes['lasttime'], int,
          stack: "EventModel-lasttime"),
      more: convertValueByType(jsonRes['more'], bool, stack: "EventModel-more"),
    );
  }
  Map<String, dynamic> toJson() => {
        'code': code,
        'event': event,
        'lasttime': lasttime,
        'more': more,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Events {
  int actId;
  String actName;
  int eventTime;
  int expireTime;
  ExtJsonInfo extJsonInfo;
  int forwardCount;
  int id;
  Info info;
  int insiteForwardCount;
  String json;
  Object lotteryEventData;
  PendantData pendantData;
  List<Pics> pics;
  Object rcmdInfo;
  int showTime;
  Object tailMark;
  int tmplId;
  bool topEvent;
  int type;
  User user;
  String uuid;

  Events({
    this.actId,
    this.actName,
    this.eventTime,
    this.expireTime,
    this.extJsonInfo,
    this.forwardCount,
    this.id,
    this.info,
    this.insiteForwardCount,
    this.json,
    this.lotteryEventData,
    this.pendantData,
    this.pics,
    this.rcmdInfo,
    this.showTime,
    this.tailMark,
    this.tmplId,
    this.topEvent,
    this.type,
    this.user,
    this.uuid,
  });

  factory Events.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Pics> pics = jsonRes['pics'] is List ? [] : null;
    if (pics != null) {
      for (var item in jsonRes['pics']) {
        if (item != null) {
          tryCatch(() {
            pics.add(Pics.fromJson(item));
          });
        }
      }
    }

    return Events(
      actId: convertValueByType(jsonRes['actId'], int, stack: "Events-actId"),
      actName: convertValueByType(jsonRes['actName'], String,
          stack: "Events-actName"),
      eventTime: convertValueByType(jsonRes['eventTime'], int,
          stack: "Events-eventTime"),
      expireTime: convertValueByType(jsonRes['expireTime'], int,
          stack: "Events-expireTime"),
      extJsonInfo: ExtJsonInfo.fromJson(jsonRes['extJsonInfo']),
      forwardCount: convertValueByType(jsonRes['forwardCount'], int,
          stack: "Events-forwardCount"),
      id: convertValueByType(jsonRes['id'], int, stack: "Events-id"),
      info: Info.fromJson(jsonRes['info']),
      insiteForwardCount: convertValueByType(jsonRes['insiteForwardCount'], int,
          stack: "Events-insiteForwardCount"),
      json: convertValueByType(jsonRes['json'], String, stack: "Events-json"),
      lotteryEventData: convertValueByType(jsonRes['lotteryEventData'], Object,
          stack: "Events-lotteryEventData"),
      pendantData: PendantData.fromJson(jsonRes['pendantData']),
      pics: pics,
      rcmdInfo: convertValueByType(jsonRes['rcmdInfo'], Object,
          stack: "Events-rcmdInfo"),
      showTime: convertValueByType(jsonRes['showTime'], int,
          stack: "Events-showTime"),
      tailMark: convertValueByType(jsonRes['tailMark'], Object,
          stack: "Events-tailMark"),
      tmplId:
          convertValueByType(jsonRes['tmplId'], int, stack: "Events-tmplId"),
      topEvent: convertValueByType(jsonRes['topEvent'], bool,
          stack: "Events-topEvent"),
      type: convertValueByType(jsonRes['type'], int, stack: "Events-type"),
      user: User.fromJson(jsonRes['user']),
      uuid: convertValueByType(jsonRes['uuid'], String, stack: "Events-uuid"),
    );
  }
  Map<String, dynamic> toJson() => {
        'actId': actId,
        'actName': actName,
        'eventTime': eventTime,
        'expireTime': expireTime,
        'extJsonInfo': extJsonInfo,
        'forwardCount': forwardCount,
        'id': id,
        'info': info,
        'insiteForwardCount': insiteForwardCount,
        'json': json,
        'lotteryEventData': lotteryEventData,
        'pendantData': pendantData,
        'pics': pics,
        'rcmdInfo': rcmdInfo,
        'showTime': showTime,
        'tailMark': tailMark,
        'tmplId': tmplId,
        'topEvent': topEvent,
        'type': type,
        'user': user,
        'uuid': uuid,
      };

  @override
  String toString() {
    return formate.json.encode(this);
  }
}

class PendantData {
  int id;
  String imageAndroidUrl;
  String imageIosUrl;
  String imageUrl;

  PendantData({
    this.id,
    this.imageAndroidUrl,
    this.imageIosUrl,
    this.imageUrl,
  });

  factory PendantData.fromJson(jsonRes) => jsonRes == null
      ? null
      : PendantData(
          id: convertValueByType(jsonRes['id'], int, stack: "PendantData-id"),
          imageAndroidUrl: convertValueByType(
              jsonRes['imageAndroidUrl'], String,
              stack: "PendantData-imageAndroidUrl"),
          imageIosUrl: convertValueByType(jsonRes['imageIosUrl'], String,
              stack: "PendantData-imageIosUrl"),
          imageUrl: convertValueByType(jsonRes['imageUrl'], String,
              stack: "PendantData-imageUrl"),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'imageAndroidUrl': imageAndroidUrl,
        'imageIosUrl': imageIosUrl,
        'imageUrl': imageUrl,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class User {
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
  Object experts;
  Object expertTags;
  bool followed;
  int followeds;
  int gender;
  bool mutual;
  String nickname;
  int province;
  Object remarkName;
  String signature;
  bool urlAnalyze;
  int userId;
  int userType;
  VipRights vipRights;
  int vipType;

  User({
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
    this.experts,
    this.expertTags,
    this.followed,
    this.followeds,
    this.gender,
    this.mutual,
    this.nickname,
    this.province,
    this.remarkName,
    this.signature,
    this.urlAnalyze,
    this.userId,
    this.userType,
    this.vipRights,
    this.vipType,
  });

  factory User.fromJson(jsonRes) => jsonRes == null
      ? null
      : User(
          accountStatus: convertValueByType(jsonRes['accountStatus'], int,
              stack: "User-accountStatus"),
          authority: convertValueByType(jsonRes['authority'], int,
              stack: "User-authority"),
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "User-authStatus"),
          avatarImgId: convertValueByType(jsonRes['avatarImgId'], int,
              stack: "User-avatarImgId"),
          avatarimgidStr: convertValueByType(jsonRes['avatarImgId_str'], String,
              stack: "User-avatarImgId_str"),
          avatarImgIdStr: convertValueByType(jsonRes['avatarImgIdStr'], String,
              stack: "User-avatarImgIdStr"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "User-avatarUrl"),
          backgroundImgId: convertValueByType(jsonRes['backgroundImgId'], int,
              stack: "User-backgroundImgId"),
          backgroundImgIdStr: convertValueByType(
              jsonRes['backgroundImgIdStr'], String,
              stack: "User-backgroundImgIdStr"),
          backgroundUrl: convertValueByType(jsonRes['backgroundUrl'], String,
              stack: "User-backgroundUrl"),
          birthday: convertValueByType(jsonRes['birthday'], int,
              stack: "User-birthday"),
          city: convertValueByType(jsonRes['city'], int, stack: "User-city"),
          defaultAvatar: convertValueByType(jsonRes['defaultAvatar'], bool,
              stack: "User-defaultAvatar"),
          description: convertValueByType(jsonRes['description'], String,
              stack: "User-description"),
          detailDescription: convertValueByType(
              jsonRes['detailDescription'], String,
              stack: "User-detailDescription"),
          djStatus: convertValueByType(jsonRes['djStatus'], int,
              stack: "User-djStatus"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "User-experts"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "User-expertTags"),
          followed: convertValueByType(jsonRes['followed'], bool,
              stack: "User-followed"),
          followeds: convertValueByType(jsonRes['followeds'], int,
              stack: "User-followeds"),
          gender:
              convertValueByType(jsonRes['gender'], int, stack: "User-gender"),
          mutual:
              convertValueByType(jsonRes['mutual'], bool, stack: "User-mutual"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "User-nickname"),
          province: convertValueByType(jsonRes['province'], int,
              stack: "User-province"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "User-remarkName"),
          signature: convertValueByType(jsonRes['signature'], String,
              stack: "User-signature"),
          urlAnalyze: convertValueByType(jsonRes['urlAnalyze'], bool,
              stack: "User-urlAnalyze"),
          userId:
              convertValueByType(jsonRes['userId'], int, stack: "User-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "User-userType"),
          vipRights: VipRights.fromJson(jsonRes['vipRights']),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "User-vipType"),
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
        'experts': experts,
        'expertTags': expertTags,
        'followed': followed,
        'followeds': followeds,
        'gender': gender,
        'mutual': mutual,
        'nickname': nickname,
        'province': province,
        'remarkName': remarkName,
        'signature': signature,
        'urlAnalyze': urlAnalyze,
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

class Pics {
  String format;
  int height;
  String originUrl;
  String pcRectangleUrl;
  String pcSquareUrl;
  String rectangleUrl;
  String squareUrl;
  int width;

  Pics({
    this.format,
    this.height,
    this.originUrl,
    this.pcRectangleUrl,
    this.pcSquareUrl,
    this.rectangleUrl,
    this.squareUrl,
    this.width,
  });

  factory Pics.fromJson(jsonRes) => jsonRes == null
      ? null
      : Pics(
          format: convertValueByType(jsonRes['format'], String,
              stack: "Pics-format"),
          height:
              convertValueByType(jsonRes['height'], int, stack: "Pics-height"),
          originUrl: convertValueByType(jsonRes['originUrl'], String,
              stack: "Pics-originUrl"),
          pcRectangleUrl: convertValueByType(jsonRes['pcRectangleUrl'], String,
              stack: "Pics-pcRectangleUrl"),
          pcSquareUrl: convertValueByType(jsonRes['pcSquareUrl'], String,
              stack: "Pics-pcSquareUrl"),
          rectangleUrl: convertValueByType(jsonRes['rectangleUrl'], String,
              stack: "Pics-rectangleUrl"),
          squareUrl: convertValueByType(jsonRes['squareUrl'], String,
              stack: "Pics-squareUrl"),
          width: convertValueByType(jsonRes['width'], int, stack: "Pics-width"),
        );
  Map<String, dynamic> toJson() => {
        'format': format,
        'height': height,
        'originUrl': originUrl,
        'pcRectangleUrl': pcRectangleUrl,
        'pcSquareUrl': pcSquareUrl,
        'rectangleUrl': rectangleUrl,
        'squareUrl': squareUrl,
        'width': width,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ExtJsonInfo {
  int actId;
  List<int> actIds;
  Object circleId;
  Object circlePubType;
  String extId;
  Object extParams;
  String extType;
  String uuid;

  ExtJsonInfo({
    this.actId,
    this.actIds,
    this.circleId,
    this.circlePubType,
    this.extId,
    this.extParams,
    this.extType,
    this.uuid,
  });

  factory ExtJsonInfo.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<int> actIds = jsonRes['actIds'] is List ? [] : null;
    if (actIds != null) {
      for (var item in jsonRes['actIds']) {
        if (item != null) {
          tryCatch(() {
            actIds.add(item);
          });
        }
      }
    }

    return ExtJsonInfo(
      actId:
          convertValueByType(jsonRes['actId'], int, stack: "ExtJsonInfo-actId"),
      actIds: actIds,
      circleId: convertValueByType(jsonRes['circleId'], Object,
          stack: "ExtJsonInfo-circleId"),
      circlePubType: convertValueByType(jsonRes['circlePubType'], Object,
          stack: "ExtJsonInfo-circlePubType"),
      extId: convertValueByType(jsonRes['extId'], String,
          stack: "ExtJsonInfo-extId"),
      extParams: convertValueByType(jsonRes['extParams'], Object,
          stack: "ExtJsonInfo-extParams"),
      extType: convertValueByType(jsonRes['extType'], String,
          stack: "ExtJsonInfo-extType"),
      uuid: convertValueByType(jsonRes['uuid'], String,
          stack: "ExtJsonInfo-uuid"),
    );
  }
  Map<String, dynamic> toJson() => {
        'actId': actId,
        'actIds': actIds,
        'circleId': circleId,
        'circlePubType': circlePubType,
        'extId': extId,
        'extParams': extParams,
        'extType': extType,
        'uuid': uuid,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Info {
  int commentCount;
  Object comments;
  CommentThread commentThread;
  Object latestLikedUsers;
  bool liked;
  int likedCount;
  int resourceId;
  int resourceType;
  int shareCount;
  String threadId;

  Info({
    this.commentCount,
    this.comments,
    this.commentThread,
    this.latestLikedUsers,
    this.liked,
    this.likedCount,
    this.resourceId,
    this.resourceType,
    this.shareCount,
    this.threadId,
  });

  factory Info.fromJson(jsonRes) => jsonRes == null
      ? null
      : Info(
          commentCount: convertValueByType(jsonRes['commentCount'], int,
              stack: "Info-commentCount"),
          comments: convertValueByType(jsonRes['comments'], Object,
              stack: "Info-comments"),
          commentThread: CommentThread.fromJson(jsonRes['commentThread']),
          latestLikedUsers: convertValueByType(
              jsonRes['latestLikedUsers'], Object,
              stack: "Info-latestLikedUsers"),
          liked:
              convertValueByType(jsonRes['liked'], bool, stack: "Info-liked"),
          likedCount: convertValueByType(jsonRes['likedCount'], int,
              stack: "Info-likedCount"),
          resourceId: convertValueByType(jsonRes['resourceId'], int,
              stack: "Info-resourceId"),
          resourceType: convertValueByType(jsonRes['resourceType'], int,
              stack: "Info-resourceType"),
          shareCount: convertValueByType(jsonRes['shareCount'], int,
              stack: "Info-shareCount"),
          threadId: convertValueByType(jsonRes['threadId'], String,
              stack: "Info-threadId"),
        );
  Map<String, dynamic> toJson() => {
        'commentCount': commentCount,
        'comments': comments,
        'commentThread': commentThread,
        'latestLikedUsers': latestLikedUsers,
        'liked': liked,
        'likedCount': likedCount,
        'resourceId': resourceId,
        'resourceType': resourceType,
        'shareCount': shareCount,
        'threadId': threadId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class CommentThread {
  int commentCount;
  int hotCount;
  String id;
  List<LatestLikedUsers> latestLikedUsers;
  int likedCount;
  int resourceId;
  ResourceInfo resourceInfo;
  int resourceOwnerId;
  String resourceTitle;
  int resourceType;
  int shareCount;

  CommentThread({
    this.commentCount,
    this.hotCount,
    this.id,
    this.latestLikedUsers,
    this.likedCount,
    this.resourceId,
    this.resourceInfo,
    this.resourceOwnerId,
    this.resourceTitle,
    this.resourceType,
    this.shareCount,
  });

  factory CommentThread.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<LatestLikedUsers> latestLikedUsers =
        jsonRes['latestLikedUsers'] is List ? [] : null;
    if (latestLikedUsers != null) {
      for (var item in jsonRes['latestLikedUsers']) {
        if (item != null) {
          tryCatch(() {
            latestLikedUsers.add(LatestLikedUsers.fromJson(item));
          });
        }
      }
    }

    return CommentThread(
      commentCount: convertValueByType(jsonRes['commentCount'], int,
          stack: "CommentThread-commentCount"),
      hotCount: convertValueByType(jsonRes['hotCount'], int,
          stack: "CommentThread-hotCount"),
      id: convertValueByType(jsonRes['id'], String, stack: "CommentThread-id"),
      latestLikedUsers: latestLikedUsers,
      likedCount: convertValueByType(jsonRes['likedCount'], int,
          stack: "CommentThread-likedCount"),
      resourceId: convertValueByType(jsonRes['resourceId'], int,
          stack: "CommentThread-resourceId"),
      resourceInfo: ResourceInfo.fromJson(jsonRes['resourceInfo']),
      resourceOwnerId: convertValueByType(jsonRes['resourceOwnerId'], int,
          stack: "CommentThread-resourceOwnerId"),
      resourceTitle: convertValueByType(jsonRes['resourceTitle'], String,
          stack: "CommentThread-resourceTitle"),
      resourceType: convertValueByType(jsonRes['resourceType'], int,
          stack: "CommentThread-resourceType"),
      shareCount: convertValueByType(jsonRes['shareCount'], int,
          stack: "CommentThread-shareCount"),
    );
  }
  Map<String, dynamic> toJson() => {
        'commentCount': commentCount,
        'hotCount': hotCount,
        'id': id,
        'latestLikedUsers': latestLikedUsers,
        'likedCount': likedCount,
        'resourceId': resourceId,
        'resourceInfo': resourceInfo,
        'resourceOwnerId': resourceOwnerId,
        'resourceTitle': resourceTitle,
        'resourceType': resourceType,
        'shareCount': shareCount,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ResourceInfo {
  Object creator;
  int eventType;
  int id;
  Object imgUrl;
  String name;
  int userId;

  ResourceInfo({
    this.creator,
    this.eventType,
    this.id,
    this.imgUrl,
    this.name,
    this.userId,
  });

  factory ResourceInfo.fromJson(jsonRes) => jsonRes == null
      ? null
      : ResourceInfo(
          creator: convertValueByType(jsonRes['creator'], Object,
              stack: "ResourceInfo-creator"),
          eventType: convertValueByType(jsonRes['eventType'], int,
              stack: "ResourceInfo-eventType"),
          id: convertValueByType(jsonRes['id'], int, stack: "ResourceInfo-id"),
          imgUrl: convertValueByType(jsonRes['imgUrl'], Object,
              stack: "ResourceInfo-imgUrl"),
          name: convertValueByType(jsonRes['name'], String,
              stack: "ResourceInfo-name"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "ResourceInfo-userId"),
        );
  Map<String, dynamic> toJson() => {
        'creator': creator,
        'eventType': eventType,
        'id': id,
        'imgUrl': imgUrl,
        'name': name,
        'userId': userId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class LatestLikedUsers {
  int s;
  int t;

  LatestLikedUsers({
    this.s,
    this.t,
  });

  factory LatestLikedUsers.fromJson(jsonRes) => jsonRes == null
      ? null
      : LatestLikedUsers(
          s: convertValueByType(jsonRes['s'], int, stack: "LatestLikedUsers-s"),
          t: convertValueByType(jsonRes['t'], int, stack: "LatestLikedUsers-t"),
        );
  Map<String, dynamic> toJson() => {
        's': s,
        't': t,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
