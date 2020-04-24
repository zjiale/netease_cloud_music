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

class SearchAlbumDetailModel {
  int code;
  Result result;

  SearchAlbumDetailModel({
    this.code,
    this.result,
  });

  factory SearchAlbumDetailModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : SearchAlbumDetailModel(
          code: convertValueByType(jsonRes['code'], int,
              stack: "SearchAlbumDetailModel-code"),
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
  int albumCount;
  List<Albums> albums;

  Result({
    this.albumCount,
    this.albums,
  });

  factory Result.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Albums> albums = jsonRes['albums'] is List ? [] : null;
    if (albums != null) {
      for (var item in jsonRes['albums']) {
        if (item != null) {
          tryCatch(() {
            albums.add(Albums.fromJson(item));
          });
        }
      }
    }

    return Result(
      albumCount: convertValueByType(jsonRes['albumCount'], int,
          stack: "Result-albumCount"),
      albums: albums,
    );
  }
  Map<String, dynamic> toJson() => {
        'albumCount': albumCount,
        'albums': albums,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Albums {
  String alg;
  List<String> alias;
  Artist artist;
  List<Artists> artists;
  String blurPicUrl;
  String briefDesc;
  String commentThreadId;
  String company;
  int companyId;
  String containedSong;
  int copyrightId;
  String description;
  int id;
  int mark;
  String name;
  bool onSale;
  bool paid;
  int pic;
  int picId;
  String picidStr;
  String picUrl;
  int publishTime;
  int size;
  Object songs;
  int status;
  String tags;
  String type;

  Albums({
    this.alg,
    this.alias,
    this.artist,
    this.artists,
    this.blurPicUrl,
    this.briefDesc,
    this.commentThreadId,
    this.company,
    this.companyId,
    this.containedSong,
    this.copyrightId,
    this.description,
    this.id,
    this.mark,
    this.name,
    this.onSale,
    this.paid,
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

  factory Albums.fromJson(jsonRes) {
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

    return Albums(
      alg: convertValueByType(jsonRes['alg'], String, stack: "Albums-alg"),
      alias: alias,
      artist: Artist.fromJson(jsonRes['artist']),
      artists: artists,
      blurPicUrl: convertValueByType(jsonRes['blurPicUrl'], String,
          stack: "Albums-blurPicUrl"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "Albums-briefDesc"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Albums-commentThreadId"),
      company: convertValueByType(jsonRes['company'], String,
          stack: "Albums-company"),
      companyId: convertValueByType(jsonRes['companyId'], int,
          stack: "Albums-companyId"),
      containedSong: convertValueByType(jsonRes['containedSong'], String,
          stack: "Albums-containedSong"),
      copyrightId: convertValueByType(jsonRes['copyrightId'], int,
          stack: "Albums-copyrightId"),
      description: convertValueByType(jsonRes['description'], String,
          stack: "Albums-description"),
      id: convertValueByType(jsonRes['id'], int, stack: "Albums-id"),
      mark: convertValueByType(jsonRes['mark'], int, stack: "Albums-mark"),
      name: convertValueByType(jsonRes['name'], String, stack: "Albums-name"),
      onSale:
          convertValueByType(jsonRes['onSale'], bool, stack: "Albums-onSale"),
      paid: convertValueByType(jsonRes['paid'], bool, stack: "Albums-paid"),
      pic: convertValueByType(jsonRes['pic'], int, stack: "Albums-pic"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Albums-picId"),
      picidStr: convertValueByType(jsonRes['picId_str'], String,
          stack: "Albums-picId_str"),
      picUrl:
          convertValueByType(jsonRes['picUrl'], String, stack: "Albums-picUrl"),
      publishTime: convertValueByType(jsonRes['publishTime'], int,
          stack: "Albums-publishTime"),
      size: convertValueByType(jsonRes['size'], int, stack: "Albums-size"),
      songs:
          convertValueByType(jsonRes['songs'], Object, stack: "Albums-songs"),
      status:
          convertValueByType(jsonRes['status'], int, stack: "Albums-status"),
      tags: convertValueByType(jsonRes['tags'], String, stack: "Albums-tags"),
      type: convertValueByType(jsonRes['type'], String, stack: "Albums-type"),
    );
  }
  Map<String, dynamic> toJson() => {
        'alg': alg,
        'alias': alias,
        'artist': artist,
        'artists': artists,
        'blurPicUrl': blurPicUrl,
        'briefDesc': briefDesc,
        'commentThreadId': commentThreadId,
        'company': company,
        'companyId': companyId,
        'containedSong': containedSong,
        'copyrightId': copyrightId,
        'description': description,
        'id': id,
        'mark': mark,
        'name': name,
        'onSale': onSale,
        'paid': paid,
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

class Artist {
  int albumSize;
  List<String> alia;
  List<String> alias;
  String briefDesc;
  int id;
  int img1v1Id;
  String img1v1idStr;
  String img1v1Url;
  int musicSize;
  String name;
  int picId;
  String picidStr;
  String picUrl;
  int topicPerson;
  String trans;
  List<String> transNames;

  Artist({
    this.albumSize,
    this.alia,
    this.alias,
    this.briefDesc,
    this.id,
    this.img1v1Id,
    this.img1v1idStr,
    this.img1v1Url,
    this.musicSize,
    this.name,
    this.picId,
    this.picidStr,
    this.picUrl,
    this.topicPerson,
    this.trans,
    this.transNames,
  });

  factory Artist.fromJson(jsonRes) {
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

    return Artist(
      albumSize: convertValueByType(jsonRes['albumSize'], int,
          stack: "Artist-albumSize"),
      alia: alia,
      alias: alias,
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "Artist-briefDesc"),
      id: convertValueByType(jsonRes['id'], int, stack: "Artist-id"),
      img1v1Id: convertValueByType(jsonRes['img1v1Id'], int,
          stack: "Artist-img1v1Id"),
      img1v1idStr: convertValueByType(jsonRes['img1v1Id_str'], String,
          stack: "Artist-img1v1Id_str"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "Artist-img1v1Url"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "Artist-musicSize"),
      name: convertValueByType(jsonRes['name'], String, stack: "Artist-name"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Artist-picId"),
      picidStr: convertValueByType(jsonRes['picId_str'], String,
          stack: "Artist-picId_str"),
      picUrl:
          convertValueByType(jsonRes['picUrl'], String, stack: "Artist-picUrl"),
      topicPerson: convertValueByType(jsonRes['topicPerson'], int,
          stack: "Artist-topicPerson"),
      trans:
          convertValueByType(jsonRes['trans'], String, stack: "Artist-trans"),
      transNames: transNames,
    );
  }
  Map<String, dynamic> toJson() => {
        'albumSize': albumSize,
        'alia': alia,
        'alias': alias,
        'briefDesc': briefDesc,
        'id': id,
        'img1v1Id': img1v1Id,
        'img1v1Id_str': img1v1idStr,
        'img1v1Url': img1v1Url,
        'musicSize': musicSize,
        'name': name,
        'picId': picId,
        'picId_str': picidStr,
        'picUrl': picUrl,
        'topicPerson': topicPerson,
        'trans': trans,
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
  String img1v1idStr;
  String img1v1Url;
  int musicSize;
  String name;
  int picId;
  String picUrl;
  int topicPerson;
  String trans;

  Artists({
    this.albumSize,
    this.alias,
    this.briefDesc,
    this.id,
    this.img1v1Id,
    this.img1v1idStr,
    this.img1v1Url,
    this.musicSize,
    this.name,
    this.picId,
    this.picUrl,
    this.topicPerson,
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
      img1v1idStr: convertValueByType(jsonRes['img1v1Id_str'], String,
          stack: "Artists-img1v1Id_str"),
      img1v1Url: convertValueByType(jsonRes['img1v1Url'], String,
          stack: "Artists-img1v1Url"),
      musicSize: convertValueByType(jsonRes['musicSize'], int,
          stack: "Artists-musicSize"),
      name: convertValueByType(jsonRes['name'], String, stack: "Artists-name"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Artists-picId"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "Artists-picUrl"),
      topicPerson: convertValueByType(jsonRes['topicPerson'], int,
          stack: "Artists-topicPerson"),
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
        'img1v1Id_str': img1v1idStr,
        'img1v1Url': img1v1Url,
        'musicSize': musicSize,
        'name': name,
        'picId': picId,
        'picUrl': picUrl,
        'topicPerson': topicPerson,
        'trans': trans,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
