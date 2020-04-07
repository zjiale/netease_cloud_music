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

class HomeRankModel {
  int code;
  List<RankList> list;
  ArtistToplist artistToplist;
  RewardToplist rewardToplist;

  HomeRankModel({
    this.code,
    this.list,
    this.artistToplist,
    this.rewardToplist,
  });

  factory HomeRankModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<RankList> list = jsonRes['list'] is List ? [] : null;
    if (list != null) {
      for (var item in jsonRes['list']) {
        if (item != null) {
          tryCatch(() {
            list.add(RankList.fromJson(item));
          });
        }
      }
    }

    return HomeRankModel(
      code:
          convertValueByType(jsonRes['code'], int, stack: "HomeRankModel-code"),
      list: list,
      artistToplist: ArtistToplist.fromJson(jsonRes['artistToplist']),
      rewardToplist: RewardToplist.fromJson(jsonRes['rewardToplist']),
    );
  }
  Map<String, dynamic> toJson() => {
        'code': code,
        'list': list,
        'artistToplist': artistToplist,
        'rewardToplist': rewardToplist,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class RankList {
  List<Object> subscribers;
  Object subscribed;
  Object creator;
  Object artists;
  List<Tracks> tracks;
  String updateFrequency;
  int backgroundCoverId;
  Object backgroundCoverUrl;
  int titleImage;
  Object titleImageUrl;
  Object englishTitle;
  bool opRecommend;
  Object recommendInfo;
  List<Object> tags;
  bool ordered;
  int userId;
  bool newImported;
  bool anonimous;
  int trackNumberUpdateTime;
  int trackUpdateTime;
  int playCount;
  int trackCount;
  int createTime;
  bool highQuality;
  int updateTime;
  int coverImgId;
  int specialType;
  String coverImgUrl;
  String commentThreadId;
  int totalDuration;
  int privacy;
  String description;
  int status;
  int subscribedCount;
  int cloudTrackCount;
  int adType;
  String name;
  int id;
  String coverImgId_str;
  String ToplistType;

  RankList({
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
    this.tags,
    this.ordered,
    this.userId,
    this.newImported,
    this.anonimous,
    this.trackNumberUpdateTime,
    this.trackUpdateTime,
    this.playCount,
    this.trackCount,
    this.createTime,
    this.highQuality,
    this.updateTime,
    this.coverImgId,
    this.specialType,
    this.coverImgUrl,
    this.commentThreadId,
    this.totalDuration,
    this.privacy,
    this.description,
    this.status,
    this.subscribedCount,
    this.cloudTrackCount,
    this.adType,
    this.name,
    this.id,
    this.coverImgId_str,
    this.ToplistType,
  });

  factory RankList.fromJson(jsonRes) {
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

    return RankList(
      subscribers: subscribers,
      subscribed: convertValueByType(jsonRes['subscribed'], Object,
          stack: "RankList-subscribed"),
      creator: convertValueByType(jsonRes['creator'], Object,
          stack: "RankList-creator"),
      artists: convertValueByType(jsonRes['artists'], Object,
          stack: "RankList-artists"),
      tracks: tracks,
      updateFrequency: convertValueByType(jsonRes['updateFrequency'], String,
          stack: "RankList-updateFrequency"),
      backgroundCoverId: convertValueByType(jsonRes['backgroundCoverId'], int,
          stack: "RankList-backgroundCoverId"),
      backgroundCoverUrl: convertValueByType(
          jsonRes['backgroundCoverUrl'], Object,
          stack: "RankList-backgroundCoverUrl"),
      titleImage: convertValueByType(jsonRes['titleImage'], int,
          stack: "RankList-titleImage"),
      titleImageUrl: convertValueByType(jsonRes['titleImageUrl'], Object,
          stack: "RankList-titleImageUrl"),
      englishTitle: convertValueByType(jsonRes['englishTitle'], Object,
          stack: "RankList-englishTitle"),
      opRecommend: convertValueByType(jsonRes['opRecommend'], bool,
          stack: "RankList-opRecommend"),
      recommendInfo: convertValueByType(jsonRes['recommendInfo'], Object,
          stack: "RankList-recommendInfo"),
      tags: tags,
      ordered: convertValueByType(jsonRes['ordered'], bool,
          stack: "RankList-ordered"),
      userId:
          convertValueByType(jsonRes['userId'], int, stack: "RankList-userId"),
      newImported: convertValueByType(jsonRes['newImported'], bool,
          stack: "RankList-newImported"),
      anonimous: convertValueByType(jsonRes['anonimous'], bool,
          stack: "RankList-anonimous"),
      trackNumberUpdateTime: convertValueByType(
          jsonRes['trackNumberUpdateTime'], int,
          stack: "RankList-trackNumberUpdateTime"),
      trackUpdateTime: convertValueByType(jsonRes['trackUpdateTime'], int,
          stack: "RankList-trackUpdateTime"),
      playCount: convertValueByType(jsonRes['playCount'], int,
          stack: "RankList-playCount"),
      trackCount: convertValueByType(jsonRes['trackCount'], int,
          stack: "RankList-trackCount"),
      createTime: convertValueByType(jsonRes['createTime'], int,
          stack: "RankList-createTime"),
      highQuality: convertValueByType(jsonRes['highQuality'], bool,
          stack: "RankList-highQuality"),
      updateTime: convertValueByType(jsonRes['updateTime'], int,
          stack: "RankList-updateTime"),
      coverImgId: convertValueByType(jsonRes['coverImgId'], int,
          stack: "RankList-coverImgId"),
      specialType: convertValueByType(jsonRes['specialType'], int,
          stack: "RankList-specialType"),
      coverImgUrl: convertValueByType(jsonRes['coverImgUrl'], String,
          stack: "RankList-coverImgUrl"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "RankList-commentThreadId"),
      totalDuration: convertValueByType(jsonRes['totalDuration'], int,
          stack: "RankList-totalDuration"),
      privacy: convertValueByType(jsonRes['privacy'], int,
          stack: "RankList-privacy"),
      description: convertValueByType(jsonRes['description'], String,
          stack: "RankList-description"),
      status:
          convertValueByType(jsonRes['status'], int, stack: "RankList-status"),
      subscribedCount: convertValueByType(jsonRes['subscribedCount'], int,
          stack: "RankList-subscribedCount"),
      cloudTrackCount: convertValueByType(jsonRes['cloudTrackCount'], int,
          stack: "RankList-cloudTrackCount"),
      adType:
          convertValueByType(jsonRes['adType'], int, stack: "RankList-adType"),
      name: convertValueByType(jsonRes['name'], String, stack: "RankList-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "RankList-id"),
      coverImgId_str: convertValueByType(jsonRes['coverImgId_str'], String,
          stack: "RankList-coverImgId_str"),
      ToplistType: convertValueByType(jsonRes['ToplistType'], String,
          stack: "RankList-ToplistType"),
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
        'tags': tags,
        'ordered': ordered,
        'userId': userId,
        'newImported': newImported,
        'anonimous': anonimous,
        'trackNumberUpdateTime': trackNumberUpdateTime,
        'trackUpdateTime': trackUpdateTime,
        'playCount': playCount,
        'trackCount': trackCount,
        'createTime': createTime,
        'highQuality': highQuality,
        'updateTime': updateTime,
        'coverImgId': coverImgId,
        'specialType': specialType,
        'coverImgUrl': coverImgUrl,
        'commentThreadId': commentThreadId,
        'totalDuration': totalDuration,
        'privacy': privacy,
        'description': description,
        'status': status,
        'subscribedCount': subscribedCount,
        'cloudTrackCount': cloudTrackCount,
        'adType': adType,
        'name': name,
        'id': id,
        'coverImgId_str': coverImgId_str,
        'ToplistType': ToplistType,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Tracks {
  String first;
  String second;

  Tracks({
    this.first,
    this.second,
  });

  factory Tracks.fromJson(jsonRes) => jsonRes == null
      ? null
      : Tracks(
          first: convertValueByType(jsonRes['first'], String,
              stack: "Tracks-first"),
          second: convertValueByType(jsonRes['second'], String,
              stack: "Tracks-second"),
        );
  Map<String, dynamic> toJson() => {
        'first': first,
        'second': second,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ArtistToplist {
  String coverUrl;
  List<Artists> artists;
  String name;
  String upateFrequency;
  int position;
  String updateFrequency;

  ArtistToplist({
    this.coverUrl,
    this.artists,
    this.name,
    this.upateFrequency,
    this.position,
    this.updateFrequency,
  });

  factory ArtistToplist.fromJson(jsonRes) {
    if (jsonRes == null) return null;
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

    return ArtistToplist(
      coverUrl: convertValueByType(jsonRes['coverUrl'], String,
          stack: "ArtistToplist-coverUrl"),
      artists: artists,
      name: convertValueByType(jsonRes['name'], String,
          stack: "ArtistToplist-name"),
      upateFrequency: convertValueByType(jsonRes['upateFrequency'], String,
          stack: "ArtistToplist-upateFrequency"),
      position: convertValueByType(jsonRes['position'], int,
          stack: "ArtistToplist-position"),
      updateFrequency: convertValueByType(jsonRes['updateFrequency'], String,
          stack: "ArtistToplist-updateFrequency"),
    );
  }
  Map<String, dynamic> toJson() => {
        'coverUrl': coverUrl,
        'artists': artists,
        'name': name,
        'upateFrequency': upateFrequency,
        'position': position,
        'updateFrequency': updateFrequency,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Artists {
  String first;
  String second;
  int third;

  Artists({
    this.first,
    this.second,
    this.third,
  });

  factory Artists.fromJson(jsonRes) => jsonRes == null
      ? null
      : Artists(
          first: convertValueByType(jsonRes['first'], String,
              stack: "Artists-first"),
          second: convertValueByType(jsonRes['second'], String,
              stack: "Artists-second"),
          third:
              convertValueByType(jsonRes['third'], int, stack: "Artists-third"),
        );
  Map<String, dynamic> toJson() => {
        'first': first,
        'second': second,
        'third': third,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class RewardToplist {
  String coverUrl;
  List<Songs> songs;
  String name;
  int position;

  RewardToplist({
    this.coverUrl,
    this.songs,
    this.name,
    this.position,
  });

  factory RewardToplist.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Songs> songs = jsonRes['songs'] is List ? [] : null;
    if (songs != null) {
      for (var item in jsonRes['songs']) {
        if (item != null) {
          tryCatch(() {
            songs.add(Songs.fromJson(item));
          });
        }
      }
    }

    return RewardToplist(
      coverUrl: convertValueByType(jsonRes['coverUrl'], String,
          stack: "RewardToplist-coverUrl"),
      songs: songs,
      name: convertValueByType(jsonRes['name'], String,
          stack: "RewardToplist-name"),
      position: convertValueByType(jsonRes['position'], int,
          stack: "RewardToplist-position"),
    );
  }
  Map<String, dynamic> toJson() => {
        'coverUrl': coverUrl,
        'songs': songs,
        'name': name,
        'position': position,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Songs {
  String name;
  int id;
  int position;
  List<Object> alias;
  int status;
  int fee;
  int copyrightId;
  String disc;
  int no;
  List<SongsArtists> artists;
  Album album;
  bool starred;
  int popularity;
  int score;
  int starredNum;
  int duration;
  int playedNum;
  int dayPlays;
  int hearTime;
  String ringtone;
  Object crbt;
  Object audition;
  String copyFrom;
  String commentThreadId;
  Object rtUrl;
  int ftype;
  List<Object> rtUrls;
  int copyright;
  Object transName;
  Object sign;
  int mark;
  HMusic hMusic;
  MMusic mMusic;
  LMusic lMusic;
  BMusic bMusic;
  int mvid;
  Object mp3Url;
  int rtype;
  Object rurl;

  Songs({
    this.name,
    this.id,
    this.position,
    this.alias,
    this.status,
    this.fee,
    this.copyrightId,
    this.disc,
    this.no,
    this.artists,
    this.album,
    this.starred,
    this.popularity,
    this.score,
    this.starredNum,
    this.duration,
    this.playedNum,
    this.dayPlays,
    this.hearTime,
    this.ringtone,
    this.crbt,
    this.audition,
    this.copyFrom,
    this.commentThreadId,
    this.rtUrl,
    this.ftype,
    this.rtUrls,
    this.copyright,
    this.transName,
    this.sign,
    this.mark,
    this.hMusic,
    this.mMusic,
    this.lMusic,
    this.bMusic,
    this.mvid,
    this.mp3Url,
    this.rtype,
    this.rurl,
  });

  factory Songs.fromJson(jsonRes) {
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

    List<SongsArtists> artists = jsonRes['artists'] is List ? [] : null;
    if (artists != null) {
      for (var item in jsonRes['artists']) {
        if (item != null) {
          tryCatch(() {
            artists.add(SongsArtists.fromJson(item));
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

    return Songs(
      name: convertValueByType(jsonRes['name'], String, stack: "Songs-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Songs-id"),
      position:
          convertValueByType(jsonRes['position'], int, stack: "Songs-position"),
      alias: alias,
      status: convertValueByType(jsonRes['status'], int, stack: "Songs-status"),
      fee: convertValueByType(jsonRes['fee'], int, stack: "Songs-fee"),
      copyrightId: convertValueByType(jsonRes['copyrightId'], int,
          stack: "Songs-copyrightId"),
      disc: convertValueByType(jsonRes['disc'], String, stack: "Songs-disc"),
      no: convertValueByType(jsonRes['no'], int, stack: "Songs-no"),
      artists: artists,
      album: Album.fromJson(jsonRes['album']),
      starred:
          convertValueByType(jsonRes['starred'], bool, stack: "Songs-starred"),
      popularity: convertValueByType(jsonRes['popularity'], int,
          stack: "Songs-popularity"),
      score: convertValueByType(jsonRes['score'], int, stack: "Songs-score"),
      starredNum: convertValueByType(jsonRes['starredNum'], int,
          stack: "Songs-starredNum"),
      duration:
          convertValueByType(jsonRes['duration'], int, stack: "Songs-duration"),
      playedNum: convertValueByType(jsonRes['playedNum'], int,
          stack: "Songs-playedNum"),
      dayPlays:
          convertValueByType(jsonRes['dayPlays'], int, stack: "Songs-dayPlays"),
      hearTime:
          convertValueByType(jsonRes['hearTime'], int, stack: "Songs-hearTime"),
      ringtone: convertValueByType(jsonRes['ringtone'], String,
          stack: "Songs-ringtone"),
      crbt: convertValueByType(jsonRes['crbt'], Object, stack: "Songs-crbt"),
      audition: convertValueByType(jsonRes['audition'], Object,
          stack: "Songs-audition"),
      copyFrom: convertValueByType(jsonRes['copyFrom'], String,
          stack: "Songs-copyFrom"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Songs-commentThreadId"),
      rtUrl: convertValueByType(jsonRes['rtUrl'], Object, stack: "Songs-rtUrl"),
      ftype: convertValueByType(jsonRes['ftype'], int, stack: "Songs-ftype"),
      rtUrls: rtUrls,
      copyright: convertValueByType(jsonRes['copyright'], int,
          stack: "Songs-copyright"),
      transName: convertValueByType(jsonRes['transName'], Object,
          stack: "Songs-transName"),
      sign: convertValueByType(jsonRes['sign'], Object, stack: "Songs-sign"),
      mark: convertValueByType(jsonRes['mark'], int, stack: "Songs-mark"),
      hMusic: HMusic.fromJson(jsonRes['hMusic']),
      mMusic: MMusic.fromJson(jsonRes['mMusic']),
      lMusic: LMusic.fromJson(jsonRes['lMusic']),
      bMusic: BMusic.fromJson(jsonRes['bMusic']),
      mvid: convertValueByType(jsonRes['mvid'], int, stack: "Songs-mvid"),
      mp3Url:
          convertValueByType(jsonRes['mp3Url'], Object, stack: "Songs-mp3Url"),
      rtype: convertValueByType(jsonRes['rtype'], int, stack: "Songs-rtype"),
      rurl: convertValueByType(jsonRes['rurl'], Object, stack: "Songs-rurl"),
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'position': position,
        'alias': alias,
        'status': status,
        'fee': fee,
        'copyrightId': copyrightId,
        'disc': disc,
        'no': no,
        'artists': artists,
        'album': album,
        'starred': starred,
        'popularity': popularity,
        'score': score,
        'starredNum': starredNum,
        'duration': duration,
        'playedNum': playedNum,
        'dayPlays': dayPlays,
        'hearTime': hearTime,
        'ringtone': ringtone,
        'crbt': crbt,
        'audition': audition,
        'copyFrom': copyFrom,
        'commentThreadId': commentThreadId,
        'rtUrl': rtUrl,
        'ftype': ftype,
        'rtUrls': rtUrls,
        'copyright': copyright,
        'transName': transName,
        'sign': sign,
        'mark': mark,
        'hMusic': hMusic,
        'mMusic': mMusic,
        'lMusic': lMusic,
        'bMusic': bMusic,
        'mvid': mvid,
        'mp3Url': mp3Url,
        'rtype': rtype,
        'rurl': rurl,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class SongsArtists {
  String name;
  int id;
  int picId;
  int img1v1Id;
  String briefDesc;
  String picUrl;
  String img1v1Url;
  int albumSize;
  List<Object> alias;
  String trans;
  int musicSize;
  int topicPerson;

  SongsArtists({
    this.name,
    this.id,
    this.picId,
    this.img1v1Id,
    this.briefDesc,
    this.picUrl,
    this.img1v1Url,
    this.albumSize,
    this.alias,
    this.trans,
    this.musicSize,
    this.topicPerson,
  });

  factory SongsArtists.fromJson(jsonRes) {
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

    return SongsArtists(
      name: convertValueByType(jsonRes['name'], String,
          stack: "SongsArtists-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "SongsArtists-id"),
      picId: convertValueByType(jsonRes['picId'], int,
          stack: "SongsArtists-picId"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "SongsArtists-img1v1Id"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "SongsArtists-briefDesc"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "SongsArtists-picUrl"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "SongsArtists-img1v1Url"),
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "SongsArtists-albumSize"),
      alias: alias,
      trans: convertValueByType(jsonRes['trans'], String,
          stack: "SongsArtists-trans"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "SongsArtists-musicSize"),
      topicPerson: convertValueByType(jsonRes['topicPerson'], int,
          stack: "SongsArtists-topicPerson"),
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'picId': picId,
        'img1v1Id': img1v1Id,
        'briefDesc': briefDesc,
        'picUrl': picUrl,
        'img1v1Url': img1v1Url,
        'albumSize': albumSize,
        'alias': alias,
        'trans': trans,
        'musicSize': musicSize,
        'topicPerson': topicPerson,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Album {
  String name;
  int id;
  String type;
  int size;
  int picId;
  String blurPicUrl;
  int companyId;
  int pic;
  String picUrl;
  int publishTime;
  String description;
  String tags;
  Object company;
  String briefDesc;
  Artist artist;
  List<Object> songs;
  List<Object> alias;
  int status;
  int copyrightId;
  String commentThreadId;
  List<AlbumArtists> artists;
  String subType;
  Object transName;
  int mark;
  String picId_str;

  Album({
    this.name,
    this.id,
    this.type,
    this.size,
    this.picId,
    this.blurPicUrl,
    this.companyId,
    this.pic,
    this.picUrl,
    this.publishTime,
    this.description,
    this.tags,
    this.company,
    this.briefDesc,
    this.artist,
    this.songs,
    this.alias,
    this.status,
    this.copyrightId,
    this.commentThreadId,
    this.artists,
    this.subType,
    this.transName,
    this.mark,
    this.picId_str,
  });

  factory Album.fromJson(jsonRes) {
    if (jsonRes == null) return null;
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

    return Album(
      name: convertValueByType(jsonRes['name'], String, stack: "Album-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Album-id"),
      type: convertValueByType(jsonRes['type'], String, stack: "Album-type"),
      size: convertValueByType(jsonRes['size'], int, stack: "Album-size"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Album-picId"),
      blurPicUrl: convertValueByType(jsonRes['blurPicUrl'], String,
          stack: "Album-blurPicUrl"),
      companyId: convertValueByType(jsonRes['companyId'], int,
          stack: "Album-companyId"),
      pic: convertValueByType(jsonRes['pic'], int, stack: "Album-pic"),
      picUrl:
          convertValueByType(jsonRes['picUrl'], String, stack: "Album-picUrl"),
      publishTime: convertValueByType(jsonRes['publishTime'], int,
          stack: "Album-publishTime"),
      description: convertValueByType(jsonRes['description'], String,
          stack: "Album-description"),
      tags: convertValueByType(jsonRes['tags'], String, stack: "Album-tags"),
      company: convertValueByType(jsonRes['company'], Object,
          stack: "Album-company"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "Album-briefDesc"),
      artist: Artist.fromJson(jsonRes['artist']),
      songs: songs,
      alias: alias,
      status: convertValueByType(jsonRes['status'], int, stack: "Album-status"),
      copyrightId: convertValueByType(jsonRes['copyrightId'], int,
          stack: "Album-copyrightId"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Album-commentThreadId"),
      artists: artists,
      subType: convertValueByType(jsonRes['subType'], String,
          stack: "Album-subType"),
      transName: convertValueByType(jsonRes['transName'], Object,
          stack: "Album-transName"),
      mark: convertValueByType(jsonRes['mark'], int, stack: "Album-mark"),
      picId_str: convertValueByType(jsonRes['picId_str'], String,
          stack: "Album-picId_str"),
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'type': type,
        'size': size,
        'picId': picId,
        'blurPicUrl': blurPicUrl,
        'companyId': companyId,
        'pic': pic,
        'picUrl': picUrl,
        'publishTime': publishTime,
        'description': description,
        'tags': tags,
        'company': company,
        'briefDesc': briefDesc,
        'artist': artist,
        'songs': songs,
        'alias': alias,
        'status': status,
        'copyrightId': copyrightId,
        'commentThreadId': commentThreadId,
        'artists': artists,
        'subType': subType,
        'transName': transName,
        'mark': mark,
        'picId_str': picId_str,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Artist {
  String name;
  int id;
  int picId;
  int img1v1Id;
  String briefDesc;
  String picUrl;
  String img1v1Url;
  int albumSize;
  List<Object> alias;
  String trans;
  int musicSize;
  int topicPerson;

  Artist({
    this.name,
    this.id,
    this.picId,
    this.img1v1Id,
    this.briefDesc,
    this.picUrl,
    this.img1v1Url,
    this.albumSize,
    this.alias,
    this.trans,
    this.musicSize,
    this.topicPerson,
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
      name: convertValueByType(jsonRes['name'], String, stack: "Artist-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Artist-id"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Artist-picId"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "Artist-img1v1Id"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "Artist-briefDesc"),
      picUrl:
          convertValueByType(jsonRes['picUrl'], String, stack: "Artist-picUrl"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "Artist-img1v1Url"),
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "Artist-albumSize"),
      alias: alias,
      trans:
          convertValueByType(jsonRes['trans'], String, stack: "Artist-trans"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "Artist-musicSize"),
      topicPerson: convertValueByType(jsonRes['topicPerson'], int,
          stack: "Artist-topicPerson"),
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'picId': picId,
        'img1v1Id': img1v1Id,
        'briefDesc': briefDesc,
        'picUrl': picUrl,
        'img1v1Url': img1v1Url,
        'albumSize': albumSize,
        'alias': alias,
        'trans': trans,
        'musicSize': musicSize,
        'topicPerson': topicPerson,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class AlbumArtists {
  String name;
  int id;
  int picId;
  int img1v1Id;
  String briefDesc;
  String picUrl;
  String img1v1Url;
  int albumSize;
  List<Object> alias;
  String trans;
  int musicSize;
  int topicPerson;

  AlbumArtists({
    this.name,
    this.id,
    this.picId,
    this.img1v1Id,
    this.briefDesc,
    this.picUrl,
    this.img1v1Url,
    this.albumSize,
    this.alias,
    this.trans,
    this.musicSize,
    this.topicPerson,
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
      name: convertValueByType(jsonRes['name'], String,
          stack: "AlbumArtists-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "AlbumArtists-id"),
      picId: convertValueByType(jsonRes['picId'], int,
          stack: "AlbumArtists-picId"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "AlbumArtists-img1v1Id"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "AlbumArtists-briefDesc"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "AlbumArtists-picUrl"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "AlbumArtists-img1v1Url"),
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "AlbumArtists-albumSize"),
      alias: alias,
      trans: convertValueByType(jsonRes['trans'], String,
          stack: "AlbumArtists-trans"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "AlbumArtists-musicSize"),
      topicPerson: convertValueByType(jsonRes['topicPerson'], int,
          stack: "AlbumArtists-topicPerson"),
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'picId': picId,
        'img1v1Id': img1v1Id,
        'briefDesc': briefDesc,
        'picUrl': picUrl,
        'img1v1Url': img1v1Url,
        'albumSize': albumSize,
        'alias': alias,
        'trans': trans,
        'musicSize': musicSize,
        'topicPerson': topicPerson,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class HMusic {
  Object name;
  int id;
  int size;
  String extension;
  int sr;
  int dfsId;
  int bitrate;
  int playTime;
  int volumeDelta;

  HMusic({
    this.name,
    this.id,
    this.size,
    this.extension,
    this.sr,
    this.dfsId,
    this.bitrate,
    this.playTime,
    this.volumeDelta,
  });

  factory HMusic.fromJson(jsonRes) => jsonRes == null
      ? null
      : HMusic(
          name:
              convertValueByType(jsonRes['name'], Object, stack: "HMusic-name"),
          id: convertValueByType(jsonRes['id'], int, stack: "HMusic-id"),
          size: convertValueByType(jsonRes['size'], int, stack: "HMusic-size"),
          extension: convertValueByType(jsonRes['extension'], String,
              stack: "HMusic-extension"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "HMusic-sr"),
          dfsId:
              convertValueByType(jsonRes['dfsId'], int, stack: "HMusic-dfsId"),
          bitrate: convertValueByType(jsonRes['bitrate'], int,
              stack: "HMusic-bitrate"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "HMusic-playTime"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], int,
              stack: "HMusic-volumeDelta"),
        );
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'size': size,
        'extension': extension,
        'sr': sr,
        'dfsId': dfsId,
        'bitrate': bitrate,
        'playTime': playTime,
        'volumeDelta': volumeDelta,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class MMusic {
  Object name;
  int id;
  int size;
  String extension;
  int sr;
  int dfsId;
  int bitrate;
  int playTime;
  int volumeDelta;

  MMusic({
    this.name,
    this.id,
    this.size,
    this.extension,
    this.sr,
    this.dfsId,
    this.bitrate,
    this.playTime,
    this.volumeDelta,
  });

  factory MMusic.fromJson(jsonRes) => jsonRes == null
      ? null
      : MMusic(
          name:
              convertValueByType(jsonRes['name'], Object, stack: "MMusic-name"),
          id: convertValueByType(jsonRes['id'], int, stack: "MMusic-id"),
          size: convertValueByType(jsonRes['size'], int, stack: "MMusic-size"),
          extension: convertValueByType(jsonRes['extension'], String,
              stack: "MMusic-extension"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "MMusic-sr"),
          dfsId:
              convertValueByType(jsonRes['dfsId'], int, stack: "MMusic-dfsId"),
          bitrate: convertValueByType(jsonRes['bitrate'], int,
              stack: "MMusic-bitrate"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "MMusic-playTime"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], int,
              stack: "MMusic-volumeDelta"),
        );
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'size': size,
        'extension': extension,
        'sr': sr,
        'dfsId': dfsId,
        'bitrate': bitrate,
        'playTime': playTime,
        'volumeDelta': volumeDelta,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class LMusic {
  Object name;
  int id;
  int size;
  String extension;
  int sr;
  int dfsId;
  int bitrate;
  int playTime;
  int volumeDelta;

  LMusic({
    this.name,
    this.id,
    this.size,
    this.extension,
    this.sr,
    this.dfsId,
    this.bitrate,
    this.playTime,
    this.volumeDelta,
  });

  factory LMusic.fromJson(jsonRes) => jsonRes == null
      ? null
      : LMusic(
          name:
              convertValueByType(jsonRes['name'], Object, stack: "LMusic-name"),
          id: convertValueByType(jsonRes['id'], int, stack: "LMusic-id"),
          size: convertValueByType(jsonRes['size'], int, stack: "LMusic-size"),
          extension: convertValueByType(jsonRes['extension'], String,
              stack: "LMusic-extension"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "LMusic-sr"),
          dfsId:
              convertValueByType(jsonRes['dfsId'], int, stack: "LMusic-dfsId"),
          bitrate: convertValueByType(jsonRes['bitrate'], int,
              stack: "LMusic-bitrate"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "LMusic-playTime"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], int,
              stack: "LMusic-volumeDelta"),
        );
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'size': size,
        'extension': extension,
        'sr': sr,
        'dfsId': dfsId,
        'bitrate': bitrate,
        'playTime': playTime,
        'volumeDelta': volumeDelta,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class BMusic {
  Object name;
  int id;
  int size;
  String extension;
  int sr;
  int dfsId;
  int bitrate;
  int playTime;
  int volumeDelta;

  BMusic({
    this.name,
    this.id,
    this.size,
    this.extension,
    this.sr,
    this.dfsId,
    this.bitrate,
    this.playTime,
    this.volumeDelta,
  });

  factory BMusic.fromJson(jsonRes) => jsonRes == null
      ? null
      : BMusic(
          name:
              convertValueByType(jsonRes['name'], Object, stack: "BMusic-name"),
          id: convertValueByType(jsonRes['id'], int, stack: "BMusic-id"),
          size: convertValueByType(jsonRes['size'], int, stack: "BMusic-size"),
          extension: convertValueByType(jsonRes['extension'], String,
              stack: "BMusic-extension"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "BMusic-sr"),
          dfsId:
              convertValueByType(jsonRes['dfsId'], int, stack: "BMusic-dfsId"),
          bitrate: convertValueByType(jsonRes['bitrate'], int,
              stack: "BMusic-bitrate"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "BMusic-playTime"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], int,
              stack: "BMusic-volumeDelta"),
        );
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'size': size,
        'extension': extension,
        'sr': sr,
        'dfsId': dfsId,
        'bitrate': bitrate,
        'playTime': playTime,
        'volumeDelta': volumeDelta,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
