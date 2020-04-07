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

class EventContentModel {
  String msg;
  Playlist playlist;
  Song song;
  Topic topic;
  Video video;

  EventContentModel({
    this.msg,
    this.playlist,
    this.song,
    this.topic,
    this.video,
  });

  factory EventContentModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : EventContentModel(
          msg: convertValueByType(jsonRes['msg'], String,
              stack: "EventContentModel-msg"),
          playlist: Playlist.fromJson(jsonRes['playlist']),
          song: Song.fromJson(jsonRes['song']),
          topic: Topic.fromJson(jsonRes['topic']),
          video: Video.fromJson(jsonRes['video']),
        );
  Map<String, dynamic> toJson() => {
        'msg': msg,
        'playlist': playlist,
        'song': song,
        'topic': topic,
        'video': video,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Topic {
  int addTime;
  int categoryId;
  String categoryName;
  int commentCount;
  String commentThreadId;
  String coverUrl;
  TopicCreator creator;
  int id;
  String img80x80;
  bool liked;
  int likedCount;
  String mainTitle;
  Object memo;
  int number;
  int readCount;
  String recmdContent;
  String recmdTitle;
  String rectanglePicUrl;
  Object relatedResource;
  bool reward;
  int rewardCount;
  double rewardMoney;
  int seriesId;
  String shareContent;
  int shareCount;
  bool showComment;
  bool showRelated;
  String summary;
  List<String> tags;
  String title;
  TopicDetail topic;
  String url;
  String wxTitle;

  Topic({
    this.addTime,
    this.categoryId,
    this.categoryName,
    this.commentCount,
    this.commentThreadId,
    this.coverUrl,
    this.creator,
    this.id,
    this.img80x80,
    this.liked,
    this.likedCount,
    this.mainTitle,
    this.memo,
    this.number,
    this.readCount,
    this.recmdContent,
    this.recmdTitle,
    this.rectanglePicUrl,
    this.relatedResource,
    this.reward,
    this.rewardCount,
    this.rewardMoney,
    this.seriesId,
    this.shareContent,
    this.shareCount,
    this.showComment,
    this.showRelated,
    this.summary,
    this.tags,
    this.title,
    this.topic,
    this.url,
    this.wxTitle,
  });

  factory Topic.fromJson(jsonRes) {
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

    return Topic(
      addTime:
          convertValueByType(jsonRes['addTime'], int, stack: "Topic-addTime"),
      categoryId: convertValueByType(jsonRes['categoryId'], int,
          stack: "Topic-categoryId"),
      categoryName: convertValueByType(jsonRes['categoryName'], String,
          stack: "Topic-categoryName"),
      commentCount: convertValueByType(jsonRes['commentCount'], int,
          stack: "Topic-commentCount"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Topic-commentThreadId"),
      coverUrl: convertValueByType(jsonRes['coverUrl'], String,
          stack: "Topic-coverUrl"),
      creator: TopicCreator.fromJson(jsonRes['creator']),
      id: convertValueByType(jsonRes['id'], int, stack: "Topic-id"),
      img80x80: convertValueByType(jsonRes['img80x80'], String,
          stack: "Topic-img80x80"),
      liked: convertValueByType(jsonRes['liked'], bool, stack: "Topic-liked"),
      likedCount: convertValueByType(jsonRes['likedCount'], int,
          stack: "Topic-likedCount"),
      mainTitle: convertValueByType(jsonRes['mainTitle'], String,
          stack: "Topic-mainTitle"),
      memo: convertValueByType(jsonRes['memo'], Object, stack: "Topic-memo"),
      number: convertValueByType(jsonRes['number'], int, stack: "Topic-number"),
      readCount: convertValueByType(jsonRes['readCount'], int,
          stack: "Topic-readCount"),
      recmdContent: convertValueByType(jsonRes['recmdContent'], String,
          stack: "Topic-recmdContent"),
      recmdTitle: convertValueByType(jsonRes['recmdTitle'], String,
          stack: "Topic-recmdTitle"),
      rectanglePicUrl: convertValueByType(jsonRes['rectanglePicUrl'], String,
          stack: "Topic-rectanglePicUrl"),
      relatedResource: convertValueByType(jsonRes['relatedResource'], Object,
          stack: "Topic-relatedResource"),
      reward:
          convertValueByType(jsonRes['reward'], bool, stack: "Topic-reward"),
      rewardCount: convertValueByType(jsonRes['rewardCount'], int,
          stack: "Topic-rewardCount"),
      rewardMoney: convertValueByType(jsonRes['rewardMoney'], double,
          stack: "Topic-rewardMoney"),
      seriesId:
          convertValueByType(jsonRes['seriesId'], int, stack: "Topic-seriesId"),
      shareContent: convertValueByType(jsonRes['shareContent'], String,
          stack: "Topic-shareContent"),
      shareCount: convertValueByType(jsonRes['shareCount'], int,
          stack: "Topic-shareCount"),
      showComment: convertValueByType(jsonRes['showComment'], bool,
          stack: "Topic-showComment"),
      showRelated: convertValueByType(jsonRes['showRelated'], bool,
          stack: "Topic-showRelated"),
      summary: convertValueByType(jsonRes['summary'], String,
          stack: "Topic-summary"),
      tags: tags,
      title: convertValueByType(jsonRes['title'], String, stack: "Topic-title"),
      topic: TopicDetail.fromJson(jsonRes['topic']),
      url: convertValueByType(jsonRes['url'], String, stack: "Topic-url"),
      wxTitle: convertValueByType(jsonRes['wxTitle'], String,
          stack: "Topic-wxTitle"),
    );
  }
  Map<String, dynamic> toJson() => {
        'addTime': addTime,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'commentCount': commentCount,
        'commentThreadId': commentThreadId,
        'coverUrl': coverUrl,
        'creator': creator,
        'id': id,
        'img80x80': img80x80,
        'liked': liked,
        'likedCount': likedCount,
        'mainTitle': mainTitle,
        'memo': memo,
        'number': number,
        'readCount': readCount,
        'recmdContent': recmdContent,
        'recmdTitle': recmdTitle,
        'rectanglePicUrl': rectanglePicUrl,
        'relatedResource': relatedResource,
        'reward': reward,
        'rewardCount': rewardCount,
        'rewardMoney': rewardMoney,
        'seriesId': seriesId,
        'shareContent': shareContent,
        'shareCount': shareCount,
        'showComment': showComment,
        'showRelated': showRelated,
        'summary': summary,
        'tags': tags,
        'title': title,
        'topic': topic,
        'url': url,
        'wxTitle': wxTitle,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TopicDetail {
  int addTime;
  String adInfo;
  String auditor;
  int auditStatus;
  int auditTime;
  int categoryId;
  List<Content> content;
  int cover;
  String delReason;
  bool fromBackend;
  int headPic;
  double hotScore;
  int id;
  String mainTitle;
  Object memo;
  int number;
  bool pubImmidiatly;
  int pubTime;
  int readCount;
  String recomdContent;
  String recomdTitle;
  int rectanglePic;
  bool reward;
  int seriesId;
  String shareContent;
  bool showComment;
  bool showRelated;
  String startText;
  int status;
  String summary;
  List<String> tags;
  String title;
  int updateTime;
  int userId;
  String wxTitle;

  TopicDetail({
    this.addTime,
    this.adInfo,
    this.auditor,
    this.auditStatus,
    this.auditTime,
    this.categoryId,
    this.content,
    this.cover,
    this.delReason,
    this.fromBackend,
    this.headPic,
    this.hotScore,
    this.id,
    this.mainTitle,
    this.memo,
    this.number,
    this.pubImmidiatly,
    this.pubTime,
    this.readCount,
    this.recomdContent,
    this.recomdTitle,
    this.rectanglePic,
    this.reward,
    this.seriesId,
    this.shareContent,
    this.showComment,
    this.showRelated,
    this.startText,
    this.status,
    this.summary,
    this.tags,
    this.title,
    this.updateTime,
    this.userId,
    this.wxTitle,
  });

  factory TopicDetail.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Content> content = jsonRes['content'] is List ? [] : null;
    if (content != null) {
      for (var item in jsonRes['content']) {
        if (item != null) {
          tryCatch(() {
            content.add(Content.fromJson(item));
          });
        }
      }
    }

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

    return TopicDetail(
      addTime: convertValueByType(jsonRes['addTime'], int,
          stack: "TopicDetail-addTime"),
      adInfo: convertValueByType(jsonRes['adInfo'], String,
          stack: "TopicDetail-adInfo"),
      auditor: convertValueByType(jsonRes['auditor'], String,
          stack: "TopicDetail-auditor"),
      auditStatus: convertValueByType(jsonRes['auditStatus'], int,
          stack: "TopicDetail-auditStatus"),
      auditTime: convertValueByType(jsonRes['auditTime'], int,
          stack: "TopicDetail-auditTime"),
      categoryId: convertValueByType(jsonRes['categoryId'], int,
          stack: "TopicDetail-categoryId"),
      content: content,
      cover:
          convertValueByType(jsonRes['cover'], int, stack: "TopicDetail-cover"),
      delReason: convertValueByType(jsonRes['delReason'], String,
          stack: "TopicDetail-delReason"),
      fromBackend: convertValueByType(jsonRes['fromBackend'], bool,
          stack: "TopicDetail-fromBackend"),
      headPic: convertValueByType(jsonRes['headPic'], int,
          stack: "TopicDetail-headPic"),
      hotScore: convertValueByType(jsonRes['hotScore'], double,
          stack: "TopicDetail-hotScore"),
      id: convertValueByType(jsonRes['id'], int, stack: "TopicDetail-id"),
      mainTitle: convertValueByType(jsonRes['mainTitle'], String,
          stack: "TopicDetail-mainTitle"),
      memo: convertValueByType(jsonRes['memo'], Object,
          stack: "TopicDetail-memo"),
      number: convertValueByType(jsonRes['number'], int,
          stack: "TopicDetail-number"),
      pubImmidiatly: convertValueByType(jsonRes['pubImmidiatly'], bool,
          stack: "TopicDetail-pubImmidiatly"),
      pubTime: convertValueByType(jsonRes['pubTime'], int,
          stack: "TopicDetail-pubTime"),
      readCount: convertValueByType(jsonRes['readCount'], int,
          stack: "TopicDetail-readCount"),
      recomdContent: convertValueByType(jsonRes['recomdContent'], String,
          stack: "TopicDetail-recomdContent"),
      recomdTitle: convertValueByType(jsonRes['recomdTitle'], String,
          stack: "TopicDetail-recomdTitle"),
      rectanglePic: convertValueByType(jsonRes['rectanglePic'], int,
          stack: "TopicDetail-rectanglePic"),
      reward: convertValueByType(jsonRes['reward'], bool,
          stack: "TopicDetail-reward"),
      seriesId: convertValueByType(jsonRes['seriesId'], int,
          stack: "TopicDetail-seriesId"),
      shareContent: convertValueByType(jsonRes['shareContent'], String,
          stack: "TopicDetail-shareContent"),
      showComment: convertValueByType(jsonRes['showComment'], bool,
          stack: "TopicDetail-showComment"),
      showRelated: convertValueByType(jsonRes['showRelated'], bool,
          stack: "TopicDetail-showRelated"),
      startText: convertValueByType(jsonRes['startText'], String,
          stack: "TopicDetail-startText"),
      status: convertValueByType(jsonRes['status'], int,
          stack: "TopicDetail-status"),
      summary: convertValueByType(jsonRes['summary'], String,
          stack: "TopicDetail-summary"),
      tags: tags,
      title: convertValueByType(jsonRes['title'], String,
          stack: "TopicDetail-title"),
      updateTime: convertValueByType(jsonRes['updateTime'], int,
          stack: "TopicDetail-updateTime"),
      userId: convertValueByType(jsonRes['userId'], int,
          stack: "TopicDetail-userId"),
      wxTitle: convertValueByType(jsonRes['wxTitle'], String,
          stack: "TopicDetail-wxTitle"),
    );
  }
  Map<String, dynamic> toJson() => {
        'addTime': addTime,
        'adInfo': adInfo,
        'auditor': auditor,
        'auditStatus': auditStatus,
        'auditTime': auditTime,
        'categoryId': categoryId,
        'content': content,
        'cover': cover,
        'delReason': delReason,
        'fromBackend': fromBackend,
        'headPic': headPic,
        'hotScore': hotScore,
        'id': id,
        'mainTitle': mainTitle,
        'memo': memo,
        'number': number,
        'pubImmidiatly': pubImmidiatly,
        'pubTime': pubTime,
        'readCount': readCount,
        'recomdContent': recomdContent,
        'recomdTitle': recomdTitle,
        'rectanglePic': rectanglePic,
        'reward': reward,
        'seriesId': seriesId,
        'shareContent': shareContent,
        'showComment': showComment,
        'showRelated': showRelated,
        'startText': startText,
        'status': status,
        'summary': summary,
        'tags': tags,
        'title': title,
        'updateTime': updateTime,
        'userId': userId,
        'wxTitle': wxTitle,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Content {
  String content;
  int id;
  int type;

  Content({
    this.content,
    this.id,
    this.type,
  });

  factory Content.fromJson(jsonRes) => jsonRes == null
      ? null
      : Content(
          content: convertValueByType(jsonRes['content'], String,
              stack: "Content-content"),
          id: convertValueByType(jsonRes['id'], int, stack: "Content-id"),
          type: convertValueByType(jsonRes['type'], int, stack: "Content-type"),
        );
  Map<String, dynamic> toJson() => {
        'content': content,
        'id': id,
        'type': type,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TopicCreator {
  int accountStatus;
  int accountType;
  bool anchor;
  bool authenticated;
  int authenticationTypes;
  int authority;
  int authStatus;
  int avatarImgId;
  String avatarUrl;
  int backgroundImgId;
  String backgroundUrl;
  int birthday;
  int city;
  int createTime;
  bool defaultAvatar;
  String description;
  String detailDescription;
  int djStatus;
  Object experts;
  Object expertTags;
  bool followed;
  int gender;
  String lastLoginIP;
  int lastLoginTime;
  int locationStatus;
  bool mutual;
  String nickname;
  int province;
  Object remarkName;
  String shortUserName;
  String signature;
  int userId;
  String userName;
  int userType;
  int vipType;
  int viptypeVersion;

  TopicCreator({
    this.accountStatus,
    this.accountType,
    this.anchor,
    this.authenticated,
    this.authenticationTypes,
    this.authority,
    this.authStatus,
    this.avatarImgId,
    this.avatarUrl,
    this.backgroundImgId,
    this.backgroundUrl,
    this.birthday,
    this.city,
    this.createTime,
    this.defaultAvatar,
    this.description,
    this.detailDescription,
    this.djStatus,
    this.experts,
    this.expertTags,
    this.followed,
    this.gender,
    this.lastLoginIP,
    this.lastLoginTime,
    this.locationStatus,
    this.mutual,
    this.nickname,
    this.province,
    this.remarkName,
    this.shortUserName,
    this.signature,
    this.userId,
    this.userName,
    this.userType,
    this.vipType,
    this.viptypeVersion,
  });

  factory TopicCreator.fromJson(jsonRes) => jsonRes == null
      ? null
      : TopicCreator(
          accountStatus: convertValueByType(jsonRes['accountStatus'], int,
              stack: "TopicCreator-accountStatus"),
          accountType: convertValueByType(jsonRes['accountType'], int,
              stack: "TopicCreator-accountType"),
          anchor: convertValueByType(jsonRes['anchor'], bool,
              stack: "TopicCreator-anchor"),
          authenticated: convertValueByType(jsonRes['authenticated'], bool,
              stack: "TopicCreator-authenticated"),
          authenticationTypes: convertValueByType(
              jsonRes['authenticationTypes'], int,
              stack: "TopicCreator-authenticationTypes"),
          authority: convertValueByType(jsonRes['authority'], int,
              stack: "TopicCreator-authority"),
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "TopicCreator-authStatus"),
          avatarImgId: convertValueByType(jsonRes['avatarImgId'], int,
              stack: "TopicCreator-avatarImgId"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "TopicCreator-avatarUrl"),
          backgroundImgId: convertValueByType(jsonRes['backgroundImgId'], int,
              stack: "TopicCreator-backgroundImgId"),
          backgroundUrl: convertValueByType(jsonRes['backgroundUrl'], String,
              stack: "TopicCreator-backgroundUrl"),
          birthday: convertValueByType(jsonRes['birthday'], int,
              stack: "TopicCreator-birthday"),
          city: convertValueByType(jsonRes['city'], int,
              stack: "TopicCreator-city"),
          createTime: convertValueByType(jsonRes['createTime'], int,
              stack: "TopicCreator-createTime"),
          defaultAvatar: convertValueByType(jsonRes['defaultAvatar'], bool,
              stack: "TopicCreator-defaultAvatar"),
          description: convertValueByType(jsonRes['description'], String,
              stack: "TopicCreator-description"),
          detailDescription: convertValueByType(
              jsonRes['detailDescription'], String,
              stack: "TopicCreator-detailDescription"),
          djStatus: convertValueByType(jsonRes['djStatus'], int,
              stack: "TopicCreator-djStatus"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "TopicCreator-experts"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "TopicCreator-expertTags"),
          followed: convertValueByType(jsonRes['followed'], bool,
              stack: "TopicCreator-followed"),
          gender: convertValueByType(jsonRes['gender'], int,
              stack: "TopicCreator-gender"),
          lastLoginIP: convertValueByType(jsonRes['lastLoginIP'], String,
              stack: "TopicCreator-lastLoginIP"),
          lastLoginTime: convertValueByType(jsonRes['lastLoginTime'], int,
              stack: "TopicCreator-lastLoginTime"),
          locationStatus: convertValueByType(jsonRes['locationStatus'], int,
              stack: "TopicCreator-locationStatus"),
          mutual: convertValueByType(jsonRes['mutual'], bool,
              stack: "TopicCreator-mutual"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "TopicCreator-nickname"),
          province: convertValueByType(jsonRes['province'], int,
              stack: "TopicCreator-province"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "TopicCreator-remarkName"),
          shortUserName: convertValueByType(jsonRes['shortUserName'], String,
              stack: "TopicCreator-shortUserName"),
          signature: convertValueByType(jsonRes['signature'], String,
              stack: "TopicCreator-signature"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "TopicCreator-userId"),
          userName: convertValueByType(jsonRes['userName'], String,
              stack: "TopicCreator-userName"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "TopicCreator-userType"),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "TopicCreator-vipType"),
          viptypeVersion: convertValueByType(jsonRes['viptypeVersion'], int,
              stack: "TopicCreator-viptypeVersion"),
        );
  Map<String, dynamic> toJson() => {
        'accountStatus': accountStatus,
        'accountType': accountType,
        'anchor': anchor,
        'authenticated': authenticated,
        'authenticationTypes': authenticationTypes,
        'authority': authority,
        'authStatus': authStatus,
        'avatarImgId': avatarImgId,
        'avatarUrl': avatarUrl,
        'backgroundImgId': backgroundImgId,
        'backgroundUrl': backgroundUrl,
        'birthday': birthday,
        'city': city,
        'createTime': createTime,
        'defaultAvatar': defaultAvatar,
        'description': description,
        'detailDescription': detailDescription,
        'djStatus': djStatus,
        'experts': experts,
        'expertTags': expertTags,
        'followed': followed,
        'gender': gender,
        'lastLoginIP': lastLoginIP,
        'lastLoginTime': lastLoginTime,
        'locationStatus': locationStatus,
        'mutual': mutual,
        'nickname': nickname,
        'province': province,
        'remarkName': remarkName,
        'shortUserName': shortUserName,
        'signature': signature,
        'userId': userId,
        'userName': userName,
        'userType': userType,
        'vipType': vipType,
        'viptypeVersion': viptypeVersion,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Song {
  Album album;
  List<Object> alias;
  List<Artists> artists;
  Object audition;
  BMusic bMusic;
  String commentThreadId;
  String copyFrom;
  int copyright;
  int copyrightId;
  String crbt;
  int dayPlays;
  String disc;
  int duration;
  int fee;
  int ftype;
  int hearTime;
  HMusic hMusic;
  int id;
  LMusic lMusic;
  MMusic mMusic;
  Object mp3Url;
  int mvid;
  String name;
  int no;
  int playedNum;
  double popularity;
  int position;
  String ringtone;
  Object rtUrl;
  List<Object> rtUrls;
  int rtype;
  Object rurl;
  int score;
  bool starred;
  int starredNum;
  int status;

  Song({
    this.album,
    this.alias,
    this.artists,
    this.audition,
    this.bMusic,
    this.commentThreadId,
    this.copyFrom,
    this.copyright,
    this.copyrightId,
    this.crbt,
    this.dayPlays,
    this.disc,
    this.duration,
    this.fee,
    this.ftype,
    this.hearTime,
    this.hMusic,
    this.id,
    this.lMusic,
    this.mMusic,
    this.mp3Url,
    this.mvid,
    this.name,
    this.no,
    this.playedNum,
    this.popularity,
    this.position,
    this.ringtone,
    this.rtUrl,
    this.rtUrls,
    this.rtype,
    this.rurl,
    this.score,
    this.starred,
    this.starredNum,
    this.status,
  });

  factory Song.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Object> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          tryCatch(() {
            alias.add(item);
          });
        }
      }
    }

    List<Artists> artists = jsonRes['artists'] is List ? [] : null;
    if (artists != null) {
      for (var item in jsonRes['artists']) {
        if (item != null) {
          tryCatch(() {
            artists.add(Artists.fromJson(item));
          });
        }
      }
    }

    List<Object> rtUrls = jsonRes['rtUrls'] is List ? [] : null;
    if (rtUrls != null) {
      for (var item in jsonRes['rtUrls']) {
        if (item != null) {
          tryCatch(() {
            rtUrls.add(item);
          });
        }
      }
    }

    return Song(
      album: Album.fromJson(jsonRes['album']),
      alias: alias,
      artists: artists,
      audition: convertValueByType(jsonRes['audition'], Object,
          stack: "Song-audition"),
      bMusic: BMusic.fromJson(jsonRes['bMusic']),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Song-commentThreadId"),
      copyFrom: convertValueByType(jsonRes['copyFrom'], String,
          stack: "Song-copyFrom"),
      copyright: convertValueByType(jsonRes['copyright'], int,
          stack: "Song-copyright"),
      copyrightId: convertValueByType(jsonRes['copyrightId'], int,
          stack: "Song-copyrightId"),
      crbt: convertValueByType(jsonRes['crbt'], String, stack: "Song-crbt"),
      dayPlays:
          convertValueByType(jsonRes['dayPlays'], int, stack: "Song-dayPlays"),
      disc: convertValueByType(jsonRes['disc'], String, stack: "Song-disc"),
      duration:
          convertValueByType(jsonRes['duration'], int, stack: "Song-duration"),
      fee: convertValueByType(jsonRes['fee'], int, stack: "Song-fee"),
      ftype: convertValueByType(jsonRes['ftype'], int, stack: "Song-ftype"),
      hearTime:
          convertValueByType(jsonRes['hearTime'], int, stack: "Song-hearTime"),
      hMusic: HMusic.fromJson(jsonRes['hMusic']),
      id: convertValueByType(jsonRes['id'], int, stack: "Song-id"),
      lMusic: LMusic.fromJson(jsonRes['lMusic']),
      mMusic: MMusic.fromJson(jsonRes['mMusic']),
      mp3Url:
          convertValueByType(jsonRes['mp3Url'], Object, stack: "Song-mp3Url"),
      mvid: convertValueByType(jsonRes['mvid'], int, stack: "Song-mvid"),
      name: convertValueByType(jsonRes['name'], String, stack: "Song-name"),
      no: convertValueByType(jsonRes['no'], int, stack: "Song-no"),
      playedNum: convertValueByType(jsonRes['playedNum'], int,
          stack: "Song-playedNum"),
      popularity: convertValueByType(jsonRes['popularity'], double,
          stack: "Song-popularity"),
      position:
          convertValueByType(jsonRes['position'], int, stack: "Song-position"),
      ringtone: convertValueByType(jsonRes['ringtone'], String,
          stack: "Song-ringtone"),
      rtUrl: convertValueByType(jsonRes['rtUrl'], Object, stack: "Song-rtUrl"),
      rtUrls: rtUrls,
      rtype: convertValueByType(jsonRes['rtype'], int, stack: "Song-rtype"),
      rurl: convertValueByType(jsonRes['rurl'], Object, stack: "Song-rurl"),
      score: convertValueByType(jsonRes['score'], int, stack: "Song-score"),
      starred:
          convertValueByType(jsonRes['starred'], bool, stack: "Song-starred"),
      starredNum: convertValueByType(jsonRes['starredNum'], int,
          stack: "Song-starredNum"),
      status: convertValueByType(jsonRes['status'], int, stack: "Song-status"),
    );
  }
  Map<String, dynamic> toJson() => {
        'album': album,
        'alias': alias,
        'artists': artists,
        'audition': audition,
        'bMusic': bMusic,
        'commentThreadId': commentThreadId,
        'copyFrom': copyFrom,
        'copyright': copyright,
        'copyrightId': copyrightId,
        'crbt': crbt,
        'dayPlays': dayPlays,
        'disc': disc,
        'duration': duration,
        'fee': fee,
        'ftype': ftype,
        'hearTime': hearTime,
        'hMusic': hMusic,
        'id': id,
        'lMusic': lMusic,
        'mMusic': mMusic,
        'mp3Url': mp3Url,
        'mvid': mvid,
        'name': name,
        'no': no,
        'playedNum': playedNum,
        'popularity': popularity,
        'position': position,
        'ringtone': ringtone,
        'rtUrl': rtUrl,
        'rtUrls': rtUrls,
        'rtype': rtype,
        'rurl': rurl,
        'score': score,
        'starred': starred,
        'starredNum': starredNum,
        'status': status,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Artists {
  int albumSize;
  List<Object> alias;
  String briefDesc;
  int id;
  int img1v1Id;
  String img1v1Url;
  int musicSize;
  String name;
  int picId;
  String picUrl;
  String trans;

  Artists({
    this.albumSize,
    this.alias,
    this.briefDesc,
    this.id,
    this.img1v1Id,
    this.img1v1Url,
    this.musicSize,
    this.name,
    this.picId,
    this.picUrl,
    this.trans,
  });

  factory Artists.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Object> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          tryCatch(() {
            alias.add(item);
          });
        }
      }
    }

    return Artists(
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "Artists-albumSize"),
      alias: alias,
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "Artists-briefDesc"),
      id: convertValueByType(jsonRes['id'], int, stack: "Artists-id"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "Artists-img1v1Id"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "Artists-img1v1Url"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "Artists-musicSize"),
      name: convertValueByType(jsonRes['name'], String, stack: "Artists-name"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Artists-picId"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "Artists-picUrl"),
      trans:
          convertValueByType(jsonRes['trans'], String, stack: "Artists-trans"),
    );
  }
  Map<String, dynamic> toJson() => {
        'albumSize': albumSize,
        'alias': alias,
        'briefDesc': briefDesc,
        'id': id,
        'img1v1Id': img1v1Id,
        'img1v1Url': img1v1Url,
        'musicSize': musicSize,
        'name': name,
        'picId': picId,
        'picUrl': picUrl,
        'trans': trans,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Album {
  List<Object> alias;
  Artist artist;
  List<AlbumArtists> artists;
  String blurPicUrl;
  String briefDesc;
  String commentThreadId;
  String company;
  int companyId;
  int copyrightId;
  String description;
  int id;
  String img80x80;
  String name;
  int pic;
  int picId;
  String picUrl;
  int publishTime;
  int size;
  List<Object> songs;
  int status;
  String tags;
  String type;

  Album({
    this.alias,
    this.artist,
    this.artists,
    this.blurPicUrl,
    this.briefDesc,
    this.commentThreadId,
    this.company,
    this.companyId,
    this.copyrightId,
    this.description,
    this.id,
    this.img80x80,
    this.name,
    this.pic,
    this.picId,
    this.picUrl,
    this.publishTime,
    this.size,
    this.songs,
    this.status,
    this.tags,
    this.type,
  });

  factory Album.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Object> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          tryCatch(() {
            alias.add(item);
          });
        }
      }
    }

    List<AlbumArtists> artists = jsonRes['artists'] is List ? [] : null;
    if (artists != null) {
      for (var item in jsonRes['artists']) {
        if (item != null) {
          tryCatch(() {
            artists.add(AlbumArtists.fromJson(item));
          });
        }
      }
    }

    List<Object> songs = jsonRes['songs'] is List ? [] : null;
    if (songs != null) {
      for (var item in jsonRes['songs']) {
        if (item != null) {
          tryCatch(() {
            songs.add(item);
          });
        }
      }
    }

    return Album(
      alias: alias,
      artist: Artist.fromJson(jsonRes['artist']),
      artists: artists,
      blurPicUrl: convertValueByType(jsonRes['blurPicUrl'], String,
          stack: "Album-blurPicUrl"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "Album-briefDesc"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Album-commentThreadId"),
      company: convertValueByType(jsonRes['company'], String,
          stack: "Album-company"),
      companyId: convertValueByType(jsonRes['companyId'], int,
          stack: "Album-companyId"),
      copyrightId: convertValueByType(jsonRes['copyrightId'], int,
          stack: "Album-copyrightId"),
      description: convertValueByType(jsonRes['description'], String,
          stack: "Album-description"),
      id: convertValueByType(jsonRes['id'], int, stack: "Album-id"),
      img80x80: convertValueByType(jsonRes['img80x80'], String,
          stack: "Album-img80x80"),
      name: convertValueByType(jsonRes['name'], String, stack: "Album-name"),
      pic: convertValueByType(jsonRes['pic'], int, stack: "Album-pic"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Album-picId"),
      picUrl:
          convertValueByType(jsonRes['picUrl'], String, stack: "Album-picUrl"),
      publishTime: convertValueByType(jsonRes['publishTime'], int,
          stack: "Album-publishTime"),
      size: convertValueByType(jsonRes['size'], int, stack: "Album-size"),
      songs: songs,
      status: convertValueByType(jsonRes['status'], int, stack: "Album-status"),
      tags: convertValueByType(jsonRes['tags'], String, stack: "Album-tags"),
      type: convertValueByType(jsonRes['type'], String, stack: "Album-type"),
    );
  }
  Map<String, dynamic> toJson() => {
        'alias': alias,
        'artist': artist,
        'artists': artists,
        'blurPicUrl': blurPicUrl,
        'briefDesc': briefDesc,
        'commentThreadId': commentThreadId,
        'company': company,
        'companyId': companyId,
        'copyrightId': copyrightId,
        'description': description,
        'id': id,
        'img80x80': img80x80,
        'name': name,
        'pic': pic,
        'picId': picId,
        'picUrl': picUrl,
        'publishTime': publishTime,
        'size': size,
        'songs': songs,
        'status': status,
        'tags': tags,
        'type': type,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Artist {
  int albumSize;
  List<Object> alias;
  String briefDesc;
  int id;
  int img1v1Id;
  String img1v1Url;
  int musicSize;
  String name;
  int picId;
  String picUrl;
  String trans;

  Artist({
    this.albumSize,
    this.alias,
    this.briefDesc,
    this.id,
    this.img1v1Id,
    this.img1v1Url,
    this.musicSize,
    this.name,
    this.picId,
    this.picUrl,
    this.trans,
  });

  factory Artist.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Object> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          tryCatch(() {
            alias.add(item);
          });
        }
      }
    }

    return Artist(
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "Artist-albumSize"),
      alias: alias,
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "Artist-briefDesc"),
      id: convertValueByType(jsonRes['id'], int, stack: "Artist-id"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "Artist-img1v1Id"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "Artist-img1v1Url"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "Artist-musicSize"),
      name: convertValueByType(jsonRes['name'], String, stack: "Artist-name"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Artist-picId"),
      picUrl:
          convertValueByType(jsonRes['picUrl'], String, stack: "Artist-picUrl"),
      trans:
          convertValueByType(jsonRes['trans'], String, stack: "Artist-trans"),
    );
  }
  Map<String, dynamic> toJson() => {
        'albumSize': albumSize,
        'alias': alias,
        'briefDesc': briefDesc,
        'id': id,
        'img1v1Id': img1v1Id,
        'img1v1Url': img1v1Url,
        'musicSize': musicSize,
        'name': name,
        'picId': picId,
        'picUrl': picUrl,
        'trans': trans,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class AlbumArtists {
  int albumSize;
  List<Object> alias;
  String briefDesc;
  int id;
  int img1v1Id;
  String img1v1Url;
  int musicSize;
  String name;
  int picId;
  String picUrl;
  String trans;

  AlbumArtists({
    this.albumSize,
    this.alias,
    this.briefDesc,
    this.id,
    this.img1v1Id,
    this.img1v1Url,
    this.musicSize,
    this.name,
    this.picId,
    this.picUrl,
    this.trans,
  });

  factory AlbumArtists.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Object> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          tryCatch(() {
            alias.add(item);
          });
        }
      }
    }

    return AlbumArtists(
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "AlbumArtists-albumSize"),
      alias: alias,
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "AlbumArtists-briefDesc"),
      id: convertValueByType(jsonRes['id'], int, stack: "AlbumArtists-id"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "AlbumArtists-img1v1Id"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "AlbumArtists-img1v1Url"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "AlbumArtists-musicSize"),
      name: convertValueByType(jsonRes['name'], String,
          stack: "AlbumArtists-name"),
      picId: convertValueByType(jsonRes['picId'], int,
          stack: "AlbumArtists-picId"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "AlbumArtists-picUrl"),
      trans: convertValueByType(jsonRes['trans'], String,
          stack: "AlbumArtists-trans"),
    );
  }
  Map<String, dynamic> toJson() => {
        'albumSize': albumSize,
        'alias': alias,
        'briefDesc': briefDesc,
        'id': id,
        'img1v1Id': img1v1Id,
        'img1v1Url': img1v1Url,
        'musicSize': musicSize,
        'name': name,
        'picId': picId,
        'picUrl': picUrl,
        'trans': trans,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class HMusic {
  int bitrate;
  int dfsId;
  String extension;
  int id;
  Object name;
  int playTime;
  int size;
  int sr;
  double volumeDelta;

  HMusic({
    this.bitrate,
    this.dfsId,
    this.extension,
    this.id,
    this.name,
    this.playTime,
    this.size,
    this.sr,
    this.volumeDelta,
  });

  factory HMusic.fromJson(jsonRes) => jsonRes == null
      ? null
      : HMusic(
          bitrate: convertValueByType(jsonRes['bitrate'], int,
              stack: "HMusic-bitrate"),
          dfsId:
              convertValueByType(jsonRes['dfsId'], int, stack: "HMusic-dfsId"),
          extension: convertValueByType(jsonRes['extension'], String,
              stack: "HMusic-extension"),
          id: convertValueByType(jsonRes['id'], int, stack: "HMusic-id"),
          name:
              convertValueByType(jsonRes['name'], Object, stack: "HMusic-name"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "HMusic-playTime"),
          size: convertValueByType(jsonRes['size'], int, stack: "HMusic-size"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "HMusic-sr"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], double,
              stack: "HMusic-volumeDelta"),
        );
  Map<String, dynamic> toJson() => {
        'bitrate': bitrate,
        'dfsId': dfsId,
        'extension': extension,
        'id': id,
        'name': name,
        'playTime': playTime,
        'size': size,
        'sr': sr,
        'volumeDelta': volumeDelta,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class MMusic {
  int bitrate;
  int dfsId;
  String extension;
  int id;
  Object name;
  int playTime;
  int size;
  int sr;
  double volumeDelta;

  MMusic({
    this.bitrate,
    this.dfsId,
    this.extension,
    this.id,
    this.name,
    this.playTime,
    this.size,
    this.sr,
    this.volumeDelta,
  });

  factory MMusic.fromJson(jsonRes) => jsonRes == null
      ? null
      : MMusic(
          bitrate: convertValueByType(jsonRes['bitrate'], int,
              stack: "MMusic-bitrate"),
          dfsId:
              convertValueByType(jsonRes['dfsId'], int, stack: "MMusic-dfsId"),
          extension: convertValueByType(jsonRes['extension'], String,
              stack: "MMusic-extension"),
          id: convertValueByType(jsonRes['id'], int, stack: "MMusic-id"),
          name:
              convertValueByType(jsonRes['name'], Object, stack: "MMusic-name"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "MMusic-playTime"),
          size: convertValueByType(jsonRes['size'], int, stack: "MMusic-size"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "MMusic-sr"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], double,
              stack: "MMusic-volumeDelta"),
        );
  Map<String, dynamic> toJson() => {
        'bitrate': bitrate,
        'dfsId': dfsId,
        'extension': extension,
        'id': id,
        'name': name,
        'playTime': playTime,
        'size': size,
        'sr': sr,
        'volumeDelta': volumeDelta,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class LMusic {
  int bitrate;
  int dfsId;
  String extension;
  int id;
  Object name;
  int playTime;
  int size;
  int sr;
  double volumeDelta;

  LMusic({
    this.bitrate,
    this.dfsId,
    this.extension,
    this.id,
    this.name,
    this.playTime,
    this.size,
    this.sr,
    this.volumeDelta,
  });

  factory LMusic.fromJson(jsonRes) => jsonRes == null
      ? null
      : LMusic(
          bitrate: convertValueByType(jsonRes['bitrate'], int,
              stack: "LMusic-bitrate"),
          dfsId:
              convertValueByType(jsonRes['dfsId'], int, stack: "LMusic-dfsId"),
          extension: convertValueByType(jsonRes['extension'], String,
              stack: "LMusic-extension"),
          id: convertValueByType(jsonRes['id'], int, stack: "LMusic-id"),
          name:
              convertValueByType(jsonRes['name'], Object, stack: "LMusic-name"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "LMusic-playTime"),
          size: convertValueByType(jsonRes['size'], int, stack: "LMusic-size"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "LMusic-sr"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], double,
              stack: "LMusic-volumeDelta"),
        );
  Map<String, dynamic> toJson() => {
        'bitrate': bitrate,
        'dfsId': dfsId,
        'extension': extension,
        'id': id,
        'name': name,
        'playTime': playTime,
        'size': size,
        'sr': sr,
        'volumeDelta': volumeDelta,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class BMusic {
  int bitrate;
  int dfsId;
  String extension;
  int id;
  Object name;
  int playTime;
  int size;
  int sr;
  double volumeDelta;

  BMusic({
    this.bitrate,
    this.dfsId,
    this.extension,
    this.id,
    this.name,
    this.playTime,
    this.size,
    this.sr,
    this.volumeDelta,
  });

  factory BMusic.fromJson(jsonRes) => jsonRes == null
      ? null
      : BMusic(
          bitrate: convertValueByType(jsonRes['bitrate'], int,
              stack: "BMusic-bitrate"),
          dfsId:
              convertValueByType(jsonRes['dfsId'], int, stack: "BMusic-dfsId"),
          extension: convertValueByType(jsonRes['extension'], String,
              stack: "BMusic-extension"),
          id: convertValueByType(jsonRes['id'], int, stack: "BMusic-id"),
          name:
              convertValueByType(jsonRes['name'], Object, stack: "BMusic-name"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "BMusic-playTime"),
          size: convertValueByType(jsonRes['size'], int, stack: "BMusic-size"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "BMusic-sr"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], double,
              stack: "BMusic-volumeDelta"),
        );
  Map<String, dynamic> toJson() => {
        'bitrate': bitrate,
        'dfsId': dfsId,
        'extension': extension,
        'id': id,
        'name': name,
        'playTime': playTime,
        'size': size,
        'sr': sr,
        'volumeDelta': volumeDelta,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Playlist {
  int adType;
  bool anonimous;
  int cloudTrackCount;
  String commentThreadId;
  int coverImgId;
  String coverimgidStr;
  String coverImgUrl;
  int createTime;
  PlaylistCreator creator;
  String description;
  bool highQuality;
  int id;
  String name;
  bool newImported;
  bool ordered;
  int playCount;
  int privacy;
  int specialType;
  int status;
  Object subscribed;
  int subscribedCount;
  List<Object> subscribers;
  List<String> tags;
  int totalDuration;
  int trackCount;
  int trackNumberUpdateTime;
  Object tracks;
  int trackUpdateTime;
  int updateTime;
  int userId;

  Playlist({
    this.adType,
    this.anonimous,
    this.cloudTrackCount,
    this.commentThreadId,
    this.coverImgId,
    this.coverimgidStr,
    this.coverImgUrl,
    this.createTime,
    this.creator,
    this.description,
    this.highQuality,
    this.id,
    this.name,
    this.newImported,
    this.ordered,
    this.playCount,
    this.privacy,
    this.specialType,
    this.status,
    this.subscribed,
    this.subscribedCount,
    this.subscribers,
    this.tags,
    this.totalDuration,
    this.trackCount,
    this.trackNumberUpdateTime,
    this.tracks,
    this.trackUpdateTime,
    this.updateTime,
    this.userId,
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

    return Playlist(
      adType:
          convertValueByType(jsonRes['adType'], int, stack: "Playlist-adType"),
      anonimous: convertValueByType(jsonRes['anonimous'], bool,
          stack: "Playlist-anonimous"),
      cloudTrackCount: convertValueByType(jsonRes['cloudTrackCount'], int,
          stack: "Playlist-cloudTrackCount"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Playlist-commentThreadId"),
      coverImgId: convertValueByType(jsonRes['coverImgId'], int,
          stack: "Playlist-coverImgId"),
      coverimgidStr: convertValueByType(jsonRes['coverImgId_str'], String,
          stack: "Playlist-coverImgId_str"),
      coverImgUrl: convertValueByType(jsonRes['coverImgUrl'], String,
          stack: "Playlist-coverImgUrl"),
      createTime: convertValueByType(jsonRes['createTime'], int,
          stack: "Playlist-createTime"),
      creator: PlaylistCreator.fromJson(jsonRes['creator']),
      description: convertValueByType(jsonRes['description'], String,
          stack: "Playlist-description"),
      highQuality: convertValueByType(jsonRes['highQuality'], bool,
          stack: "Playlist-highQuality"),
      id: convertValueByType(jsonRes['id'], int, stack: "Playlist-id"),
      name: convertValueByType(jsonRes['name'], String, stack: "Playlist-name"),
      newImported: convertValueByType(jsonRes['newImported'], bool,
          stack: "Playlist-newImported"),
      ordered: convertValueByType(jsonRes['ordered'], bool,
          stack: "Playlist-ordered"),
      playCount: convertValueByType(jsonRes['playCount'], int,
          stack: "Playlist-playCount"),
      privacy: convertValueByType(jsonRes['privacy'], int,
          stack: "Playlist-privacy"),
      specialType: convertValueByType(jsonRes['specialType'], int,
          stack: "Playlist-specialType"),
      status:
          convertValueByType(jsonRes['status'], int, stack: "Playlist-status"),
      subscribed: convertValueByType(jsonRes['subscribed'], Object,
          stack: "Playlist-subscribed"),
      subscribedCount: convertValueByType(jsonRes['subscribedCount'], int,
          stack: "Playlist-subscribedCount"),
      subscribers: subscribers,
      tags: tags,
      totalDuration: convertValueByType(jsonRes['totalDuration'], int,
          stack: "Playlist-totalDuration"),
      trackCount: convertValueByType(jsonRes['trackCount'], int,
          stack: "Playlist-trackCount"),
      trackNumberUpdateTime: convertValueByType(
          jsonRes['trackNumberUpdateTime'], int,
          stack: "Playlist-trackNumberUpdateTime"),
      tracks: convertValueByType(jsonRes['tracks'], Object,
          stack: "Playlist-tracks"),
      trackUpdateTime: convertValueByType(jsonRes['trackUpdateTime'], int,
          stack: "Playlist-trackUpdateTime"),
      updateTime: convertValueByType(jsonRes['updateTime'], int,
          stack: "Playlist-updateTime"),
      userId:
          convertValueByType(jsonRes['userId'], int, stack: "Playlist-userId"),
    );
  }
  Map<String, dynamic> toJson() => {
        'adType': adType,
        'anonimous': anonimous,
        'cloudTrackCount': cloudTrackCount,
        'commentThreadId': commentThreadId,
        'coverImgId': coverImgId,
        'coverImgId_str': coverimgidStr,
        'coverImgUrl': coverImgUrl,
        'createTime': createTime,
        'creator': creator,
        'description': description,
        'highQuality': highQuality,
        'id': id,
        'name': name,
        'newImported': newImported,
        'ordered': ordered,
        'playCount': playCount,
        'privacy': privacy,
        'specialType': specialType,
        'status': status,
        'subscribed': subscribed,
        'subscribedCount': subscribedCount,
        'subscribers': subscribers,
        'tags': tags,
        'totalDuration': totalDuration,
        'trackCount': trackCount,
        'trackNumberUpdateTime': trackNumberUpdateTime,
        'tracks': tracks,
        'trackUpdateTime': trackUpdateTime,
        'updateTime': updateTime,
        'userId': userId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class PlaylistCreator {
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
  int gender;
  bool mutual;
  String nickname;
  int province;
  Object remarkName;
  String signature;
  int userId;
  int userType;
  int vipType;

  PlaylistCreator({
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

  factory PlaylistCreator.fromJson(jsonRes) => jsonRes == null
      ? null
      : PlaylistCreator(
          accountStatus: convertValueByType(jsonRes['accountStatus'], int,
              stack: "PlaylistCreator-accountStatus"),
          authority: convertValueByType(jsonRes['authority'], int,
              stack: "PlaylistCreator-authority"),
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "PlaylistCreator-authStatus"),
          avatarImgId: convertValueByType(jsonRes['avatarImgId'], int,
              stack: "PlaylistCreator-avatarImgId"),
          avatarimgidStr: convertValueByType(jsonRes['avatarImgId_str'], String,
              stack: "PlaylistCreator-avatarImgId_str"),
          avatarImgIdStr: convertValueByType(jsonRes['avatarImgIdStr'], String,
              stack: "PlaylistCreator-avatarImgIdStr"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "PlaylistCreator-avatarUrl"),
          backgroundImgId: convertValueByType(jsonRes['backgroundImgId'], int,
              stack: "PlaylistCreator-backgroundImgId"),
          backgroundImgIdStr: convertValueByType(
              jsonRes['backgroundImgIdStr'], String,
              stack: "PlaylistCreator-backgroundImgIdStr"),
          backgroundUrl: convertValueByType(jsonRes['backgroundUrl'], String,
              stack: "PlaylistCreator-backgroundUrl"),
          birthday: convertValueByType(jsonRes['birthday'], int,
              stack: "PlaylistCreator-birthday"),
          city: convertValueByType(jsonRes['city'], int,
              stack: "PlaylistCreator-city"),
          defaultAvatar: convertValueByType(jsonRes['defaultAvatar'], bool,
              stack: "PlaylistCreator-defaultAvatar"),
          description: convertValueByType(jsonRes['description'], String,
              stack: "PlaylistCreator-description"),
          detailDescription: convertValueByType(
              jsonRes['detailDescription'], String,
              stack: "PlaylistCreator-detailDescription"),
          djStatus: convertValueByType(jsonRes['djStatus'], int,
              stack: "PlaylistCreator-djStatus"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "PlaylistCreator-experts"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "PlaylistCreator-expertTags"),
          followed: convertValueByType(jsonRes['followed'], bool,
              stack: "PlaylistCreator-followed"),
          gender: convertValueByType(jsonRes['gender'], int,
              stack: "PlaylistCreator-gender"),
          mutual: convertValueByType(jsonRes['mutual'], bool,
              stack: "PlaylistCreator-mutual"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "PlaylistCreator-nickname"),
          province: convertValueByType(jsonRes['province'], int,
              stack: "PlaylistCreator-province"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "PlaylistCreator-remarkName"),
          signature: convertValueByType(jsonRes['signature'], String,
              stack: "PlaylistCreator-signature"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "PlaylistCreator-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "PlaylistCreator-userType"),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "PlaylistCreator-vipType"),
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

class Video {
  bool antisChecking;
  int coverType;
  String coverUrl;
  VideoCreator creator;
  String description;
  int duration;
  int durationms;
  int height;
  int playTime;
  List<Resolutions> resolutions;
  int size;
  int state;
  Object threadId;
  String title;
  Object urlInfo;
  int vid;
  String videoId;
  int videoStatus;
  int width;

  Video({
    this.antisChecking,
    this.coverType,
    this.coverUrl,
    this.creator,
    this.description,
    this.duration,
    this.durationms,
    this.height,
    this.playTime,
    this.resolutions,
    this.size,
    this.state,
    this.threadId,
    this.title,
    this.urlInfo,
    this.vid,
    this.videoId,
    this.videoStatus,
    this.width,
  });

  factory Video.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Resolutions> resolutions = jsonRes['resolutions'] is List ? [] : null;
    if (resolutions != null) {
      for (var item in jsonRes['resolutions']) {
        if (item != null) {
          tryCatch(() {
            resolutions.add(Resolutions.fromJson(item));
          });
        }
      }
    }

    return Video(
      antisChecking: convertValueByType(jsonRes['antisChecking'], bool,
          stack: "Video-antisChecking"),
      coverType: convertValueByType(jsonRes['coverType'], int,
          stack: "Video-coverType"),
      coverUrl: convertValueByType(jsonRes['coverUrl'], String,
          stack: "Video-coverUrl"),
      creator: VideoCreator.fromJson(jsonRes['creator']),
      description: convertValueByType(jsonRes['description'], String,
          stack: "Video-description"),
      duration:
          convertValueByType(jsonRes['duration'], int, stack: "Video-duration"),
      durationms: convertValueByType(jsonRes['durationms'], int,
          stack: "Video-durationms"),
      height: convertValueByType(jsonRes['height'], int, stack: "Video-height"),
      playTime:
          convertValueByType(jsonRes['playTime'], int, stack: "Video-playTime"),
      resolutions: resolutions,
      size: convertValueByType(jsonRes['size'], int, stack: "Video-size"),
      state: convertValueByType(jsonRes['state'], int, stack: "Video-state"),
      threadId: convertValueByType(jsonRes['threadId'], Object,
          stack: "Video-threadId"),
      title: convertValueByType(jsonRes['title'], String, stack: "Video-title"),
      urlInfo: convertValueByType(jsonRes['urlInfo'], Object,
          stack: "Video-urlInfo"),
      vid: convertValueByType(jsonRes['vid'], int, stack: "Video-vid"),
      videoId: convertValueByType(jsonRes['videoId'], String,
          stack: "Video-videoId"),
      videoStatus: convertValueByType(jsonRes['videoStatus'], int,
          stack: "Video-videoStatus"),
      width: convertValueByType(jsonRes['width'], int, stack: "Video-width"),
    );
  }
  Map<String, dynamic> toJson() => {
        'antisChecking': antisChecking,
        'coverType': coverType,
        'coverUrl': coverUrl,
        'creator': creator,
        'description': description,
        'duration': duration,
        'durationms': durationms,
        'height': height,
        'playTime': playTime,
        'resolutions': resolutions,
        'size': size,
        'state': state,
        'threadId': threadId,
        'title': title,
        'urlInfo': urlInfo,
        'vid': vid,
        'videoId': videoId,
        'videoStatus': videoStatus,
        'width': width,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class VideoCreator {
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
  int gender;
  bool mutual;
  String nickname;
  int province;
  Object remarkName;
  String signature;
  int userId;
  int userType;
  int vipType;

  VideoCreator({
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

  factory VideoCreator.fromJson(jsonRes) => jsonRes == null
      ? null
      : VideoCreator(
          accountStatus: convertValueByType(jsonRes['accountStatus'], int,
              stack: "VideoCreator-accountStatus"),
          authority: convertValueByType(jsonRes['authority'], int,
              stack: "VideoCreator-authority"),
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "VideoCreator-authStatus"),
          avatarImgId: convertValueByType(jsonRes['avatarImgId'], int,
              stack: "VideoCreator-avatarImgId"),
          avatarimgidStr: convertValueByType(jsonRes['avatarImgId_str'], String,
              stack: "VideoCreator-avatarImgId_str"),
          avatarImgIdStr: convertValueByType(jsonRes['avatarImgIdStr'], String,
              stack: "VideoCreator-avatarImgIdStr"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "VideoCreator-avatarUrl"),
          backgroundImgId: convertValueByType(jsonRes['backgroundImgId'], int,
              stack: "VideoCreator-backgroundImgId"),
          backgroundImgIdStr: convertValueByType(
              jsonRes['backgroundImgIdStr'], String,
              stack: "VideoCreator-backgroundImgIdStr"),
          backgroundUrl: convertValueByType(jsonRes['backgroundUrl'], String,
              stack: "VideoCreator-backgroundUrl"),
          birthday: convertValueByType(jsonRes['birthday'], int,
              stack: "VideoCreator-birthday"),
          city: convertValueByType(jsonRes['city'], int,
              stack: "VideoCreator-city"),
          defaultAvatar: convertValueByType(jsonRes['defaultAvatar'], bool,
              stack: "VideoCreator-defaultAvatar"),
          description: convertValueByType(jsonRes['description'], String,
              stack: "VideoCreator-description"),
          detailDescription: convertValueByType(
              jsonRes['detailDescription'], String,
              stack: "VideoCreator-detailDescription"),
          djStatus: convertValueByType(jsonRes['djStatus'], int,
              stack: "VideoCreator-djStatus"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "VideoCreator-experts"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "VideoCreator-expertTags"),
          followed: convertValueByType(jsonRes['followed'], bool,
              stack: "VideoCreator-followed"),
          gender: convertValueByType(jsonRes['gender'], int,
              stack: "VideoCreator-gender"),
          mutual: convertValueByType(jsonRes['mutual'], bool,
              stack: "VideoCreator-mutual"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "VideoCreator-nickname"),
          province: convertValueByType(jsonRes['province'], int,
              stack: "VideoCreator-province"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "VideoCreator-remarkName"),
          signature: convertValueByType(jsonRes['signature'], String,
              stack: "VideoCreator-signature"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "VideoCreator-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "VideoCreator-userType"),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "VideoCreator-vipType"),
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

class Resolutions {
  int resolution;
  int size;

  Resolutions({
    this.resolution,
    this.size,
  });

  factory Resolutions.fromJson(jsonRes) => jsonRes == null
      ? null
      : Resolutions(
          resolution: convertValueByType(jsonRes['resolution'], int,
              stack: "Resolutions-resolution"),
          size: convertValueByType(jsonRes['size'], int,
              stack: "Resolutions-size"),
        );
  Map<String, dynamic> toJson() => {
        'resolution': resolution,
        'size': size,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
