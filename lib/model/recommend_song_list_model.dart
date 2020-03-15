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

class RecommendSongListModel {
  int code;
  List<Recommend> recommend;
  Data data;

  RecommendSongListModel({
    this.code,
    this.recommend,
    this.data,
  });

  factory RecommendSongListModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Recommend> recommend = jsonRes['recommend'] is List ? [] : null;
    if (recommend != null) {
      for (var item in jsonRes['recommend']) {
        if (item != null) {
          tryCatch(() {
            recommend.add(Recommend.fromJson(item));
          });
        }
      }
    }

    return RecommendSongListModel(
      code: convertValueByType(jsonRes['code'], int,
          stack: "RecommendSongListModel-code"),
      recommend: recommend,
      data: Data.fromJson(jsonRes['data']),
    );
  }
  Map<String, dynamic> toJson() => {
        'code': code,
        'recommend': recommend,
        'data': data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Recommend {
  String name;
  int id;
  int position;
  List<Object> alias;
  int status;
  int fee;
  int copyrightId;
  String disc;
  int no;
  List<Artists> artists;
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
  int mvid;
  BMusic bMusic;
  Object mp3Url;
  int rtype;
  Object rurl;
  HMusic hMusic;
  MMusic mMusic;
  LMusic lMusic;
  String reason;
  Privilege privilege;
  String alg;

  Recommend({
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
    this.mvid,
    this.bMusic,
    this.mp3Url,
    this.rtype,
    this.rurl,
    this.hMusic,
    this.mMusic,
    this.lMusic,
    this.reason,
    this.privilege,
    this.alg,
  });

  factory Recommend.fromJson(jsonRes) {
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

    return Recommend(
      name:
          convertValueByType(jsonRes['name'], String, stack: "Recommend-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Recommend-id"),
      position: convertValueByType(jsonRes['position'], int,
          stack: "Recommend-position"),
      alias: alias,
      status:
          convertValueByType(jsonRes['status'], int, stack: "Recommend-status"),
      fee: convertValueByType(jsonRes['fee'], int, stack: "Recommend-fee"),
      copyrightId: convertValueByType(jsonRes['copyrightId'], int,
          stack: "Recommend-copyrightId"),
      disc:
          convertValueByType(jsonRes['disc'], String, stack: "Recommend-disc"),
      no: convertValueByType(jsonRes['no'], int, stack: "Recommend-no"),
      artists: artists,
      album: Album.fromJson(jsonRes['album']),
      starred: convertValueByType(jsonRes['starred'], bool,
          stack: "Recommend-starred"),
      popularity: convertValueByType(jsonRes['popularity'], int,
          stack: "Recommend-popularity"),
      score:
          convertValueByType(jsonRes['score'], int, stack: "Recommend-score"),
      starredNum: convertValueByType(jsonRes['starredNum'], int,
          stack: "Recommend-starredNum"),
      duration: convertValueByType(jsonRes['duration'], int,
          stack: "Recommend-duration"),
      playedNum: convertValueByType(jsonRes['playedNum'], int,
          stack: "Recommend-playedNum"),
      dayPlays: convertValueByType(jsonRes['dayPlays'], int,
          stack: "Recommend-dayPlays"),
      hearTime: convertValueByType(jsonRes['hearTime'], int,
          stack: "Recommend-hearTime"),
      ringtone: convertValueByType(jsonRes['ringtone'], String,
          stack: "Recommend-ringtone"),
      crbt:
          convertValueByType(jsonRes['crbt'], Object, stack: "Recommend-crbt"),
      audition: convertValueByType(jsonRes['audition'], Object,
          stack: "Recommend-audition"),
      copyFrom: convertValueByType(jsonRes['copyFrom'], String,
          stack: "Recommend-copyFrom"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Recommend-commentThreadId"),
      rtUrl: convertValueByType(jsonRes['rtUrl'], Object,
          stack: "Recommend-rtUrl"),
      ftype:
          convertValueByType(jsonRes['ftype'], int, stack: "Recommend-ftype"),
      rtUrls: rtUrls,
      copyright: convertValueByType(jsonRes['copyright'], int,
          stack: "Recommend-copyright"),
      transName: convertValueByType(jsonRes['transName'], Object,
          stack: "Recommend-transName"),
      sign:
          convertValueByType(jsonRes['sign'], Object, stack: "Recommend-sign"),
      mark: convertValueByType(jsonRes['mark'], int, stack: "Recommend-mark"),
      mvid: convertValueByType(jsonRes['mvid'], int, stack: "Recommend-mvid"),
      bMusic: BMusic.fromJson(jsonRes['bMusic']),
      mp3Url: convertValueByType(jsonRes['mp3Url'], Object,
          stack: "Recommend-mp3Url"),
      rtype:
          convertValueByType(jsonRes['rtype'], int, stack: "Recommend-rtype"),
      rurl:
          convertValueByType(jsonRes['rurl'], Object, stack: "Recommend-rurl"),
      hMusic: HMusic.fromJson(jsonRes['hMusic']),
      mMusic: MMusic.fromJson(jsonRes['mMusic']),
      lMusic: LMusic.fromJson(jsonRes['lMusic']),
      reason: convertValueByType(jsonRes['reason'], String,
          stack: "Recommend-reason"),
      privilege: Privilege.fromJson(jsonRes['privilege']),
      alg: convertValueByType(jsonRes['alg'], String, stack: "Recommend-alg"),
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
        'mvid': mvid,
        'bMusic': bMusic,
        'mp3Url': mp3Url,
        'rtype': rtype,
        'rurl': rurl,
        'hMusic': hMusic,
        'mMusic': mMusic,
        'lMusic': lMusic,
        'reason': reason,
        'privilege': privilege,
        'alg': alg,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Artists {
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

  Artists({
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
      name: convertValueByType(jsonRes['name'], String, stack: "Artists-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Artists-id"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Artists-picId"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "Artists-img1v1Id"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "Artists-briefDesc"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "Artists-picUrl"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "Artists-img1v1Url"),
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "Artists-albumSize"),
      alias: alias,
      trans:
          convertValueByType(jsonRes['trans'], String, stack: "Artists-trans"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "Artists-musicSize"),
      topicPerson: convertValueByType(jsonRes['topicPerson'], int,
          stack: "Artists-topicPerson"),
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
  String company;
  String briefDesc;
  AlbumArtist artist;
  List<Object> songs;
  List<String> alias;
  int status;
  int copyrightId;
  String commentThreadId;
  List<AlbumArtists> artists;
  String subType;
  String transName;
  int mark;
  String picId_str;
  List<String> transNames;

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
    this.transNames,
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

    List<String> alias = jsonRes['alias'] is List ? [] : null;
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

    List<String> transNames = jsonRes['transNames'] is List ? [] : null;
    if (transNames != null) {
      for (var item in jsonRes['transNames']) {
        if (item != null) {
          tryCatch(() {
            transNames.add(item);
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
      company: convertValueByType(jsonRes['company'], String,
          stack: "Album-company"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "Album-briefDesc"),
      artist: AlbumArtist.fromJson(jsonRes['artist']),
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
      transName: convertValueByType(jsonRes['transName'], String,
          stack: "Album-transName"),
      mark: convertValueByType(jsonRes['mark'], int, stack: "Album-mark"),
      picId_str: convertValueByType(jsonRes['picId_str'], String,
          stack: "Album-picId_str"),
      transNames: transNames,
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
        'transNames': transNames,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class AlbumArtist {
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

  AlbumArtist({
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

  factory AlbumArtist.fromJson(jsonRes) {
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

    return AlbumArtist(
      name: convertValueByType(jsonRes['name'], String,
          stack: "AlbumArtist-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "AlbumArtist-id"),
      picId:
          convertValueByType(jsonRes['picId'], int, stack: "AlbumArtist-picId"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "AlbumArtist-img1v1Id"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "AlbumArtist-briefDesc"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "AlbumArtist-picUrl"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "AlbumArtist-img1v1Url"),
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "AlbumArtist-albumSize"),
      alias: alias,
      trans: convertValueByType(jsonRes['trans'], String,
          stack: "AlbumArtist-trans"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "AlbumArtist-musicSize"),
      topicPerson: convertValueByType(jsonRes['topicPerson'], int,
          stack: "AlbumArtist-topicPerson"),
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

class Privilege {
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

  Privilege({
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

  factory Privilege.fromJson(jsonRes) => jsonRes == null
      ? null
      : Privilege(
          id: convertValueByType(jsonRes['id'], int, stack: "Privilege-id"),
          fee: convertValueByType(jsonRes['fee'], int, stack: "Privilege-fee"),
          payed: convertValueByType(jsonRes['payed'], int,
              stack: "Privilege-payed"),
          st: convertValueByType(jsonRes['st'], int, stack: "Privilege-st"),
          pl: convertValueByType(jsonRes['pl'], int, stack: "Privilege-pl"),
          dl: convertValueByType(jsonRes['dl'], int, stack: "Privilege-dl"),
          sp: convertValueByType(jsonRes['sp'], int, stack: "Privilege-sp"),
          cp: convertValueByType(jsonRes['cp'], int, stack: "Privilege-cp"),
          subp:
              convertValueByType(jsonRes['subp'], int, stack: "Privilege-subp"),
          cs: convertValueByType(jsonRes['cs'], bool, stack: "Privilege-cs"),
          maxbr: convertValueByType(jsonRes['maxbr'], int,
              stack: "Privilege-maxbr"),
          fl: convertValueByType(jsonRes['fl'], int, stack: "Privilege-fl"),
          toast: convertValueByType(jsonRes['toast'], bool,
              stack: "Privilege-toast"),
          flag:
              convertValueByType(jsonRes['flag'], int, stack: "Privilege-flag"),
          preSell: convertValueByType(jsonRes['preSell'], bool,
              stack: "Privilege-preSell"),
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

class Data {
  List<DailySongs> dailySongs;
  List<Object> orderSongs;

  Data({
    this.dailySongs,
    this.orderSongs,
  });

  factory Data.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<DailySongs> dailySongs = jsonRes['dailySongs'] is List ? [] : null;
    if (dailySongs != null) {
      for (var item in jsonRes['dailySongs']) {
        if (item != null) {
          tryCatch(() {
            dailySongs.add(DailySongs.fromJson(item));
          });
        }
      }
    }

    List<Object> orderSongs = jsonRes['orderSongs'] is List ? [] : null;
    if (orderSongs != null) {
      for (var item in jsonRes['orderSongs']) {
        if (item != null) {
          tryCatch(() {
            orderSongs.add(item);
          });
        }
      }
    }

    return Data(
      dailySongs: dailySongs,
      orderSongs: orderSongs,
    );
  }
  Map<String, dynamic> toJson() => {
        'dailySongs': dailySongs,
        'orderSongs': orderSongs,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class DailySongs {
  String name;
  int id;
  int position;
  List<Object> alias;
  int status;
  int fee;
  int copyrightId;
  String disc;
  int no;
  List<DataArtists> artists;
  DataAlbum album;
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
  int mvid;
  DataBMusic bMusic;
  Object mp3Url;
  int rtype;
  Object rurl;
  DataHMusic hMusic;
  DataMMusic mMusic;
  DataLMusic lMusic;
  String reason;
  DataPrivilege privilege;
  String alg;

  DailySongs({
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
    this.mvid,
    this.bMusic,
    this.mp3Url,
    this.rtype,
    this.rurl,
    this.hMusic,
    this.mMusic,
    this.lMusic,
    this.reason,
    this.privilege,
    this.alg,
  });

  factory DailySongs.fromJson(jsonRes) {
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

    List<DataArtists> artists = jsonRes['artists'] is List ? [] : null;
    if (artists != null) {
      for (var item in jsonRes['artists']) {
        if (item != null) {
          tryCatch(() {
            artists.add(DataArtists.fromJson(item));
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

    return DailySongs(
      name:
          convertValueByType(jsonRes['name'], String, stack: "DailySongs-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "DailySongs-id"),
      position: convertValueByType(jsonRes['position'], int,
          stack: "DailySongs-position"),
      alias: alias,
      status: convertValueByType(jsonRes['status'], int,
          stack: "DailySongs-status"),
      fee: convertValueByType(jsonRes['fee'], int, stack: "DailySongs-fee"),
      copyrightId: convertValueByType(jsonRes['copyrightId'], int,
          stack: "DailySongs-copyrightId"),
      disc:
          convertValueByType(jsonRes['disc'], String, stack: "DailySongs-disc"),
      no: convertValueByType(jsonRes['no'], int, stack: "DailySongs-no"),
      artists: artists,
      album: DataAlbum.fromJson(jsonRes['album']),
      starred: convertValueByType(jsonRes['starred'], bool,
          stack: "DailySongs-starred"),
      popularity: convertValueByType(jsonRes['popularity'], int,
          stack: "DailySongs-popularity"),
      score:
          convertValueByType(jsonRes['score'], int, stack: "DailySongs-score"),
      starredNum: convertValueByType(jsonRes['starredNum'], int,
          stack: "DailySongs-starredNum"),
      duration: convertValueByType(jsonRes['duration'], int,
          stack: "DailySongs-duration"),
      playedNum: convertValueByType(jsonRes['playedNum'], int,
          stack: "DailySongs-playedNum"),
      dayPlays: convertValueByType(jsonRes['dayPlays'], int,
          stack: "DailySongs-dayPlays"),
      hearTime: convertValueByType(jsonRes['hearTime'], int,
          stack: "DailySongs-hearTime"),
      ringtone: convertValueByType(jsonRes['ringtone'], String,
          stack: "DailySongs-ringtone"),
      crbt:
          convertValueByType(jsonRes['crbt'], Object, stack: "DailySongs-crbt"),
      audition: convertValueByType(jsonRes['audition'], Object,
          stack: "DailySongs-audition"),
      copyFrom: convertValueByType(jsonRes['copyFrom'], String,
          stack: "DailySongs-copyFrom"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "DailySongs-commentThreadId"),
      rtUrl: convertValueByType(jsonRes['rtUrl'], Object,
          stack: "DailySongs-rtUrl"),
      ftype:
          convertValueByType(jsonRes['ftype'], int, stack: "DailySongs-ftype"),
      rtUrls: rtUrls,
      copyright: convertValueByType(jsonRes['copyright'], int,
          stack: "DailySongs-copyright"),
      transName: convertValueByType(jsonRes['transName'], Object,
          stack: "DailySongs-transName"),
      sign:
          convertValueByType(jsonRes['sign'], Object, stack: "DailySongs-sign"),
      mark: convertValueByType(jsonRes['mark'], int, stack: "DailySongs-mark"),
      mvid: convertValueByType(jsonRes['mvid'], int, stack: "DailySongs-mvid"),
      bMusic: DataBMusic.fromJson(jsonRes['bMusic']),
      mp3Url: convertValueByType(jsonRes['mp3Url'], Object,
          stack: "DailySongs-mp3Url"),
      rtype:
          convertValueByType(jsonRes['rtype'], int, stack: "DailySongs-rtype"),
      rurl:
          convertValueByType(jsonRes['rurl'], Object, stack: "DailySongs-rurl"),
      hMusic: DataHMusic.fromJson(jsonRes['hMusic']),
      mMusic: DataMMusic.fromJson(jsonRes['mMusic']),
      lMusic: DataLMusic.fromJson(jsonRes['lMusic']),
      reason: convertValueByType(jsonRes['reason'], String,
          stack: "DailySongs-reason"),
      privilege: DataPrivilege.fromJson(jsonRes['privilege']),
      alg: convertValueByType(jsonRes['alg'], String, stack: "DailySongs-alg"),
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
        'mvid': mvid,
        'bMusic': bMusic,
        'mp3Url': mp3Url,
        'rtype': rtype,
        'rurl': rurl,
        'hMusic': hMusic,
        'mMusic': mMusic,
        'lMusic': lMusic,
        'reason': reason,
        'privilege': privilege,
        'alg': alg,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class DataArtists {
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

  DataArtists({
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

  factory DataArtists.fromJson(jsonRes) {
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

    return DataArtists(
      name: convertValueByType(jsonRes['name'], String,
          stack: "DataArtists-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "DataArtists-id"),
      picId:
          convertValueByType(jsonRes['picId'], int, stack: "DataArtists-picId"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "DataArtists-img1v1Id"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "DataArtists-briefDesc"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "DataArtists-picUrl"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "DataArtists-img1v1Url"),
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "DataArtists-albumSize"),
      alias: alias,
      trans: convertValueByType(jsonRes['trans'], String,
          stack: "DataArtists-trans"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "DataArtists-musicSize"),
      topicPerson: convertValueByType(jsonRes['topicPerson'], int,
          stack: "DataArtists-topicPerson"),
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

class DataAlbum {
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
  String company;
  String briefDesc;
  DataAlbumArtist artist;
  List<Object> songs;
  List<String> alias;
  int status;
  int copyrightId;
  String commentThreadId;
  List<DataAlbumArtists> artists;
  String subType;
  String transName;
  int mark;
  String picId_str;
  List<String> transNames;

  DataAlbum({
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
    this.transNames,
  });

  factory DataAlbum.fromJson(jsonRes) {
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

    List<String> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          tryCatch(() {
            alias.add(item);
          });
        }
      }
    }

    List<DataAlbumArtists> artists = jsonRes['artists'] is List ? [] : null;
    if (artists != null) {
      for (var item in jsonRes['artists']) {
        if (item != null) {
          tryCatch(() {
            artists.add(DataAlbumArtists.fromJson(item));
          });
        }
      }
    }

    List<String> transNames = jsonRes['transNames'] is List ? [] : null;
    if (transNames != null) {
      for (var item in jsonRes['transNames']) {
        if (item != null) {
          tryCatch(() {
            transNames.add(item);
          });
        }
      }
    }

    return DataAlbum(
      name:
          convertValueByType(jsonRes['name'], String, stack: "DataAlbum-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "DataAlbum-id"),
      type:
          convertValueByType(jsonRes['type'], String, stack: "DataAlbum-type"),
      size: convertValueByType(jsonRes['size'], int, stack: "DataAlbum-size"),
      picId:
          convertValueByType(jsonRes['picId'], int, stack: "DataAlbum-picId"),
      blurPicUrl: convertValueByType(jsonRes['blurPicUrl'], String,
          stack: "DataAlbum-blurPicUrl"),
      companyId: convertValueByType(jsonRes['companyId'], int,
          stack: "DataAlbum-companyId"),
      pic: convertValueByType(jsonRes['pic'], int, stack: "DataAlbum-pic"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "DataAlbum-picUrl"),
      publishTime: convertValueByType(jsonRes['publishTime'], int,
          stack: "DataAlbum-publishTime"),
      description: convertValueByType(jsonRes['description'], String,
          stack: "DataAlbum-description"),
      tags:
          convertValueByType(jsonRes['tags'], String, stack: "DataAlbum-tags"),
      company: convertValueByType(jsonRes['company'], String,
          stack: "DataAlbum-company"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "DataAlbum-briefDesc"),
      artist: DataAlbumArtist.fromJson(jsonRes['artist']),
      songs: songs,
      alias: alias,
      status:
          convertValueByType(jsonRes['status'], int, stack: "DataAlbum-status"),
      copyrightId: convertValueByType(jsonRes['copyrightId'], int,
          stack: "DataAlbum-copyrightId"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "DataAlbum-commentThreadId"),
      artists: artists,
      subType: convertValueByType(jsonRes['subType'], String,
          stack: "DataAlbum-subType"),
      transName: convertValueByType(jsonRes['transName'], String,
          stack: "DataAlbum-transName"),
      mark: convertValueByType(jsonRes['mark'], int, stack: "DataAlbum-mark"),
      picId_str: convertValueByType(jsonRes['picId_str'], String,
          stack: "DataAlbum-picId_str"),
      transNames: transNames,
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
        'transNames': transNames,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class DataAlbumArtist {
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

  DataAlbumArtist({
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

  factory DataAlbumArtist.fromJson(jsonRes) {
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

    return DataAlbumArtist(
      name: convertValueByType(jsonRes['name'], String,
          stack: "DataAlbumArtist-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "DataAlbumArtist-id"),
      picId: convertValueByType(jsonRes['picId'], int,
          stack: "DataAlbumArtist-picId"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "DataAlbumArtist-img1v1Id"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "DataAlbumArtist-briefDesc"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "DataAlbumArtist-picUrl"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "DataAlbumArtist-img1v1Url"),
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "DataAlbumArtist-albumSize"),
      alias: alias,
      trans: convertValueByType(jsonRes['trans'], String,
          stack: "DataAlbumArtist-trans"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "DataAlbumArtist-musicSize"),
      topicPerson: convertValueByType(jsonRes['topicPerson'], int,
          stack: "DataAlbumArtist-topicPerson"),
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

class DataAlbumArtists {
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

  DataAlbumArtists({
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

  factory DataAlbumArtists.fromJson(jsonRes) {
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

    return DataAlbumArtists(
      name: convertValueByType(jsonRes['name'], String,
          stack: "DataAlbumArtists-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "DataAlbumArtists-id"),
      picId: convertValueByType(jsonRes['picId'], int,
          stack: "DataAlbumArtists-picId"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "DataAlbumArtists-img1v1Id"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "DataAlbumArtists-briefDesc"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "DataAlbumArtists-picUrl"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "DataAlbumArtists-img1v1Url"),
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "DataAlbumArtists-albumSize"),
      alias: alias,
      trans: convertValueByType(jsonRes['trans'], String,
          stack: "DataAlbumArtists-trans"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "DataAlbumArtists-musicSize"),
      topicPerson: convertValueByType(jsonRes['topicPerson'], int,
          stack: "DataAlbumArtists-topicPerson"),
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

class DataBMusic {
  Object name;
  int id;
  int size;
  String extension;
  int sr;
  int dfsId;
  int bitrate;
  int playTime;
  int volumeDelta;

  DataBMusic({
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

  factory DataBMusic.fromJson(jsonRes) => jsonRes == null
      ? null
      : DataBMusic(
          name: convertValueByType(jsonRes['name'], Object,
              stack: "DataBMusic-name"),
          id: convertValueByType(jsonRes['id'], int, stack: "DataBMusic-id"),
          size: convertValueByType(jsonRes['size'], int,
              stack: "DataBMusic-size"),
          extension: convertValueByType(jsonRes['extension'], String,
              stack: "DataBMusic-extension"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "DataBMusic-sr"),
          dfsId: convertValueByType(jsonRes['dfsId'], int,
              stack: "DataBMusic-dfsId"),
          bitrate: convertValueByType(jsonRes['bitrate'], int,
              stack: "DataBMusic-bitrate"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "DataBMusic-playTime"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], int,
              stack: "DataBMusic-volumeDelta"),
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

class DataHMusic {
  Object name;
  int id;
  int size;
  String extension;
  int sr;
  int dfsId;
  int bitrate;
  int playTime;
  int volumeDelta;

  DataHMusic({
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

  factory DataHMusic.fromJson(jsonRes) => jsonRes == null
      ? null
      : DataHMusic(
          name: convertValueByType(jsonRes['name'], Object,
              stack: "DataHMusic-name"),
          id: convertValueByType(jsonRes['id'], int, stack: "DataHMusic-id"),
          size: convertValueByType(jsonRes['size'], int,
              stack: "DataHMusic-size"),
          extension: convertValueByType(jsonRes['extension'], String,
              stack: "DataHMusic-extension"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "DataHMusic-sr"),
          dfsId: convertValueByType(jsonRes['dfsId'], int,
              stack: "DataHMusic-dfsId"),
          bitrate: convertValueByType(jsonRes['bitrate'], int,
              stack: "DataHMusic-bitrate"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "DataHMusic-playTime"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], int,
              stack: "DataHMusic-volumeDelta"),
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

class DataMMusic {
  Object name;
  int id;
  int size;
  String extension;
  int sr;
  int dfsId;
  int bitrate;
  int playTime;
  int volumeDelta;

  DataMMusic({
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

  factory DataMMusic.fromJson(jsonRes) => jsonRes == null
      ? null
      : DataMMusic(
          name: convertValueByType(jsonRes['name'], Object,
              stack: "DataMMusic-name"),
          id: convertValueByType(jsonRes['id'], int, stack: "DataMMusic-id"),
          size: convertValueByType(jsonRes['size'], int,
              stack: "DataMMusic-size"),
          extension: convertValueByType(jsonRes['extension'], String,
              stack: "DataMMusic-extension"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "DataMMusic-sr"),
          dfsId: convertValueByType(jsonRes['dfsId'], int,
              stack: "DataMMusic-dfsId"),
          bitrate: convertValueByType(jsonRes['bitrate'], int,
              stack: "DataMMusic-bitrate"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "DataMMusic-playTime"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], int,
              stack: "DataMMusic-volumeDelta"),
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

class DataLMusic {
  Object name;
  int id;
  int size;
  String extension;
  int sr;
  int dfsId;
  int bitrate;
  int playTime;
  int volumeDelta;

  DataLMusic({
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

  factory DataLMusic.fromJson(jsonRes) => jsonRes == null
      ? null
      : DataLMusic(
          name: convertValueByType(jsonRes['name'], Object,
              stack: "DataLMusic-name"),
          id: convertValueByType(jsonRes['id'], int, stack: "DataLMusic-id"),
          size: convertValueByType(jsonRes['size'], int,
              stack: "DataLMusic-size"),
          extension: convertValueByType(jsonRes['extension'], String,
              stack: "DataLMusic-extension"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "DataLMusic-sr"),
          dfsId: convertValueByType(jsonRes['dfsId'], int,
              stack: "DataLMusic-dfsId"),
          bitrate: convertValueByType(jsonRes['bitrate'], int,
              stack: "DataLMusic-bitrate"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "DataLMusic-playTime"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], int,
              stack: "DataLMusic-volumeDelta"),
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

class DataPrivilege {
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

  DataPrivilege({
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

  factory DataPrivilege.fromJson(jsonRes) => jsonRes == null
      ? null
      : DataPrivilege(
          id: convertValueByType(jsonRes['id'], int, stack: "DataPrivilege-id"),
          fee: convertValueByType(jsonRes['fee'], int,
              stack: "DataPrivilege-fee"),
          payed: convertValueByType(jsonRes['payed'], int,
              stack: "DataPrivilege-payed"),
          st: convertValueByType(jsonRes['st'], int, stack: "DataPrivilege-st"),
          pl: convertValueByType(jsonRes['pl'], int, stack: "DataPrivilege-pl"),
          dl: convertValueByType(jsonRes['dl'], int, stack: "DataPrivilege-dl"),
          sp: convertValueByType(jsonRes['sp'], int, stack: "DataPrivilege-sp"),
          cp: convertValueByType(jsonRes['cp'], int, stack: "DataPrivilege-cp"),
          subp: convertValueByType(jsonRes['subp'], int,
              stack: "DataPrivilege-subp"),
          cs: convertValueByType(jsonRes['cs'], bool,
              stack: "DataPrivilege-cs"),
          maxbr: convertValueByType(jsonRes['maxbr'], int,
              stack: "DataPrivilege-maxbr"),
          fl: convertValueByType(jsonRes['fl'], int, stack: "DataPrivilege-fl"),
          toast: convertValueByType(jsonRes['toast'], bool,
              stack: "DataPrivilege-toast"),
          flag: convertValueByType(jsonRes['flag'], int,
              stack: "DataPrivilege-flag"),
          preSell: convertValueByType(jsonRes['preSell'], bool,
              stack: "DataPrivilege-preSell"),
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
