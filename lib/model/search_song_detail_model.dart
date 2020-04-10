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

class SearchSongDetailModel {
  int code;
  Result result;

  SearchSongDetailModel({
    this.code,
    this.result,
  });

  factory SearchSongDetailModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : SearchSongDetailModel(
          code: convertValueByType(jsonRes['code'], int,
              stack: "SearchSongDetailModel-code"),
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
  int songCount;
  List<Songs> songs;

  Result({
    this.songCount,
    this.songs,
  });

  factory Result.fromJson(jsonRes) {
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

    return Result(
      songCount: convertValueByType(jsonRes['songCount'], int,
          stack: "Result-songCount"),
      songs: songs,
    );
  }
  Map<String, dynamic> toJson() => {
        'songCount': songCount,
        'songs': songs,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Songs {
  Album album;
  List<String> alias;
  List<Artists> artists;
  int copyrightId;
  int duration;
  int fee;
  int ftype;
  int id;
  int mark;
  int mvid;
  String name;
  int rtype;
  Object rUrl;
  int status;

  Songs({
    this.album,
    this.alias,
    this.artists,
    this.copyrightId,
    this.duration,
    this.fee,
    this.ftype,
    this.id,
    this.mark,
    this.mvid,
    this.name,
    this.rtype,
    this.rUrl,
    this.status,
  });

  factory Songs.fromJson(jsonRes) {
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

    return Songs(
      album: Album.fromJson(jsonRes['album']),
      alias: alias,
      artists: artists,
      copyrightId: convertValueByType(jsonRes['copyrightId'], int,
          stack: "Songs-copyrightId"),
      duration:
          convertValueByType(jsonRes['duration'], int, stack: "Songs-duration"),
      fee: convertValueByType(jsonRes['fee'], int, stack: "Songs-fee"),
      ftype: convertValueByType(jsonRes['ftype'], int, stack: "Songs-ftype"),
      id: convertValueByType(jsonRes['id'], int, stack: "Songs-id"),
      mark: convertValueByType(jsonRes['mark'], int, stack: "Songs-mark"),
      mvid: convertValueByType(jsonRes['mvid'], int, stack: "Songs-mvid"),
      name: convertValueByType(jsonRes['name'], String, stack: "Songs-name"),
      rtype: convertValueByType(jsonRes['rtype'], int, stack: "Songs-rtype"),
      rUrl: convertValueByType(jsonRes['rUrl'], Object, stack: "Songs-rUrl"),
      status: convertValueByType(jsonRes['status'], int, stack: "Songs-status"),
    );
  }
  Map<String, dynamic> toJson() => {
        'album': album,
        'alias': alias,
        'artists': artists,
        'copyrightId': copyrightId,
        'duration': duration,
        'fee': fee,
        'ftype': ftype,
        'id': id,
        'mark': mark,
        'mvid': mvid,
        'name': name,
        'rtype': rtype,
        'rUrl': rUrl,
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
  int id;
  int img1v1;
  String img1v1Url;
  String name;
  int picId;
  Object picUrl;
  Object trans;

  Artists({
    this.albumSize,
    this.alias,
    this.id,
    this.img1v1,
    this.img1v1Url,
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
      id: convertValueByType(jsonRes['id'], int, stack: "Artists-id"),
      img1v1:
          convertValueByType(jsonRes['img1v1'], int, stack: "Artists-img1v1"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "Artists-img1v1Url"),
      name: convertValueByType(jsonRes['name'], String, stack: "Artists-name"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Artists-picId"),
      picUrl: convertValueByType(jsonRes['picUrl'], Object,
          stack: "Artists-picUrl"),
      trans:
          convertValueByType(jsonRes['trans'], Object, stack: "Artists-trans"),
    );
  }
  Map<String, dynamic> toJson() => {
        'albumSize': albumSize,
        'alias': alias,
        'id': id,
        'img1v1': img1v1,
        'img1v1Url': img1v1Url,
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
  List<String> alia;
  Artist artist;
  int copyrightId;
  int id;
  int mark;
  String name;
  int picId;
  int publishTime;
  int size;
  int status;

  Album({
    this.alia,
    this.artist,
    this.copyrightId,
    this.id,
    this.mark,
    this.name,
    this.picId,
    this.publishTime,
    this.size,
    this.status,
  });

  factory Album.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<String> alia = jsonRes['alia'] is List ? [] : null;
    if (alia != null) {
      for (var item in jsonRes['alia']) {
        if (item != null) {
          tryCatch(() {
            alia.add(item);
          });
        }
      }
    }

    return Album(
      alia: alia,
      artist: Artist.fromJson(jsonRes['artist']),
      copyrightId: convertValueByType(jsonRes['copyrightId'], int,
          stack: "Album-copyrightId"),
      id: convertValueByType(jsonRes['id'], int, stack: "Album-id"),
      mark: convertValueByType(jsonRes['mark'], int, stack: "Album-mark"),
      name: convertValueByType(jsonRes['name'], String, stack: "Album-name"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Album-picId"),
      publishTime: convertValueByType(jsonRes['publishTime'], int,
          stack: "Album-publishTime"),
      size: convertValueByType(jsonRes['size'], int, stack: "Album-size"),
      status: convertValueByType(jsonRes['status'], int, stack: "Album-status"),
    );
  }
  Map<String, dynamic> toJson() => {
        'alia': alia,
        'artist': artist,
        'copyrightId': copyrightId,
        'id': id,
        'mark': mark,
        'name': name,
        'picId': picId,
        'publishTime': publishTime,
        'size': size,
        'status': status,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Artist {
  int albumSize;
  List<Object> alias;
  int id;
  int img1v1;
  String img1v1Url;
  String name;
  int picId;
  Object picUrl;
  Object trans;

  Artist({
    this.albumSize,
    this.alias,
    this.id,
    this.img1v1,
    this.img1v1Url,
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
      id: convertValueByType(jsonRes['id'], int, stack: "Artist-id"),
      img1v1:
          convertValueByType(jsonRes['img1v1'], int, stack: "Artist-img1v1"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "Artist-img1v1Url"),
      name: convertValueByType(jsonRes['name'], String, stack: "Artist-name"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Artist-picId"),
      picUrl:
          convertValueByType(jsonRes['picUrl'], Object, stack: "Artist-picUrl"),
      trans:
          convertValueByType(jsonRes['trans'], Object, stack: "Artist-trans"),
    );
  }
  Map<String, dynamic> toJson() => {
        'albumSize': albumSize,
        'alias': alias,
        'id': id,
        'img1v1': img1v1,
        'img1v1Url': img1v1Url,
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
