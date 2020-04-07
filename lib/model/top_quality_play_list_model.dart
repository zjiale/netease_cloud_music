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

class TopQualityPlayListModel {
  List<Playlists> playlists;
  int code;
  bool more;
  int lasttime;
  int total;

  TopQualityPlayListModel({
    this.playlists,
    this.code,
    this.more,
    this.lasttime,
    this.total,
  });

  factory TopQualityPlayListModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Playlists> playlists = jsonRes['playlists'] is List ? [] : null;
    if (playlists != null) {
      for (var item in jsonRes['playlists']) {
        if (item != null) {
          tryCatch(() {
            playlists.add(Playlists.fromJson(item));
          });
        }
      }
    }

    return TopQualityPlayListModel(
      playlists: playlists,
      code: convertValueByType(jsonRes['code'], int,
          stack: "TopQualityPlayListModel-code"),
      more: convertValueByType(jsonRes['more'], bool,
          stack: "TopQualityPlayListModel-more"),
      lasttime: convertValueByType(jsonRes['lasttime'], int,
          stack: "TopQualityPlayListModel-lasttime"),
      total: convertValueByType(jsonRes['total'], int,
          stack: "TopQualityPlayListModel-total"),
    );
  }
  Map<String, dynamic> toJson() => {
        'playlists': playlists,
        'code': code,
        'more': more,
        'lasttime': lasttime,
        'total': total,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Playlists {
  String name;
  int id;
  int trackNumberUpdateTime;
  int status;
  int userId;
  int createTime;
  int updateTime;
  int subscribedCount;
  int trackCount;
  int cloudTrackCount;
  String coverImgUrl;
  int coverImgId;
  String description;
  List<String> tags;
  int playCount;
  int trackUpdateTime;
  int specialType;
  int totalDuration;
  Creator creator;
  Object tracks;
  List<Subscribers> subscribers;
  bool subscribed;
  String commentThreadId;
  bool newImported;
  int adType;
  bool highQuality;
  int privacy;
  bool ordered;
  bool anonimous;
  int coverStatus;
  Object recommendInfo;
  int shareCount;
  int commentCount;
  String copywriter;
  String tag;

  Playlists({
    this.name,
    this.id,
    this.trackNumberUpdateTime,
    this.status,
    this.userId,
    this.createTime,
    this.updateTime,
    this.subscribedCount,
    this.trackCount,
    this.cloudTrackCount,
    this.coverImgUrl,
    this.coverImgId,
    this.description,
    this.tags,
    this.playCount,
    this.trackUpdateTime,
    this.specialType,
    this.totalDuration,
    this.creator,
    this.tracks,
    this.subscribers,
    this.subscribed,
    this.commentThreadId,
    this.newImported,
    this.adType,
    this.highQuality,
    this.privacy,
    this.ordered,
    this.anonimous,
    this.coverStatus,
    this.recommendInfo,
    this.shareCount,
    this.commentCount,
    this.copywriter,
    this.tag,
  });

  factory Playlists.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<String> tags = jsonRes['tags'] is List ? [] : null;
    if (tags != null) {
      for (var item in jsonRes['tags']) {
        if (item != null) {
          tryCatch(() {
            tags.add(item);
          });
        }
      }
    }

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

    return Playlists(
      name:
          convertValueByType(jsonRes['name'], String, stack: "Playlists-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Playlists-id"),
      trackNumberUpdateTime: convertValueByType(
          jsonRes['trackNumberUpdateTime'], int,
          stack: "Playlists-trackNumberUpdateTime"),
      status:
          convertValueByType(jsonRes['status'], int, stack: "Playlists-status"),
      userId:
          convertValueByType(jsonRes['userId'], int, stack: "Playlists-userId"),
      createTime: convertValueByType(jsonRes['createTime'], int,
          stack: "Playlists-createTime"),
      updateTime: convertValueByType(jsonRes['updateTime'], int,
          stack: "Playlists-updateTime"),
      subscribedCount: convertValueByType(jsonRes['subscribedCount'], int,
          stack: "Playlists-subscribedCount"),
      trackCount: convertValueByType(jsonRes['trackCount'], int,
          stack: "Playlists-trackCount"),
      cloudTrackCount: convertValueByType(jsonRes['cloudTrackCount'], int,
          stack: "Playlists-cloudTrackCount"),
      coverImgUrl: convertValueByType(jsonRes['coverImgUrl'], String,
          stack: "Playlists-coverImgUrl"),
      coverImgId: convertValueByType(jsonRes['coverImgId'], int,
          stack: "Playlists-coverImgId"),
      description: convertValueByType(jsonRes['description'], String,
          stack: "Playlists-description"),
      tags: tags,
      playCount: convertValueByType(jsonRes['playCount'], int,
          stack: "Playlists-playCount"),
      trackUpdateTime: convertValueByType(jsonRes['trackUpdateTime'], int,
          stack: "Playlists-trackUpdateTime"),
      specialType: convertValueByType(jsonRes['specialType'], int,
          stack: "Playlists-specialType"),
      totalDuration: convertValueByType(jsonRes['totalDuration'], int,
          stack: "Playlists-totalDuration"),
      creator: Creator.fromJson(jsonRes['creator']),
      tracks: convertValueByType(jsonRes['tracks'], Object,
          stack: "Playlists-tracks"),
      subscribers: subscribers,
      subscribed: convertValueByType(jsonRes['subscribed'], bool,
          stack: "Playlists-subscribed"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Playlists-commentThreadId"),
      newImported: convertValueByType(jsonRes['newImported'], bool,
          stack: "Playlists-newImported"),
      adType:
          convertValueByType(jsonRes['adType'], int, stack: "Playlists-adType"),
      highQuality: convertValueByType(jsonRes['highQuality'], bool,
          stack: "Playlists-highQuality"),
      privacy: convertValueByType(jsonRes['privacy'], int,
          stack: "Playlists-privacy"),
      ordered: convertValueByType(jsonRes['ordered'], bool,
          stack: "Playlists-ordered"),
      anonimous: convertValueByType(jsonRes['anonimous'], bool,
          stack: "Playlists-anonimous"),
      coverStatus: convertValueByType(jsonRes['coverStatus'], int,
          stack: "Playlists-coverStatus"),
      recommendInfo: convertValueByType(jsonRes['recommendInfo'], Object,
          stack: "Playlists-recommendInfo"),
      shareCount: convertValueByType(jsonRes['shareCount'], int,
          stack: "Playlists-shareCount"),
      commentCount: convertValueByType(jsonRes['commentCount'], int,
          stack: "Playlists-commentCount"),
      copywriter: convertValueByType(jsonRes['copywriter'], String,
          stack: "Playlists-copywriter"),
      tag: convertValueByType(jsonRes['tag'], String, stack: "Playlists-tag"),
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'trackNumberUpdateTime': trackNumberUpdateTime,
        'status': status,
        'userId': userId,
        'createTime': createTime,
        'updateTime': updateTime,
        'subscribedCount': subscribedCount,
        'trackCount': trackCount,
        'cloudTrackCount': cloudTrackCount,
        'coverImgUrl': coverImgUrl,
        'coverImgId': coverImgId,
        'description': description,
        'tags': tags,
        'playCount': playCount,
        'trackUpdateTime': trackUpdateTime,
        'specialType': specialType,
        'totalDuration': totalDuration,
        'creator': creator,
        'tracks': tracks,
        'subscribers': subscribers,
        'subscribed': subscribed,
        'commentThreadId': commentThreadId,
        'newImported': newImported,
        'adType': adType,
        'highQuality': highQuality,
        'privacy': privacy,
        'ordered': ordered,
        'anonimous': anonimous,
        'coverStatus': coverStatus,
        'recommendInfo': recommendInfo,
        'shareCount': shareCount,
        'commentCount': commentCount,
        'copywriter': copywriter,
        'tag': tag,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Creator {
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
  List<String> expertTags;
  Object experts;
  int djStatus;
  int vipType;
  Object remarkName;
  String avatarImgIdStr;
  String backgroundImgIdStr;
  String avatarImgId_str;

  Creator({
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

  factory Creator.fromJson(jsonRes) {
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

    return Creator(
      defaultAvatar: convertValueByType(jsonRes['defaultAvatar'], bool,
          stack: "Creator-defaultAvatar"),
      province: convertValueByType(jsonRes['province'], int,
          stack: "Creator-province"),
      authStatus: convertValueByType(jsonRes['authStatus'], int,
          stack: "Creator-authStatus"),
      followed: convertValueByType(jsonRes['followed'], bool,
          stack: "Creator-followed"),
      avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
          stack: "Creator-avatarUrl"),
      accountStatus: convertValueByType(jsonRes['accountStatus'], int,
          stack: "Creator-accountStatus"),
      gender:
          convertValueByType(jsonRes['gender'], int, stack: "Creator-gender"),
      city: convertValueByType(jsonRes['city'], int, stack: "Creator-city"),
      birthday: convertValueByType(jsonRes['birthday'], int,
          stack: "Creator-birthday"),
      userId:
          convertValueByType(jsonRes['userId'], int, stack: "Creator-userId"),
      userType: convertValueByType(jsonRes['userType'], int,
          stack: "Creator-userType"),
      nickname: convertValueByType(jsonRes['nickname'], String,
          stack: "Creator-nickname"),
      signature: convertValueByType(jsonRes['signature'], String,
          stack: "Creator-signature"),
      description: convertValueByType(jsonRes['description'], String,
          stack: "Creator-description"),
      detailDescription: convertValueByType(
          jsonRes['detailDescription'], String,
          stack: "Creator-detailDescription"),
      avatarImgId: convertValueByType(jsonRes['avatarImgId'], int,
          stack: "Creator-avatarImgId"),
      backgroundImgId: convertValueByType(jsonRes['backgroundImgId'], int,
          stack: "Creator-backgroundImgId"),
      backgroundUrl: convertValueByType(jsonRes['backgroundUrl'], String,
          stack: "Creator-backgroundUrl"),
      authority: convertValueByType(jsonRes['authority'], int,
          stack: "Creator-authority"),
      mutual:
          convertValueByType(jsonRes['mutual'], bool, stack: "Creator-mutual"),
      expertTags: expertTags,
      experts: convertValueByType(jsonRes['experts'], Object,
          stack: "Creator-experts"),
      djStatus: convertValueByType(jsonRes['djStatus'], int,
          stack: "Creator-djStatus"),
      vipType:
          convertValueByType(jsonRes['vipType'], int, stack: "Creator-vipType"),
      remarkName: convertValueByType(jsonRes['remarkName'], Object,
          stack: "Creator-remarkName"),
      avatarImgIdStr: convertValueByType(jsonRes['avatarImgIdStr'], String,
          stack: "Creator-avatarImgIdStr"),
      backgroundImgIdStr: convertValueByType(
          jsonRes['backgroundImgIdStr'], String,
          stack: "Creator-backgroundImgIdStr"),
      avatarImgId_str: convertValueByType(jsonRes['avatarImgId_str'], String,
          stack: "Creator-avatarImgId_str"),
    );
  }
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
