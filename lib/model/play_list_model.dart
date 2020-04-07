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

class PlayListModel {
  bool more;
  List<Playlist> playlist;
  int code;

  PlayListModel({
    this.more,
    this.playlist,
    this.code,
  });

  factory PlayListModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Playlist> playlist = jsonRes['playlist'] is List ? [] : null;
    if (playlist != null) {
      for (var item in jsonRes['playlist']) {
        if (item != null) {
          tryCatch(() {
            playlist.add(Playlist.fromJson(item));
          });
        }
      }
    }

    return PlayListModel(
      more: convertValueByType(jsonRes['more'], bool,
          stack: "PlayListModel-more"),
      playlist: playlist,
      code:
          convertValueByType(jsonRes['code'], int, stack: "PlayListModel-code"),
    );
  }
  Map<String, dynamic> toJson() => {
        'more': more,
        'playlist': playlist,
        'code': code,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Playlist {
  List<Object> subscribers;
  bool subscribed;
  Creator creator;
  Object artists;
  Object tracks;
  Object updateFrequency;
  int backgroundCoverId;
  Object backgroundCoverUrl;
  int titleImage;
  Object titleImageUrl;
  Object englishTitle;
  bool opRecommend;
  Object recommendInfo;
  int createTime;
  bool highQuality;
  List<Object> tags;
  int userId;
  bool newImported;
  bool anonimous;
  int updateTime;
  int coverImgId;
  int specialType;
  String coverImgUrl;
  int totalDuration;
  String commentThreadId;
  int trackNumberUpdateTime;
  int trackUpdateTime;
  int playCount;
  int trackCount;
  int privacy;
  Object description;
  int status;
  bool ordered;
  int adType;
  int subscribedCount;
  int cloudTrackCount;
  String name;
  int id;

  Playlist({
    this.subscribers,
    this.subscribed,
    this.creator,
    this.artists,
    this.tracks,
    this.updateFrequency,
    this.backgroundCoverId,
    this.backgroundCoverUrl,
    this.titleImage,
    this.titleImageUrl,
    this.englishTitle,
    this.opRecommend,
    this.recommendInfo,
    this.createTime,
    this.highQuality,
    this.tags,
    this.userId,
    this.newImported,
    this.anonimous,
    this.updateTime,
    this.coverImgId,
    this.specialType,
    this.coverImgUrl,
    this.totalDuration,
    this.commentThreadId,
    this.trackNumberUpdateTime,
    this.trackUpdateTime,
    this.playCount,
    this.trackCount,
    this.privacy,
    this.description,
    this.status,
    this.ordered,
    this.adType,
    this.subscribedCount,
    this.cloudTrackCount,
    this.name,
    this.id,
  });

  factory Playlist.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Object> subscribers = jsonRes['subscribers'] is List ? [] : null;
    if (subscribers != null) {
      for (var item in jsonRes['subscribers']) {
        if (item != null) {
          tryCatch(() {
            subscribers.add(item);
          });
        }
      }
    }

    List<Object> tags = jsonRes['tags'] is List ? [] : null;
    if (tags != null) {
      for (var item in jsonRes['tags']) {
        if (item != null) {
          tryCatch(() {
            tags.add(item);
          });
        }
      }
    }

    return Playlist(
      subscribers: subscribers,
      subscribed: convertValueByType(jsonRes['subscribed'], bool,
          stack: "Playlist-subscribed"),
      creator: Creator.fromJson(jsonRes['creator']),
      artists: convertValueByType(jsonRes['artists'], Object,
          stack: "Playlist-artists"),
      tracks: convertValueByType(jsonRes['tracks'], Object,
          stack: "Playlist-tracks"),
      updateFrequency: convertValueByType(jsonRes['updateFrequency'], Object,
          stack: "Playlist-updateFrequency"),
      backgroundCoverId: convertValueByType(jsonRes['backgroundCoverId'], int,
          stack: "Playlist-backgroundCoverId"),
      backgroundCoverUrl: convertValueByType(
          jsonRes['backgroundCoverUrl'], Object,
          stack: "Playlist-backgroundCoverUrl"),
      titleImage: convertValueByType(jsonRes['titleImage'], int,
          stack: "Playlist-titleImage"),
      titleImageUrl: convertValueByType(jsonRes['titleImageUrl'], Object,
          stack: "Playlist-titleImageUrl"),
      englishTitle: convertValueByType(jsonRes['englishTitle'], Object,
          stack: "Playlist-englishTitle"),
      opRecommend: convertValueByType(jsonRes['opRecommend'], bool,
          stack: "Playlist-opRecommend"),
      recommendInfo: convertValueByType(jsonRes['recommendInfo'], Object,
          stack: "Playlist-recommendInfo"),
      createTime: convertValueByType(jsonRes['createTime'], int,
          stack: "Playlist-createTime"),
      highQuality: convertValueByType(jsonRes['highQuality'], bool,
          stack: "Playlist-highQuality"),
      tags: tags,
      userId:
          convertValueByType(jsonRes['userId'], int, stack: "Playlist-userId"),
      newImported: convertValueByType(jsonRes['newImported'], bool,
          stack: "Playlist-newImported"),
      anonimous: convertValueByType(jsonRes['anonimous'], bool,
          stack: "Playlist-anonimous"),
      updateTime: convertValueByType(jsonRes['updateTime'], int,
          stack: "Playlist-updateTime"),
      coverImgId: convertValueByType(jsonRes['coverImgId'], int,
          stack: "Playlist-coverImgId"),
      specialType: convertValueByType(jsonRes['specialType'], int,
          stack: "Playlist-specialType"),
      coverImgUrl: convertValueByType(jsonRes['coverImgUrl'], String,
          stack: "Playlist-coverImgUrl"),
      totalDuration: convertValueByType(jsonRes['totalDuration'], int,
          stack: "Playlist-totalDuration"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Playlist-commentThreadId"),
      trackNumberUpdateTime: convertValueByType(
          jsonRes['trackNumberUpdateTime'], int,
          stack: "Playlist-trackNumberUpdateTime"),
      trackUpdateTime: convertValueByType(jsonRes['trackUpdateTime'], int,
          stack: "Playlist-trackUpdateTime"),
      playCount: convertValueByType(jsonRes['playCount'], int,
          stack: "Playlist-playCount"),
      trackCount: convertValueByType(jsonRes['trackCount'], int,
          stack: "Playlist-trackCount"),
      privacy: convertValueByType(jsonRes['privacy'], int,
          stack: "Playlist-privacy"),
      description: convertValueByType(jsonRes['description'], Object,
          stack: "Playlist-description"),
      status:
          convertValueByType(jsonRes['status'], int, stack: "Playlist-status"),
      ordered: convertValueByType(jsonRes['ordered'], bool,
          stack: "Playlist-ordered"),
      adType:
          convertValueByType(jsonRes['adType'], int, stack: "Playlist-adType"),
      subscribedCount: convertValueByType(jsonRes['subscribedCount'], int,
          stack: "Playlist-subscribedCount"),
      cloudTrackCount: convertValueByType(jsonRes['cloudTrackCount'], int,
          stack: "Playlist-cloudTrackCount"),
      name: convertValueByType(jsonRes['name'], String, stack: "Playlist-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Playlist-id"),
    );
  }
  Map<String, dynamic> toJson() => {
        'subscribers': subscribers,
        'subscribed': subscribed,
        'creator': creator,
        'artists': artists,
        'tracks': tracks,
        'updateFrequency': updateFrequency,
        'backgroundCoverId': backgroundCoverId,
        'backgroundCoverUrl': backgroundCoverUrl,
        'titleImage': titleImage,
        'titleImageUrl': titleImageUrl,
        'englishTitle': englishTitle,
        'opRecommend': opRecommend,
        'recommendInfo': recommendInfo,
        'createTime': createTime,
        'highQuality': highQuality,
        'tags': tags,
        'userId': userId,
        'newImported': newImported,
        'anonimous': anonimous,
        'updateTime': updateTime,
        'coverImgId': coverImgId,
        'specialType': specialType,
        'coverImgUrl': coverImgUrl,
        'totalDuration': totalDuration,
        'commentThreadId': commentThreadId,
        'trackNumberUpdateTime': trackNumberUpdateTime,
        'trackUpdateTime': trackUpdateTime,
        'playCount': playCount,
        'trackCount': trackCount,
        'privacy': privacy,
        'description': description,
        'status': status,
        'ordered': ordered,
        'adType': adType,
        'subscribedCount': subscribedCount,
        'cloudTrackCount': cloudTrackCount,
        'name': name,
        'id': id,
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
  Object expertTags;
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

  factory Creator.fromJson(jsonRes) => jsonRes == null
      ? null
      : Creator(
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
          gender: convertValueByType(jsonRes['gender'], int,
              stack: "Creator-gender"),
          city: convertValueByType(jsonRes['city'], int, stack: "Creator-city"),
          birthday: convertValueByType(jsonRes['birthday'], int,
              stack: "Creator-birthday"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "Creator-userId"),
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
          mutual: convertValueByType(jsonRes['mutual'], bool,
              stack: "Creator-mutual"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "Creator-expertTags"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "Creator-experts"),
          djStatus: convertValueByType(jsonRes['djStatus'], int,
              stack: "Creator-djStatus"),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "Creator-vipType"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "Creator-remarkName"),
          avatarImgIdStr: convertValueByType(jsonRes['avatarImgIdStr'], String,
              stack: "Creator-avatarImgIdStr"),
          backgroundImgIdStr: convertValueByType(
              jsonRes['backgroundImgIdStr'], String,
              stack: "Creator-backgroundImgIdStr"),
          avatarImgId_str: convertValueByType(
              jsonRes['avatarImgId_str'], String,
              stack: "Creator-avatarImgId_str"),
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
