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

class NewestAlbumModel {
  int code;
  List<Albums> albums;

  NewestAlbumModel({
    this.code,
    this.albums,
  });

  factory NewestAlbumModel.fromJson(jsonRes) {
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

    return NewestAlbumModel(
      code: convertValueByType(jsonRes['code'], int,
          stack: "NewestAlbumModel-code"),
      albums: albums,
    );
  }
  Map<String, dynamic> toJson() => {
        'code': code,
        'albums': albums,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Albums {
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
  Artist artist;
  Object songs;
  List<Object> alias;
  int status;
  int copyrightId;
  String commentThreadId;
  List<Artists> artists;
  bool paid;
  bool onSale;
  String picId_str;

  Albums({
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
    this.paid,
    this.onSale,
    this.picId_str,
  });

  factory Albums.fromJson(jsonRes) {
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

    return Albums(
      name: convertValueByType(jsonRes['name'], String, stack: "Albums-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Albums-id"),
      type: convertValueByType(jsonRes['type'], String, stack: "Albums-type"),
      size: convertValueByType(jsonRes['size'], int, stack: "Albums-size"),
      picId: convertValueByType(jsonRes['picId'], int, stack: "Albums-picId"),
      blurPicUrl: convertValueByType(jsonRes['blurPicUrl'], String,
          stack: "Albums-blurPicUrl"),
      companyId: convertValueByType(jsonRes['companyId'], int,
          stack: "Albums-companyId"),
      pic: convertValueByType(jsonRes['pic'], int, stack: "Albums-pic"),
      picUrl:
          convertValueByType(jsonRes['picUrl'], String, stack: "Albums-picUrl"),
      publishTime: convertValueByType(jsonRes['publishTime'], int,
          stack: "Albums-publishTime"),
      description: convertValueByType(jsonRes['description'], String,
          stack: "Albums-description"),
      tags: convertValueByType(jsonRes['tags'], String, stack: "Albums-tags"),
      company: convertValueByType(jsonRes['company'], String,
          stack: "Albums-company"),
      briefDesc: convertValueByType(jsonRes['briefDesc'], String,
          stack: "Albums-briefDesc"),
      artist: Artist.fromJson(jsonRes['artist']),
      songs:
          convertValueByType(jsonRes['songs'], Object, stack: "Albums-songs"),
      alias: alias,
      status:
          convertValueByType(jsonRes['status'], int, stack: "Albums-status"),
      copyrightId: convertValueByType(jsonRes['copyrightId'], int,
          stack: "Albums-copyrightId"),
      commentThreadId: convertValueByType(jsonRes['commentThreadId'], String,
          stack: "Albums-commentThreadId"),
      artists: artists,
      paid: convertValueByType(jsonRes['paid'], bool, stack: "Albums-paid"),
      onSale:
          convertValueByType(jsonRes['onSale'], bool, stack: "Albums-onSale"),
      picId_str: convertValueByType(jsonRes['picId_str'], String,
          stack: "Albums-picId_str"),
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
        'paid': paid,
        'onSale': onSale,
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
  String img1v1Id_str;

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
    this.img1v1Id_str,
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
      img1v1Id_str: convertValueByType(jsonRes['img1v1Id_str'], String,
          stack: "Artist-img1v1Id_str"),
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
        'img1v1Id_str': img1v1Id_str,
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
  String img1v1Id_str;

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
    this.img1v1Id_str,
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
      img1v1Id_str: convertValueByType(jsonRes['img1v1Id_str'], String,
          stack: "Artists-img1v1Id_str"),
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
        'img1v1Id_str': img1v1Id_str,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
