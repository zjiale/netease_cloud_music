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

class PlayListDetailModel {
  int code;
  Object relatedVideos;
  Playlist playlist;
  Object urls;
  List<Privileges> privileges;

  PlayListDetailModel({
    this.code,
    this.relatedVideos,
    this.playlist,
    this.urls,
    this.privileges,
  });

  factory PlayListDetailModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Privileges> privileges = jsonRes['privileges'] is List ? [] : null;
    if (privileges != null) {
      for (var item in jsonRes['privileges']) {
        if (item != null) {
          tryCatch(() {
            privileges.add(Privileges.fromJson(item));
          });
        }
      }
    }

    return PlayListDetailModel(
      code: convertValueByType(jsonRes['code'], int,
          stack: "PlayListDetailModel-code"),
      relatedVideos: convertValueByType(jsonRes['relatedVideos'], Object,
          stack: "PlayListDetailModel-relatedVideos"),
      playlist: Playlist.fromJson(jsonRes['playlist']),
      urls: convertValueByType(jsonRes['urls'], Object,
          stack: "PlayListDetailModel-urls"),
      privileges: privileges,
    );
  }
  Map<String, dynamic> toJson() => {
        'code': code,
        'relatedVideos': relatedVideos,
        'playlist': playlist,
        'urls': urls,
        'privileges': privileges,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Playlist {
  List<Subscribers> subscribers;
  bool subscribed;
  Creator creator;
  List<Tracks> tracks;
  List<TrackIds> trackIds;
  Object updateFrequency;
  int backgroundCoverId;
  Object backgroundCoverUrl;
  int titleImage;
  Object titleImageUrl;
  Object englishTitle;
  bool opRecommend;
  String description;
  bool ordered;
  List<String> tags;
  String coverImgUrl;
  int updateTime;
  String commentThreadId;
  int specialType;
  int subscribedCount;
  int cloudTrackCount;
  int createTime;
  bool highQuality;
  int trackCount;
  int userId;
  int privacy;
  int trackUpdateTime;
  int adType;
  int trackNumberUpdateTime;
  int coverImgId;
  bool newImported;
  int status;
  int playCount;
  String name;
  int id;
  int shareCount;
  String coverImgId_str;
  int commentCount;

  Playlist({
    this.subscribers,
    this.subscribed,
    this.creator,
    this.tracks,
    this.trackIds,
    this.updateFrequency,
    this.backgroundCoverId,
    this.backgroundCoverUrl,
    this.titleImage,
    this.titleImageUrl,
    this.englishTitle,
    this.opRecommend,
    this.description,
    this.ordered,
    this.tags,
    this.coverImgUrl,
    this.updateTime,
    this.commentThreadId,
    this.specialType,
    this.subscribedCount,
    this.cloudTrackCount,
    this.createTime,
    this.highQuality,
    this.trackCount,
    this.userId,
    this.privacy,
    this.trackUpdateTime,
    this.adType,
    this.trackNumberUpdateTime,
    this.coverImgId,
    this.newImported,
    this.status,
    this.playCount,
    this.name,
    this.id,
    this.shareCount,
    this.coverImgId_str,
    this.commentCount,
  });

  factory Playlist.fromJson(jsonRes) {
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

    List<Tracks> tracks = jsonRes['tracks'] is List ? [] : null;
    if (tracks != null) {
      for (var item in jsonRes['tracks']) {
        if (item != null) {
          tryCatch(() {
            tracks.add(Tracks.fromJson(item));
          });
        }
      }
    }

    List<TrackIds> trackIds = jsonRes['trackIds'] is List ? [] : null;
    if (trackIds != null) {
      for (var item in jsonRes['trackIds']) {
        if (item != null) {
          tryCatch(() {
            trackIds.add(TrackIds.fromJson(item));
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
      subscribers: subscribers,
      subscribed: convertValueByType(jsonRes['subscribed'], bool,
          stack: "Playlist-subscribed"),
      creator: Creator.fromJson(jsonRes['creator']),
      tracks: tracks,
      trackIds: trackIds,
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
      description: convertValueByType(jsonRes['description'], String,
          stack: "Playlist-description"),
      ordered: convertValueByType(jsonRes['ordered'], bool,
          stack: "Playlist-ordered"),
      tags: tags,
      coverImgUrl: convertValueByType(jsonRes['coverImgUrl'], String,
          stack: "Playlist-coverImgUrl"),
      updateTime: convertValueByType(jsonRes['updateTime'], int,
          stack: "Playlist-updateTime"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Playlist-commentThreadId"),
      specialType: convertValueByType(jsonRes['specialType'], int,
          stack: "Playlist-specialType"),
      subscribedCount: convertValueByType(jsonRes['subscribedCount'], int,
          stack: "Playlist-subscribedCount"),
      cloudTrackCount: convertValueByType(jsonRes['cloudTrackCount'], int,
          stack: "Playlist-cloudTrackCount"),
      createTime: convertValueByType(jsonRes['createTime'], int,
          stack: "Playlist-createTime"),
      highQuality: convertValueByType(jsonRes['highQuality'], bool,
          stack: "Playlist-highQuality"),
      trackCount: convertValueByType(jsonRes['trackCount'], int,
          stack: "Playlist-trackCount"),
      userId:
          convertValueByType(jsonRes['userId'], int, stack: "Playlist-userId"),
      privacy: convertValueByType(jsonRes['privacy'], int,
          stack: "Playlist-privacy"),
      trackUpdateTime: convertValueByType(jsonRes['trackUpdateTime'], int,
          stack: "Playlist-trackUpdateTime"),
      adType:
          convertValueByType(jsonRes['adType'], int, stack: "Playlist-adType"),
      trackNumberUpdateTime: convertValueByType(
          jsonRes['trackNumberUpdateTime'], int,
          stack: "Playlist-trackNumberUpdateTime"),
      coverImgId: convertValueByType(jsonRes['coverImgId'], int,
          stack: "Playlist-coverImgId"),
      newImported: convertValueByType(jsonRes['newImported'], bool,
          stack: "Playlist-newImported"),
      status:
          convertValueByType(jsonRes['status'], int, stack: "Playlist-status"),
      playCount: convertValueByType(jsonRes['playCount'], int,
          stack: "Playlist-playCount"),
      name: convertValueByType(jsonRes['name'], String, stack: "Playlist-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Playlist-id"),
      shareCount: convertValueByType(jsonRes['shareCount'], int,
          stack: "Playlist-shareCount"),
      coverImgId_str: convertValueByType(jsonRes['coverImgId_str'], String,
          stack: "Playlist-coverImgId_str"),
      commentCount: convertValueByType(jsonRes['commentCount'], int,
          stack: "Playlist-commentCount"),
    );
  }
  Map<String, dynamic> toJson() => {
        'subscribers': subscribers,
        'subscribed': subscribed,
        'creator': creator,
        'tracks': tracks,
        'trackIds': trackIds,
        'updateFrequency': updateFrequency,
        'backgroundCoverId': backgroundCoverId,
        'backgroundCoverUrl': backgroundCoverUrl,
        'titleImage': titleImage,
        'titleImageUrl': titleImageUrl,
        'englishTitle': englishTitle,
        'opRecommend': opRecommend,
        'description': description,
        'ordered': ordered,
        'tags': tags,
        'coverImgUrl': coverImgUrl,
        'updateTime': updateTime,
        'commentThreadId': commentThreadId,
        'specialType': specialType,
        'subscribedCount': subscribedCount,
        'cloudTrackCount': cloudTrackCount,
        'createTime': createTime,
        'highQuality': highQuality,
        'trackCount': trackCount,
        'userId': userId,
        'privacy': privacy,
        'trackUpdateTime': trackUpdateTime,
        'adType': adType,
        'trackNumberUpdateTime': trackNumberUpdateTime,
        'coverImgId': coverImgId,
        'newImported': newImported,
        'status': status,
        'playCount': playCount,
        'name': name,
        'id': id,
        'shareCount': shareCount,
        'coverImgId_str': coverImgId_str,
        'commentCount': commentCount,
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
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Tracks {
  String name;
  int id;
  int pst;
  int t;
  List<Ar> ar;
  List<Object> alia;
  int pop;
  int st;
  String rt;
  int fee;
  int v;
  Object crbt;
  String cf;
  Al al;
  int dt;
  H h;
  M m;
  L l;
  Object a;
  String cd;
  int no;
  Object rtUrl;
  int ftype;
  List<Object> rtUrls;
  int djId;
  int copyright;
  int s_id;
  int mark;
  int rtype;
  Object rurl;
  int mst;
  int cp;
  int mv;
  int publishTime;
  List<String> tns;

  Tracks({
    this.name,
    this.id,
    this.pst,
    this.t,
    this.ar,
    this.alia,
    this.pop,
    this.st,
    this.rt,
    this.fee,
    this.v,
    this.crbt,
    this.cf,
    this.al,
    this.dt,
    this.h,
    this.m,
    this.l,
    this.a,
    this.cd,
    this.no,
    this.rtUrl,
    this.ftype,
    this.rtUrls,
    this.djId,
    this.copyright,
    this.s_id,
    this.mark,
    this.rtype,
    this.rurl,
    this.mst,
    this.cp,
    this.mv,
    this.publishTime,
    this.tns,
  });

  factory Tracks.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Ar> ar = jsonRes['ar'] is List ? [] : null;
    if (ar != null) {
      for (var item in jsonRes['ar']) {
        if (item != null) {
          tryCatch(() {
            ar.add(Ar.fromJson(item));
          });
        }
      }
    }

    List<Object> alia = jsonRes['alia'] is List ? [] : null;
    if (alia != null) {
      for (var item in jsonRes['alia']) {
        if (item != null) {
          tryCatch(() {
            alia.add(item);
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

    List<String> tns = jsonRes['tns'] is List ? [] : null;
    if (tns != null) {
      for (var item in jsonRes['tns']) {
        if (item != null) {
          tryCatch(() {
            tns.add(item);
          });
        }
      }
    }

    return Tracks(
      name: convertValueByType(jsonRes['name'], String, stack: "Tracks-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Tracks-id"),
      pst: convertValueByType(jsonRes['pst'], int, stack: "Tracks-pst"),
      t: convertValueByType(jsonRes['t'], int, stack: "Tracks-t"),
      ar: ar,
      alia: alia,
      pop: convertValueByType(jsonRes['pop'], int, stack: "Tracks-pop"),
      st: convertValueByType(jsonRes['st'], int, stack: "Tracks-st"),
      rt: convertValueByType(jsonRes['rt'], String, stack: "Tracks-rt"),
      fee: convertValueByType(jsonRes['fee'], int, stack: "Tracks-fee"),
      v: convertValueByType(jsonRes['v'], int, stack: "Tracks-v"),
      crbt: convertValueByType(jsonRes['crbt'], Object, stack: "Tracks-crbt"),
      cf: convertValueByType(jsonRes['cf'], String, stack: "Tracks-cf"),
      al: Al.fromJson(jsonRes['al']),
      dt: convertValueByType(jsonRes['dt'], int, stack: "Tracks-dt"),
      h: H.fromJson(jsonRes['h']),
      m: M.fromJson(jsonRes['m']),
      l: L.fromJson(jsonRes['l']),
      a: convertValueByType(jsonRes['a'], Object, stack: "Tracks-a"),
      cd: convertValueByType(jsonRes['cd'], String, stack: "Tracks-cd"),
      no: convertValueByType(jsonRes['no'], int, stack: "Tracks-no"),
      rtUrl:
          convertValueByType(jsonRes['rtUrl'], Object, stack: "Tracks-rtUrl"),
      ftype: convertValueByType(jsonRes['ftype'], int, stack: "Tracks-ftype"),
      rtUrls: rtUrls,
      djId: convertValueByType(jsonRes['djId'], int, stack: "Tracks-djId"),
      copyright: convertValueByType(jsonRes['copyright'], int,
          stack: "Tracks-copyright"),
      s_id: convertValueByType(jsonRes['s_id'], int, stack: "Tracks-s_id"),
      mark: convertValueByType(jsonRes['mark'], int, stack: "Tracks-mark"),
      rtype: convertValueByType(jsonRes['rtype'], int, stack: "Tracks-rtype"),
      rurl: convertValueByType(jsonRes['rurl'], Object, stack: "Tracks-rurl"),
      mst: convertValueByType(jsonRes['mst'], int, stack: "Tracks-mst"),
      cp: convertValueByType(jsonRes['cp'], int, stack: "Tracks-cp"),
      mv: convertValueByType(jsonRes['mv'], int, stack: "Tracks-mv"),
      publishTime: convertValueByType(jsonRes['publishTime'], int,
          stack: "Tracks-publishTime"),
      tns: tns,
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'pst': pst,
        't': t,
        'ar': ar,
        'alia': alia,
        'pop': pop,
        'st': st,
        'rt': rt,
        'fee': fee,
        'v': v,
        'crbt': crbt,
        'cf': cf,
        'al': al,
        'dt': dt,
        'h': h,
        'm': m,
        'l': l,
        'a': a,
        'cd': cd,
        'no': no,
        'rtUrl': rtUrl,
        'ftype': ftype,
        'rtUrls': rtUrls,
        'djId': djId,
        'copyright': copyright,
        's_id': s_id,
        'mark': mark,
        'rtype': rtype,
        'rurl': rurl,
        'mst': mst,
        'cp': cp,
        'mv': mv,
        'publishTime': publishTime,
        'tns': tns,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Ar {
  int id;
  String name;
  List<Object> tns;
  List<Object> alias;

  Ar({
    this.id,
    this.name,
    this.tns,
    this.alias,
  });

  factory Ar.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Object> tns = jsonRes['tns'] is List ? [] : null;
    if (tns != null) {
      for (var item in jsonRes['tns']) {
        if (item != null) {
          tryCatch(() {
            tns.add(item);
          });
        }
      }
    }

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

    return Ar(
      id: convertValueByType(jsonRes['id'], int, stack: "Ar-id"),
      name: convertValueByType(jsonRes['name'], String, stack: "Ar-name"),
      tns: tns,
      alias: alias,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tns': tns,
        'alias': alias,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Al {
  int id;
  String name;
  String picUrl;
  List<Object> tns;
  String pic_str;
  int pic;

  Al({
    this.id,
    this.name,
    this.picUrl,
    this.tns,
    this.pic_str,
    this.pic,
  });

  factory Al.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Object> tns = jsonRes['tns'] is List ? [] : null;
    if (tns != null) {
      for (var item in jsonRes['tns']) {
        if (item != null) {
          tryCatch(() {
            tns.add(item);
          });
        }
      }
    }

    return Al(
      id: convertValueByType(jsonRes['id'], int, stack: "Al-id"),
      name: convertValueByType(jsonRes['name'], String, stack: "Al-name"),
      picUrl: convertValueByType(jsonRes['picUrl'], String, stack: "Al-picUrl"),
      tns: tns,
      pic_str:
          convertValueByType(jsonRes['pic_str'], String, stack: "Al-pic_str"),
      pic: convertValueByType(jsonRes['pic'], int, stack: "Al-pic"),
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'picUrl': picUrl,
        'tns': tns,
        'pic_str': pic_str,
        'pic': pic,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class H {
  int br;
  int fid;
  int size;
  int vd;

  H({
    this.br,
    this.fid,
    this.size,
    this.vd,
  });

  factory H.fromJson(jsonRes) => jsonRes == null
      ? null
      : H(
          br: convertValueByType(jsonRes['br'], int, stack: "H-br"),
          fid: convertValueByType(jsonRes['fid'], int, stack: "H-fid"),
          size: convertValueByType(jsonRes['size'], int, stack: "H-size"),
          vd: convertValueByType(jsonRes['vd'], int, stack: "H-vd"),
        );
  Map<String, dynamic> toJson() => {
        'br': br,
        'fid': fid,
        'size': size,
        'vd': vd,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class M {
  int br;
  int fid;
  int size;
  int vd;

  M({
    this.br,
    this.fid,
    this.size,
    this.vd,
  });

  factory M.fromJson(jsonRes) => jsonRes == null
      ? null
      : M(
          br: convertValueByType(jsonRes['br'], int, stack: "M-br"),
          fid: convertValueByType(jsonRes['fid'], int, stack: "M-fid"),
          size: convertValueByType(jsonRes['size'], int, stack: "M-size"),
          vd: convertValueByType(jsonRes['vd'], int, stack: "M-vd"),
        );
  Map<String, dynamic> toJson() => {
        'br': br,
        'fid': fid,
        'size': size,
        'vd': vd,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class L {
  int br;
  int fid;
  int size;
  int vd;

  L({
    this.br,
    this.fid,
    this.size,
    this.vd,
  });

  factory L.fromJson(jsonRes) => jsonRes == null
      ? null
      : L(
          br: convertValueByType(jsonRes['br'], int, stack: "L-br"),
          fid: convertValueByType(jsonRes['fid'], int, stack: "L-fid"),
          size: convertValueByType(jsonRes['size'], int, stack: "L-size"),
          vd: convertValueByType(jsonRes['vd'], int, stack: "L-vd"),
        );
  Map<String, dynamic> toJson() => {
        'br': br,
        'fid': fid,
        'size': size,
        'vd': vd,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TrackIds {
  int id;
  int v;
  Object alg;

  TrackIds({
    this.id,
    this.v,
    this.alg,
  });

  factory TrackIds.fromJson(jsonRes) => jsonRes == null
      ? null
      : TrackIds(
          id: convertValueByType(jsonRes['id'], int, stack: "TrackIds-id"),
          v: convertValueByType(jsonRes['v'], int, stack: "TrackIds-v"),
          alg:
              convertValueByType(jsonRes['alg'], Object, stack: "TrackIds-alg"),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'v': v,
        'alg': alg,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Privileges {
  int id;
  int fee;
  int payed;
  int st;
  int pl;
  int dl;
  int sp;
  int cp;
  int subp;
  bool cs;
  int maxbr;
  int fl;
  bool toast;
  int flag;
  bool preSell;

  Privileges({
    this.id,
    this.fee,
    this.payed,
    this.st,
    this.pl,
    this.dl,
    this.sp,
    this.cp,
    this.subp,
    this.cs,
    this.maxbr,
    this.fl,
    this.toast,
    this.flag,
    this.preSell,
  });

  factory Privileges.fromJson(jsonRes) => jsonRes == null
      ? null
      : Privileges(
          id: convertValueByType(jsonRes['id'], int, stack: "Privileges-id"),
          fee: convertValueByType(jsonRes['fee'], int, stack: "Privileges-fee"),
          payed: convertValueByType(jsonRes['payed'], int,
              stack: "Privileges-payed"),
          st: convertValueByType(jsonRes['st'], int, stack: "Privileges-st"),
          pl: convertValueByType(jsonRes['pl'], int, stack: "Privileges-pl"),
          dl: convertValueByType(jsonRes['dl'], int, stack: "Privileges-dl"),
          sp: convertValueByType(jsonRes['sp'], int, stack: "Privileges-sp"),
          cp: convertValueByType(jsonRes['cp'], int, stack: "Privileges-cp"),
          subp: convertValueByType(jsonRes['subp'], int,
              stack: "Privileges-subp"),
          cs: convertValueByType(jsonRes['cs'], bool, stack: "Privileges-cs"),
          maxbr: convertValueByType(jsonRes['maxbr'], int,
              stack: "Privileges-maxbr"),
          fl: convertValueByType(jsonRes['fl'], int, stack: "Privileges-fl"),
          toast: convertValueByType(jsonRes['toast'], bool,
              stack: "Privileges-toast"),
          flag: convertValueByType(jsonRes['flag'], int,
              stack: "Privileges-flag"),
          preSell: convertValueByType(jsonRes['preSell'], bool,
              stack: "Privileges-preSell"),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'fee': fee,
        'payed': payed,
        'st': st,
        'pl': pl,
        'dl': dl,
        'sp': sp,
        'cp': cp,
        'subp': subp,
        'cs': cs,
        'maxbr': maxbr,
        'fl': fl,
        'toast': toast,
        'flag': flag,
        'preSell': preSell,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
