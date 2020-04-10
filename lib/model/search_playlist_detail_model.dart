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

class SearchPlaylistDetailModel {
  int code;
  Result result;

  SearchPlaylistDetailModel({
    this.code,
    this.result,
  });

  factory SearchPlaylistDetailModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : SearchPlaylistDetailModel(
          code: convertValueByType(jsonRes['code'], int,
              stack: "SearchPlaylistDetailModel-code"),
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
  int playlistCount;
  List<Playlists> playlists;

  Result({
    this.playlistCount,
    this.playlists,
  });

  factory Result.fromJson(jsonRes) {
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

    return Result(
      playlistCount: convertValueByType(jsonRes['playlistCount'], int,
          stack: "Result-playlistCount"),
      playlists: playlists,
    );
  }
  Map<String, dynamic> toJson() => {
        'playlistCount': playlistCount,
        'playlists': playlists,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Playlists {
  String alg;
  int bookCount;
  String coverImgUrl;
  Creator creator;
  String description;
  bool highQuality;
  int id;
  String name;
  Object officialTags;
  int playCount;
  bool subscribed;
  Track track;
  int trackCount;
  int userId;

  Playlists({
    this.alg,
    this.bookCount,
    this.coverImgUrl,
    this.creator,
    this.description,
    this.highQuality,
    this.id,
    this.name,
    this.officialTags,
    this.playCount,
    this.subscribed,
    this.track,
    this.trackCount,
    this.userId,
  });

  factory Playlists.fromJson(jsonRes) => jsonRes == null
      ? null
      : Playlists(
          alg: convertValueByType(jsonRes['alg'], String,
              stack: "Playlists-alg"),
          bookCount: convertValueByType(jsonRes['bookCount'], int,
              stack: "Playlists-bookCount"),
          coverImgUrl: convertValueByType(jsonRes['coverImgUrl'], String,
              stack: "Playlists-coverImgUrl"),
          creator: Creator.fromJson(jsonRes['creator']),
          description: convertValueByType(jsonRes['description'], String,
              stack: "Playlists-description"),
          highQuality: convertValueByType(jsonRes['highQuality'], bool,
              stack: "Playlists-highQuality"),
          id: convertValueByType(jsonRes['id'], int, stack: "Playlists-id"),
          name: convertValueByType(jsonRes['name'], String,
              stack: "Playlists-name"),
          officialTags: convertValueByType(jsonRes['officialTags'], Object,
              stack: "Playlists-officialTags"),
          playCount: convertValueByType(jsonRes['playCount'], int,
              stack: "Playlists-playCount"),
          subscribed: convertValueByType(jsonRes['subscribed'], bool,
              stack: "Playlists-subscribed"),
          track: Track.fromJson(jsonRes['track']),
          trackCount: convertValueByType(jsonRes['trackCount'], int,
              stack: "Playlists-trackCount"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "Playlists-userId"),
        );
  Map<String, dynamic> toJson() => {
        'alg': alg,
        'bookCount': bookCount,
        'coverImgUrl': coverImgUrl,
        'creator': creator,
        'description': description,
        'highQuality': highQuality,
        'id': id,
        'name': name,
        'officialTags': officialTags,
        'playCount': playCount,
        'subscribed': subscribed,
        'track': track,
        'trackCount': trackCount,
        'userId': userId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Creator {
  int authStatus;
  Object experts;
  Object expertTags;
  String nickname;
  int userId;
  int userType;

  Creator({
    this.authStatus,
    this.experts,
    this.expertTags,
    this.nickname,
    this.userId,
    this.userType,
  });

  factory Creator.fromJson(jsonRes) => jsonRes == null
      ? null
      : Creator(
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "Creator-authStatus"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "Creator-experts"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "Creator-expertTags"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "Creator-nickname"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "Creator-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "Creator-userType"),
        );
  Map<String, dynamic> toJson() => {
        'authStatus': authStatus,
        'experts': experts,
        'expertTags': expertTags,
        'nickname': nickname,
        'userId': userId,
        'userType': userType,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Track {
  Album album;
  List<String> alias;
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
  int popularity;
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
  List<String> transNames;

  Track({
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
    this.transNames,
  });

  factory Track.fromJson(jsonRes) {
    if (jsonRes == null) return null;
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

    return Track(
      album: Album.fromJson(jsonRes['album']),
      alias: alias,
      artists: artists,
      audition: convertValueByType(jsonRes['audition'], Object,
          stack: "Track-audition"),
      bMusic: BMusic.fromJson(jsonRes['bMusic']),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Track-commentThreadId"),
      copyFrom: convertValueByType(jsonRes['copyFrom'], String,
          stack: "Track-copyFrom"),
      copyright: convertValueByType(jsonRes['copyright'], int,
          stack: "Track-copyright"),
      copyrightId: convertValueByType(jsonRes['copyrightId'], int,
          stack: "Track-copyrightId"),
      crbt: convertValueByType(jsonRes['crbt'], String, stack: "Track-crbt"),
      dayPlays:
          convertValueByType(jsonRes['dayPlays'], int, stack: "Track-dayPlays"),
      disc: convertValueByType(jsonRes['disc'], String, stack: "Track-disc"),
      duration:
          convertValueByType(jsonRes['duration'], int, stack: "Track-duration"),
      fee: convertValueByType(jsonRes['fee'], int, stack: "Track-fee"),
      ftype: convertValueByType(jsonRes['ftype'], int, stack: "Track-ftype"),
      hearTime:
          convertValueByType(jsonRes['hearTime'], int, stack: "Track-hearTime"),
      hMusic: HMusic.fromJson(jsonRes['hMusic']),
      id: convertValueByType(jsonRes['id'], int, stack: "Track-id"),
      lMusic: LMusic.fromJson(jsonRes['lMusic']),
      mMusic: MMusic.fromJson(jsonRes['mMusic']),
      mp3Url:
          convertValueByType(jsonRes['mp3Url'], Object, stack: "Track-mp3Url"),
      mvid: convertValueByType(jsonRes['mvid'], int, stack: "Track-mvid"),
      name: convertValueByType(jsonRes['name'], String, stack: "Track-name"),
      no: convertValueByType(jsonRes['no'], int, stack: "Track-no"),
      playedNum: convertValueByType(jsonRes['playedNum'], int,
          stack: "Track-playedNum"),
      popularity: convertValueByType(jsonRes['popularity'], int,
          stack: "Track-popularity"),
      position:
          convertValueByType(jsonRes['position'], int, stack: "Track-position"),
      ringtone: convertValueByType(jsonRes['ringtone'], String,
          stack: "Track-ringtone"),
      rtUrl: convertValueByType(jsonRes['rtUrl'], Object, stack: "Track-rtUrl"),
      rtUrls: rtUrls,
      rtype: convertValueByType(jsonRes['rtype'], int, stack: "Track-rtype"),
      rurl: convertValueByType(jsonRes['rurl'], Object, stack: "Track-rurl"),
      score: convertValueByType(jsonRes['score'], int, stack: "Track-score"),
      starred:
          convertValueByType(jsonRes['starred'], bool, stack: "Track-starred"),
      starredNum: convertValueByType(jsonRes['starredNum'], int,
          stack: "Track-starredNum"),
      status: convertValueByType(jsonRes['status'], int, stack: "Track-status"),
      transNames: transNames,
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
        'transNames': transNames,
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
  List<String> alias;
  AlbumArtist artist;
  List<AlbumArtists> artists;
  String blurPicUrl;
  String briefDesc;
  String commentThreadId;
  String company;
  int companyId;
  int copyrightId;
  String description;
  int id;
  String name;
  int pic;
  int picId;
  String picidStr;
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
    this.name,
    this.pic,
    this.picId,
    this.picidStr,
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
      artist: AlbumArtist.fromJson(jsonRes['artist']),
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
      name: convertValueByType(jsonRes['name'], String, stack: "Album-name"),
      pic: convertValueByType(jsonRes['pic'], int, stack: "Album-pic"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Album-picId"),
      picidStr: convertValueByType(jsonRes['picId_str'], String,
          stack: "Album-picId_str"),
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
        'name': name,
        'pic': pic,
        'picId': picId,
        'picId_str': picidStr,
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

class AlbumArtist {
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

  AlbumArtist({
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
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "AlbumArtist-albumSize"),
      alias: alias,
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "AlbumArtist-briefDesc"),
      id: convertValueByType(jsonRes['id'], int, stack: "AlbumArtist-id"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "AlbumArtist-img1v1Id"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "AlbumArtist-img1v1Url"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "AlbumArtist-musicSize"),
      name: convertValueByType(jsonRes['name'], String,
          stack: "AlbumArtist-name"),
      picId:
          convertValueByType(jsonRes['picId'], int, stack: "AlbumArtist-picId"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "AlbumArtist-picUrl"),
      trans: convertValueByType(jsonRes['trans'], String,
          stack: "AlbumArtist-trans"),
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

class BMusic {
  int bitrate;
  int dfsId;
  String extension;
  int id;
  String name;
  int playTime;
  int size;
  int sr;
  int volumeDelta;

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
              convertValueByType(jsonRes['name'], String, stack: "BMusic-name"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "BMusic-playTime"),
          size: convertValueByType(jsonRes['size'], int, stack: "BMusic-size"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "BMusic-sr"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], int,
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

class HMusic {
  int bitrate;
  int dfsId;
  String extension;
  int id;
  String name;
  int playTime;
  int size;
  int sr;
  int volumeDelta;

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
              convertValueByType(jsonRes['name'], String, stack: "HMusic-name"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "HMusic-playTime"),
          size: convertValueByType(jsonRes['size'], int, stack: "HMusic-size"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "HMusic-sr"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], int,
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
  String name;
  int playTime;
  int size;
  int sr;
  int volumeDelta;

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
              convertValueByType(jsonRes['name'], String, stack: "MMusic-name"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "MMusic-playTime"),
          size: convertValueByType(jsonRes['size'], int, stack: "MMusic-size"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "MMusic-sr"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], int,
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
  String name;
  int playTime;
  int size;
  int sr;
  int volumeDelta;

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
              convertValueByType(jsonRes['name'], String, stack: "LMusic-name"),
          playTime: convertValueByType(jsonRes['playTime'], int,
              stack: "LMusic-playTime"),
          size: convertValueByType(jsonRes['size'], int, stack: "LMusic-size"),
          sr: convertValueByType(jsonRes['sr'], int, stack: "LMusic-sr"),
          volumeDelta: convertValueByType(jsonRes['volumeDelta'], int,
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
