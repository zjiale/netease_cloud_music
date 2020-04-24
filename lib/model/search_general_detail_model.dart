import 'dart:convert' show json;
import 'package:flutter/foundation.dart';
import 'package:netease_cloud_music/model/search_album_detail_model.dart'
    show Albums;
import 'package:netease_cloud_music/model/search_artists_detail_model.dart'
    show Artists;
import 'package:netease_cloud_music/model/search_playlist_detail_model.dart'
    show Playlists;
import 'package:netease_cloud_music/model/search_user_detail_model.dart'
    show Userprofiles;
import 'package:netease_cloud_music/model/search_video_detail_model.dart'
    show Videos;

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

class SearchGeneralDetailModel {
  int code;
  Result result;

  SearchGeneralDetailModel({
    this.code,
    this.result,
  });

  factory SearchGeneralDetailModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : SearchGeneralDetailModel(
          code: convertValueByType(jsonRes['code'], int,
              stack: "SearchGeneralDetailModel-code"),
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
  Album album;
  Artist artist;
  int code;
  DjRadio djRadio;
  Mlog mlog;
  List<String> order;
  PlayList playList;
  List<Object> recQuery;
  Object recType;
  Sim_query simQuery;
  Song song;
  Talk talk;
  User user;
  Video video;

  Result({
    this.album,
    this.artist,
    this.code,
    this.djRadio,
    this.mlog,
    this.order,
    this.playList,
    this.recQuery,
    this.recType,
    this.simQuery,
    this.song,
    this.talk,
    this.user,
    this.video,
  });

  factory Result.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<String> order = jsonRes['order'] is List ? [] : null;
    if (order != null) {
      for (var item in jsonRes['order']) {
        if (item != null) {
          tryCatch(() {
            order.add(item);
          });
        }
      }
    }

    List<Object> recQuery = jsonRes['rec_query'] is List ? [] : null;
    if (recQuery != null) {
      for (var item in jsonRes['rec_query']) {
        if (item != null) {
          tryCatch(() {
            recQuery.add(item);
          });
        }
      }
    }

    return Result(
      album: Album.fromJson(jsonRes['album']),
      artist: Artist.fromJson(jsonRes['artist']),
      code: convertValueByType(jsonRes['code'], int, stack: "Result-code"),
      djRadio: DjRadio.fromJson(jsonRes['djRadio']),
      mlog: Mlog.fromJson(jsonRes['mlog']),
      order: order,
      playList: PlayList.fromJson(jsonRes['playList']),
      recQuery: recQuery,
      recType: convertValueByType(jsonRes['rec_type'], Object,
          stack: "Result-rec_type"),
      simQuery: Sim_query.fromJson(jsonRes['sim_query']),
      song: Song.fromJson(jsonRes['song']),
      talk: Talk.fromJson(jsonRes['talk']),
      user: User.fromJson(jsonRes['user']),
      video: Video.fromJson(jsonRes['video']),
    );
  }
  Map<String, dynamic> toJson() => {
        'album': album,
        'artist': artist,
        'code': code,
        'djRadio': djRadio,
        'mlog': mlog,
        'order': order,
        'playList': playList,
        'rec_query': recQuery,
        'rec_type': recType,
        'sim_query': simQuery,
        'song': song,
        'talk': talk,
        'user': user,
        'video': video,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Song {
  bool more;
  String moreText;
  List<int> resourceIds;
  List<Songs> songs;

  Song({
    this.more,
    this.moreText,
    this.resourceIds,
    this.songs,
  });

  factory Song.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<int> resourceIds = jsonRes['resourceIds'] is List ? [] : null;
    if (resourceIds != null) {
      for (var item in jsonRes['resourceIds']) {
        if (item != null) {
          tryCatch(() {
            resourceIds.add(item);
          });
        }
      }
    }

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

    return Song(
      more: convertValueByType(jsonRes['more'], bool, stack: "Song-more"),
      moreText: convertValueByType(jsonRes['moreText'], String,
          stack: "Song-moreText"),
      resourceIds: resourceIds,
      songs: songs,
    );
  }
  Map<String, dynamic> toJson() => {
        'more': more,
        'moreText': moreText,
        'resourceIds': resourceIds,
        'songs': songs,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Songs {
  Object a;
  Al al;
  String alg;
  List<String> alia;
  List<Ar> ar;
  String cd;
  String cf;
  int copyright;
  int cp;
  Object crbt;
  int djId;
  int dt;
  int fee;
  int ftype;
  H h;
  int id;
  L l;
  M m;
  int mark;
  int mst;
  int mv;
  String name;
  int no;
  List<Object> officialTags;
  int originCoverType;
  int pop;
  Privilege privilege;
  int pst;
  int publishTime;
  String recommendText;
  String rt;
  Object rtUrl;
  List<Object> rtUrls;
  int rtype;
  Object rurl;
  bool showRecommend;
  int sId;
  int st;
  int t;
  int v;

  Songs({
    this.a,
    this.al,
    this.alg,
    this.alia,
    this.ar,
    this.cd,
    this.cf,
    this.copyright,
    this.cp,
    this.crbt,
    this.djId,
    this.dt,
    this.fee,
    this.ftype,
    this.h,
    this.id,
    this.l,
    this.m,
    this.mark,
    this.mst,
    this.mv,
    this.name,
    this.no,
    this.officialTags,
    this.originCoverType,
    this.pop,
    this.privilege,
    this.pst,
    this.publishTime,
    this.recommendText,
    this.rt,
    this.rtUrl,
    this.rtUrls,
    this.rtype,
    this.rurl,
    this.showRecommend,
    this.sId,
    this.st,
    this.t,
    this.v,
  });

  factory Songs.fromJson(jsonRes) {
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

    List<Object> officialTags = jsonRes['officialTags'] is List ? [] : null;
    if (officialTags != null) {
      for (var item in jsonRes['officialTags']) {
        if (item != null) {
          tryCatch(() {
            officialTags.add(item);
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
      a: convertValueByType(jsonRes['a'], Object, stack: "Songs-a"),
      al: Al.fromJson(jsonRes['al']),
      alg: convertValueByType(jsonRes['alg'], String, stack: "Songs-alg"),
      alia: alia,
      ar: ar,
      cd: convertValueByType(jsonRes['cd'], String, stack: "Songs-cd"),
      cf: convertValueByType(jsonRes['cf'], String, stack: "Songs-cf"),
      copyright: convertValueByType(jsonRes['copyright'], int,
          stack: "Songs-copyright"),
      cp: convertValueByType(jsonRes['cp'], int, stack: "Songs-cp"),
      crbt: convertValueByType(jsonRes['crbt'], Object, stack: "Songs-crbt"),
      djId: convertValueByType(jsonRes['djId'], int, stack: "Songs-djId"),
      dt: convertValueByType(jsonRes['dt'], int, stack: "Songs-dt"),
      fee: convertValueByType(jsonRes['fee'], int, stack: "Songs-fee"),
      ftype: convertValueByType(jsonRes['ftype'], int, stack: "Songs-ftype"),
      h: H.fromJson(jsonRes['h']),
      id: convertValueByType(jsonRes['id'], int, stack: "Songs-id"),
      l: L.fromJson(jsonRes['l']),
      m: M.fromJson(jsonRes['m']),
      mark: convertValueByType(jsonRes['mark'], int, stack: "Songs-mark"),
      mst: convertValueByType(jsonRes['mst'], int, stack: "Songs-mst"),
      mv: convertValueByType(jsonRes['mv'], int, stack: "Songs-mv"),
      name: convertValueByType(jsonRes['name'], String, stack: "Songs-name"),
      no: convertValueByType(jsonRes['no'], int, stack: "Songs-no"),
      officialTags: officialTags,
      originCoverType: convertValueByType(jsonRes['originCoverType'], int,
          stack: "Songs-originCoverType"),
      pop: convertValueByType(jsonRes['pop'], int, stack: "Songs-pop"),
      privilege: Privilege.fromJson(jsonRes['privilege']),
      pst: convertValueByType(jsonRes['pst'], int, stack: "Songs-pst"),
      publishTime: convertValueByType(jsonRes['publishTime'], int,
          stack: "Songs-publishTime"),
      recommendText: convertValueByType(jsonRes['recommendText'], String,
          stack: "Songs-recommendText"),
      rt: convertValueByType(jsonRes['rt'], String, stack: "Songs-rt"),
      rtUrl: convertValueByType(jsonRes['rtUrl'], Object, stack: "Songs-rtUrl"),
      rtUrls: rtUrls,
      rtype: convertValueByType(jsonRes['rtype'], int, stack: "Songs-rtype"),
      rurl: convertValueByType(jsonRes['rurl'], Object, stack: "Songs-rurl"),
      showRecommend: convertValueByType(jsonRes['showRecommend'], bool,
          stack: "Songs-showRecommend"),
      sId: convertValueByType(jsonRes['s_id'], int, stack: "Songs-s_id"),
      st: convertValueByType(jsonRes['st'], int, stack: "Songs-st"),
      t: convertValueByType(jsonRes['t'], int, stack: "Songs-t"),
      v: convertValueByType(jsonRes['v'], int, stack: "Songs-v"),
    );
  }
  Map<String, dynamic> toJson() => {
        'a': a,
        'al': al,
        'alg': alg,
        'alia': alia,
        'ar': ar,
        'cd': cd,
        'cf': cf,
        'copyright': copyright,
        'cp': cp,
        'crbt': crbt,
        'djId': djId,
        'dt': dt,
        'fee': fee,
        'ftype': ftype,
        'h': h,
        'id': id,
        'l': l,
        'm': m,
        'mark': mark,
        'mst': mst,
        'mv': mv,
        'name': name,
        'no': no,
        'officialTags': officialTags,
        'originCoverType': originCoverType,
        'pop': pop,
        'privilege': privilege,
        'pst': pst,
        'publishTime': publishTime,
        'recommendText': recommendText,
        'rt': rt,
        'rtUrl': rtUrl,
        'rtUrls': rtUrls,
        'rtype': rtype,
        'rurl': rurl,
        'showRecommend': showRecommend,
        's_id': sId,
        'st': st,
        't': t,
        'v': v,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Ar {
  List<String> alia;
  List<String> alias;
  int id;
  String name;
  List<Object> tns;

  Ar({
    this.alia,
    this.alias,
    this.id,
    this.name,
    this.tns,
  });

  factory Ar.fromJson(jsonRes) {
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

    return Ar(
      alia: alia,
      alias: alias,
      id: convertValueByType(jsonRes['id'], int, stack: "Ar-id"),
      name: convertValueByType(jsonRes['name'], String, stack: "Ar-name"),
      tns: tns,
    );
  }
  Map<String, dynamic> toJson() => {
        'alia': alia,
        'alias': alias,
        'id': id,
        'name': name,
        'tns': tns,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Al {
  int id;
  String name;
  int pic;
  String picUrl;
  List<Object> tns;

  Al({
    this.id,
    this.name,
    this.pic,
    this.picUrl,
    this.tns,
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
      pic: convertValueByType(jsonRes['pic'], int, stack: "Al-pic"),
      picUrl: convertValueByType(jsonRes['picUrl'], String, stack: "Al-picUrl"),
      tns: tns,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pic': pic,
        'picUrl': picUrl,
        'tns': tns,
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
  double vd;

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
          vd: convertValueByType(jsonRes['vd'], double, stack: "H-vd"),
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
  double vd;

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
          vd: convertValueByType(jsonRes['vd'], double, stack: "M-vd"),
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
  double vd;

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
          vd: convertValueByType(jsonRes['vd'], double, stack: "L-vd"),
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

class Privilege {
  int cp;
  bool cs;
  int dl;
  int fee;
  int fl;
  int flag;
  int id;
  int maxbr;
  int payed;
  int pl;
  int sp;
  int st;
  int subp;
  bool toast;

  Privilege({
    this.cp,
    this.cs,
    this.dl,
    this.fee,
    this.fl,
    this.flag,
    this.id,
    this.maxbr,
    this.payed,
    this.pl,
    this.sp,
    this.st,
    this.subp,
    this.toast,
  });

  factory Privilege.fromJson(jsonRes) => jsonRes == null
      ? null
      : Privilege(
          cp: convertValueByType(jsonRes['cp'], int, stack: "Privilege-cp"),
          cs: convertValueByType(jsonRes['cs'], bool, stack: "Privilege-cs"),
          dl: convertValueByType(jsonRes['dl'], int, stack: "Privilege-dl"),
          fee: convertValueByType(jsonRes['fee'], int, stack: "Privilege-fee"),
          fl: convertValueByType(jsonRes['fl'], int, stack: "Privilege-fl"),
          flag:
              convertValueByType(jsonRes['flag'], int, stack: "Privilege-flag"),
          id: convertValueByType(jsonRes['id'], int, stack: "Privilege-id"),
          maxbr: convertValueByType(jsonRes['maxbr'], int,
              stack: "Privilege-maxbr"),
          payed: convertValueByType(jsonRes['payed'], int,
              stack: "Privilege-payed"),
          pl: convertValueByType(jsonRes['pl'], int, stack: "Privilege-pl"),
          sp: convertValueByType(jsonRes['sp'], int, stack: "Privilege-sp"),
          st: convertValueByType(jsonRes['st'], int, stack: "Privilege-st"),
          subp:
              convertValueByType(jsonRes['subp'], int, stack: "Privilege-subp"),
          toast: convertValueByType(jsonRes['toast'], bool,
              stack: "Privilege-toast"),
        );
  Map<String, dynamic> toJson() => {
        'cp': cp,
        'cs': cs,
        'dl': dl,
        'fee': fee,
        'fl': fl,
        'flag': flag,
        'id': id,
        'maxbr': maxbr,
        'payed': payed,
        'pl': pl,
        'sp': sp,
        'st': st,
        'subp': subp,
        'toast': toast,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Mlog {
  List<Mlogs> mlogs;
  bool more;
  String moreText;
  List<Object> resourceIds;

  Mlog({
    this.mlogs,
    this.more,
    this.moreText,
    this.resourceIds,
  });

  factory Mlog.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Mlogs> mlogs = jsonRes['mlogs'] is List ? [] : null;
    if (mlogs != null) {
      for (var item in jsonRes['mlogs']) {
        if (item != null) {
          tryCatch(() {
            mlogs.add(Mlogs.fromJson(item));
          });
        }
      }
    }

    List<Object> resourceIds = jsonRes['resourceIds'] is List ? [] : null;
    if (resourceIds != null) {
      for (var item in jsonRes['resourceIds']) {
        if (item != null) {
          tryCatch(() {
            resourceIds.add(item);
          });
        }
      }
    }

    return Mlog(
      mlogs: mlogs,
      more: convertValueByType(jsonRes['more'], bool, stack: "Mlog-more"),
      moreText: convertValueByType(jsonRes['moreText'], String,
          stack: "Mlog-moreText"),
      resourceIds: resourceIds,
    );
  }
  Map<String, dynamic> toJson() => {
        'mlogs': mlogs,
        'more': more,
        'moreText': moreText,
        'resourceIds': resourceIds,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Mlogs {
  String alg;
  String id;
  int matchField;
  String matchFieldContent;
  Object position;
  Object reason;
  Resource resource;
  bool sameCity;
  int type;

  Mlogs({
    this.alg,
    this.id,
    this.matchField,
    this.matchFieldContent,
    this.position,
    this.reason,
    this.resource,
    this.sameCity,
    this.type,
  });

  factory Mlogs.fromJson(jsonRes) => jsonRes == null
      ? null
      : Mlogs(
          alg: convertValueByType(jsonRes['alg'], String, stack: "Mlogs-alg"),
          id: convertValueByType(jsonRes['id'], String, stack: "Mlogs-id"),
          matchField: convertValueByType(jsonRes['matchField'], int,
              stack: "Mlogs-matchField"),
          matchFieldContent: convertValueByType(
              jsonRes['matchFieldContent'], String,
              stack: "Mlogs-matchFieldContent"),
          position: convertValueByType(jsonRes['position'], Object,
              stack: "Mlogs-position"),
          reason: convertValueByType(jsonRes['reason'], Object,
              stack: "Mlogs-reason"),
          resource: Resource.fromJson(jsonRes['resource']),
          sameCity: convertValueByType(jsonRes['sameCity'], bool,
              stack: "Mlogs-sameCity"),
          type: convertValueByType(jsonRes['type'], int, stack: "Mlogs-type"),
        );
  Map<String, dynamic> toJson() => {
        'alg': alg,
        'id': id,
        'matchField': matchField,
        'matchFieldContent': matchFieldContent,
        'position': position,
        'reason': reason,
        'resource': resource,
        'sameCity': sameCity,
        'type': type,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Resource {
  MlogBaseData mlogBaseData;
  MlogExtVO mlogExtVO;
  String shareUrl;
  int status;
  UserProfile userProfile;

  Resource({
    this.mlogBaseData,
    this.mlogExtVO,
    this.shareUrl,
    this.status,
    this.userProfile,
  });

  factory Resource.fromJson(jsonRes) => jsonRes == null
      ? null
      : Resource(
          mlogBaseData: MlogBaseData.fromJson(jsonRes['mlogBaseData']),
          mlogExtVO: MlogExtVO.fromJson(jsonRes['mlogExtVO']),
          shareUrl: convertValueByType(jsonRes['shareUrl'], String,
              stack: "Resource-shareUrl"),
          status: convertValueByType(jsonRes['status'], int,
              stack: "Resource-status"),
          userProfile: UserProfile.fromJson(jsonRes['userProfile']),
        );
  Map<String, dynamic> toJson() => {
        'mlogBaseData': mlogBaseData,
        'mlogExtVO': mlogExtVO,
        'shareUrl': shareUrl,
        'status': status,
        'userProfile': userProfile,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class MlogBaseData {
  Object audioDTO;
  int coverColor;
  Object coverDynamicUrl;
  int coverHeight;
  String coverUrl;
  int coverWidth;
  String id;
  Object interveneText;
  Object mlogLocationDTO;
  int pubTime;
  ResourceTalk talk;
  String text;
  Object threadId;
  int type;

  MlogBaseData({
    this.audioDTO,
    this.coverColor,
    this.coverDynamicUrl,
    this.coverHeight,
    this.coverUrl,
    this.coverWidth,
    this.id,
    this.interveneText,
    this.mlogLocationDTO,
    this.pubTime,
    this.talk,
    this.text,
    this.threadId,
    this.type,
  });

  factory MlogBaseData.fromJson(jsonRes) => jsonRes == null
      ? null
      : MlogBaseData(
          audioDTO: convertValueByType(jsonRes['audioDTO'], Object,
              stack: "MlogBaseData-audioDTO"),
          coverColor: convertValueByType(jsonRes['coverColor'], int,
              stack: "MlogBaseData-coverColor"),
          coverDynamicUrl: convertValueByType(
              jsonRes['coverDynamicUrl'], Object,
              stack: "MlogBaseData-coverDynamicUrl"),
          coverHeight: convertValueByType(jsonRes['coverHeight'], int,
              stack: "MlogBaseData-coverHeight"),
          coverUrl: convertValueByType(jsonRes['coverUrl'], String,
              stack: "MlogBaseData-coverUrl"),
          coverWidth: convertValueByType(jsonRes['coverWidth'], int,
              stack: "MlogBaseData-coverWidth"),
          id: convertValueByType(jsonRes['id'], String,
              stack: "MlogBaseData-id"),
          interveneText: convertValueByType(jsonRes['interveneText'], Object,
              stack: "MlogBaseData-interveneText"),
          mlogLocationDTO: convertValueByType(
              jsonRes['mlogLocationDTO'], Object,
              stack: "MlogBaseData-mlogLocationDTO"),
          pubTime: convertValueByType(jsonRes['pubTime'], int,
              stack: "MlogBaseData-pubTime"),
          talk: ResourceTalk.fromJson(jsonRes['talk']),
          text: convertValueByType(jsonRes['text'], String,
              stack: "MlogBaseData-text"),
          threadId: convertValueByType(jsonRes['threadId'], Object,
              stack: "MlogBaseData-threadId"),
          type: convertValueByType(jsonRes['type'], int,
              stack: "MlogBaseData-type"),
        );
  Map<String, dynamic> toJson() => {
        'audioDTO': audioDTO,
        'coverColor': coverColor,
        'coverDynamicUrl': coverDynamicUrl,
        'coverHeight': coverHeight,
        'coverUrl': coverUrl,
        'coverWidth': coverWidth,
        'id': id,
        'interveneText': interveneText,
        'mlogLocationDTO': mlogLocationDTO,
        'pubTime': pubTime,
        'talk': talk,
        'text': text,
        'threadId': threadId,
        'type': type,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ResourceTalk {
  bool isFollow;
  Object participations;
  int talkId;
  String talkName;

  ResourceTalk({
    this.isFollow,
    this.participations,
    this.talkId,
    this.talkName,
  });

  factory ResourceTalk.fromJson(jsonRes) => jsonRes == null
      ? null
      : ResourceTalk(
          isFollow: convertValueByType(jsonRes['isFollow'], bool,
              stack: "ResourceTalk-isFollow"),
          participations: convertValueByType(jsonRes['participations'], Object,
              stack: "ResourceTalk-participations"),
          talkId: convertValueByType(jsonRes['talkId'], int,
              stack: "ResourceTalk-talkId"),
          talkName: convertValueByType(jsonRes['talkName'], String,
              stack: "ResourceTalk-talkName"),
        );
  Map<String, dynamic> toJson() => {
        'isFollow': isFollow,
        'participations': participations,
        'talkId': talkId,
        'talkName': talkName,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class MlogExtVO {
  int commentCount;
  int likedCount;

  MlogExtVO({
    this.commentCount,
    this.likedCount,
  });

  factory MlogExtVO.fromJson(jsonRes) => jsonRes == null
      ? null
      : MlogExtVO(
          commentCount: convertValueByType(jsonRes['commentCount'], int,
              stack: "MlogExtVO-commentCount"),
          likedCount: convertValueByType(jsonRes['likedCount'], int,
              stack: "MlogExtVO-likedCount"),
        );
  Map<String, dynamic> toJson() => {
        'commentCount': commentCount,
        'likedCount': likedCount,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class UserProfile {
  String avatarUrl;
  bool followed;
  bool isAnchor;
  String nickname;
  int userId;
  int userType;

  UserProfile({
    this.avatarUrl,
    this.followed,
    this.isAnchor,
    this.nickname,
    this.userId,
    this.userType,
  });

  factory UserProfile.fromJson(jsonRes) => jsonRes == null
      ? null
      : UserProfile(
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "UserProfile-avatarUrl"),
          followed: convertValueByType(jsonRes['followed'], bool,
              stack: "UserProfile-followed"),
          isAnchor: convertValueByType(jsonRes['isAnchor'], bool,
              stack: "UserProfile-isAnchor"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "UserProfile-nickname"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "UserProfile-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "UserProfile-userType"),
        );
  Map<String, dynamic> toJson() => {
        'avatarUrl': avatarUrl,
        'followed': followed,
        'isAnchor': isAnchor,
        'nickname': nickname,
        'userId': userId,
        'userType': userType,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class PlayList {
  bool more;
  String moreText;
  List<Playlists> playLists;
  List<int> resourceIds;

  PlayList({
    this.more,
    this.moreText,
    this.playLists,
    this.resourceIds,
  });

  factory PlayList.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Playlists> playLists = jsonRes['playLists'] is List ? [] : null;
    if (playLists != null) {
      for (var item in jsonRes['playLists']) {
        if (item != null) {
          tryCatch(() {
            playLists.add(Playlists.fromJson(item));
          });
        }
      }
    }

    List<int> resourceIds = jsonRes['resourceIds'] is List ? [] : null;
    if (resourceIds != null) {
      for (var item in jsonRes['resourceIds']) {
        if (item != null) {
          tryCatch(() {
            resourceIds.add(item);
          });
        }
      }
    }

    return PlayList(
      more: convertValueByType(jsonRes['more'], bool, stack: "PlayList-more"),
      moreText: convertValueByType(jsonRes['moreText'], String,
          stack: "PlayList-moreText"),
      playLists: playLists,
      resourceIds: resourceIds,
    );
  }
  Map<String, dynamic> toJson() => {
        'more': more,
        'moreText': moreText,
        'playLists': playLists,
        'resourceIds': resourceIds,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Artist {
  List<Artists> artists;
  bool more;
  String moreText;
  List<int> resourceIds;

  Artist({
    this.artists,
    this.more,
    this.moreText,
    this.resourceIds,
  });

  factory Artist.fromJson(jsonRes) {
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

    List<int> resourceIds = jsonRes['resourceIds'] is List ? [] : null;
    if (resourceIds != null) {
      for (var item in jsonRes['resourceIds']) {
        if (item != null) {
          tryCatch(() {
            resourceIds.add(item);
          });
        }
      }
    }

    return Artist(
      artists: artists,
      more: convertValueByType(jsonRes['more'], bool, stack: "Artist-more"),
      moreText: convertValueByType(jsonRes['moreText'], String,
          stack: "Artist-moreText"),
      resourceIds: resourceIds,
    );
  }
  Map<String, dynamic> toJson() => {
        'artists': artists,
        'more': more,
        'moreText': moreText,
        'resourceIds': resourceIds,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Album {
  List<Albums> albums;
  bool more;
  String moreText;
  List<int> resourceIds;

  Album({
    this.albums,
    this.more,
    this.moreText,
    this.resourceIds,
  });

  factory Album.fromJson(jsonRes) {
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

    List<int> resourceIds = jsonRes['resourceIds'] is List ? [] : null;
    if (resourceIds != null) {
      for (var item in jsonRes['resourceIds']) {
        if (item != null) {
          tryCatch(() {
            resourceIds.add(item);
          });
        }
      }
    }

    return Album(
      albums: albums,
      more: convertValueByType(jsonRes['more'], bool, stack: "Album-more"),
      moreText: convertValueByType(jsonRes['moreText'], String,
          stack: "Album-moreText"),
      resourceIds: resourceIds,
    );
  }
  Map<String, dynamic> toJson() => {
        'albums': albums,
        'more': more,
        'moreText': moreText,
        'resourceIds': resourceIds,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Video {
  bool more;
  String moreText;
  List<int> resourceIds;
  List<Videos> videos;

  Video({
    this.more,
    this.moreText,
    this.resourceIds,
    this.videos,
  });

  factory Video.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<int> resourceIds = jsonRes['resourceIds'] is List ? [] : null;
    if (resourceIds != null) {
      for (var item in jsonRes['resourceIds']) {
        if (item != null) {
          tryCatch(() {
            resourceIds.add(item);
          });
        }
      }
    }

    List<Videos> videos = jsonRes['videos'] is List ? [] : null;
    if (videos != null) {
      for (var item in jsonRes['videos']) {
        if (item != null) {
          tryCatch(() {
            videos.add(Videos.fromJson(item));
          });
        }
      }
    }

    return Video(
      more: convertValueByType(jsonRes['more'], bool, stack: "Video-more"),
      moreText: convertValueByType(jsonRes['moreText'], String,
          stack: "Video-moreText"),
      resourceIds: resourceIds,
      videos: videos,
    );
  }
  Map<String, dynamic> toJson() => {
        'more': more,
        'moreText': moreText,
        'resourceIds': resourceIds,
        'videos': videos,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Sim_query {
  bool more;
  List<Sim_querys> simQuerys;

  Sim_query({
    this.more,
    this.simQuerys,
  });

  factory Sim_query.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Sim_querys> simQuerys = jsonRes['sim_querys'] is List ? [] : null;
    if (simQuerys != null) {
      for (var item in jsonRes['sim_querys']) {
        if (item != null) {
          tryCatch(() {
            simQuerys.add(Sim_querys.fromJson(item));
          });
        }
      }
    }

    return Sim_query(
      more: convertValueByType(jsonRes['more'], bool, stack: "Sim_query-more"),
      simQuerys: simQuerys,
    );
  }
  Map<String, dynamic> toJson() => {
        'more': more,
        'sim_querys': simQuerys,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Sim_querys {
  String alg;
  String keyword;

  Sim_querys({
    this.alg,
    this.keyword,
  });

  factory Sim_querys.fromJson(jsonRes) => jsonRes == null
      ? null
      : Sim_querys(
          alg: convertValueByType(jsonRes['alg'], String,
              stack: "Sim_querys-alg"),
          keyword: convertValueByType(jsonRes['keyword'], String,
              stack: "Sim_querys-keyword"),
        );
  Map<String, dynamic> toJson() => {
        'alg': alg,
        'keyword': keyword,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class DjRadio {
  List<DjRadios> djRadios;
  bool more;
  String moreText;
  List<int> resourceIds;

  DjRadio({
    this.djRadios,
    this.more,
    this.moreText,
    this.resourceIds,
  });

  factory DjRadio.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<DjRadios> djRadios = jsonRes['djRadios'] is List ? [] : null;
    if (djRadios != null) {
      for (var item in jsonRes['djRadios']) {
        if (item != null) {
          tryCatch(() {
            djRadios.add(DjRadios.fromJson(item));
          });
        }
      }
    }

    List<int> resourceIds = jsonRes['resourceIds'] is List ? [] : null;
    if (resourceIds != null) {
      for (var item in jsonRes['resourceIds']) {
        if (item != null) {
          tryCatch(() {
            resourceIds.add(item);
          });
        }
      }
    }

    return DjRadio(
      djRadios: djRadios,
      more: convertValueByType(jsonRes['more'], bool, stack: "DjRadio-more"),
      moreText: convertValueByType(jsonRes['moreText'], String,
          stack: "DjRadio-moreText"),
      resourceIds: resourceIds,
    );
  }
  Map<String, dynamic> toJson() => {
        'djRadios': djRadios,
        'more': more,
        'moreText': moreText,
        'resourceIds': resourceIds,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class DjRadios {
  String alg;
  bool buyed;
  String category;
  int categoryId;
  int commentCount;
  bool composeVideo;
  int createTime;
  String desc;
  Object discountPrice;
  Dj dj;
  int feeScope;
  bool finished;
  int id;
  int lastProgramCreateTime;
  int lastProgramId;
  String lastProgramName;
  int likedCount;
  String name;
  int originalPrice;
  int picId;
  String picUrl;
  int price;
  int programCount;
  int purchaseCount;
  int radioFeeType;
  Object rcmdtext;
  Object rcmdText;
  int shareCount;
  int subCount;
  bool underShelf;
  Object videos;

  DjRadios({
    this.alg,
    this.buyed,
    this.category,
    this.categoryId,
    this.commentCount,
    this.composeVideo,
    this.createTime,
    this.desc,
    this.discountPrice,
    this.dj,
    this.feeScope,
    this.finished,
    this.id,
    this.lastProgramCreateTime,
    this.lastProgramId,
    this.lastProgramName,
    this.likedCount,
    this.name,
    this.originalPrice,
    this.picId,
    this.picUrl,
    this.price,
    this.programCount,
    this.purchaseCount,
    this.radioFeeType,
    this.rcmdtext,
    this.rcmdText,
    this.shareCount,
    this.subCount,
    this.underShelf,
    this.videos,
  });

  factory DjRadios.fromJson(jsonRes) => jsonRes == null
      ? null
      : DjRadios(
          alg:
              convertValueByType(jsonRes['alg'], String, stack: "DjRadios-alg"),
          buyed: convertValueByType(jsonRes['buyed'], bool,
              stack: "DjRadios-buyed"),
          category: convertValueByType(jsonRes['category'], String,
              stack: "DjRadios-category"),
          categoryId: convertValueByType(jsonRes['categoryId'], int,
              stack: "DjRadios-categoryId"),
          commentCount: convertValueByType(jsonRes['commentCount'], int,
              stack: "DjRadios-commentCount"),
          composeVideo: convertValueByType(jsonRes['composeVideo'], bool,
              stack: "DjRadios-composeVideo"),
          createTime: convertValueByType(jsonRes['createTime'], int,
              stack: "DjRadios-createTime"),
          desc: convertValueByType(jsonRes['desc'], String,
              stack: "DjRadios-desc"),
          discountPrice: convertValueByType(jsonRes['discountPrice'], Object,
              stack: "DjRadios-discountPrice"),
          dj: Dj.fromJson(jsonRes['dj']),
          feeScope: convertValueByType(jsonRes['feeScope'], int,
              stack: "DjRadios-feeScope"),
          finished: convertValueByType(jsonRes['finished'], bool,
              stack: "DjRadios-finished"),
          id: convertValueByType(jsonRes['id'], int, stack: "DjRadios-id"),
          lastProgramCreateTime: convertValueByType(
              jsonRes['lastProgramCreateTime'], int,
              stack: "DjRadios-lastProgramCreateTime"),
          lastProgramId: convertValueByType(jsonRes['lastProgramId'], int,
              stack: "DjRadios-lastProgramId"),
          lastProgramName: convertValueByType(
              jsonRes['lastProgramName'], String,
              stack: "DjRadios-lastProgramName"),
          likedCount: convertValueByType(jsonRes['likedCount'], int,
              stack: "DjRadios-likedCount"),
          name: convertValueByType(jsonRes['name'], String,
              stack: "DjRadios-name"),
          originalPrice: convertValueByType(jsonRes['originalPrice'], int,
              stack: "DjRadios-originalPrice"),
          picId: convertValueByType(jsonRes['picId'], int,
              stack: "DjRadios-picId"),
          picUrl: convertValueByType(jsonRes['picUrl'], String,
              stack: "DjRadios-picUrl"),
          price: convertValueByType(jsonRes['price'], int,
              stack: "DjRadios-price"),
          programCount: convertValueByType(jsonRes['programCount'], int,
              stack: "DjRadios-programCount"),
          purchaseCount: convertValueByType(jsonRes['purchaseCount'], int,
              stack: "DjRadios-purchaseCount"),
          radioFeeType: convertValueByType(jsonRes['radioFeeType'], int,
              stack: "DjRadios-radioFeeType"),
          rcmdtext: convertValueByType(jsonRes['rcmdtext'], Object,
              stack: "DjRadios-rcmdtext"),
          rcmdText: convertValueByType(jsonRes['rcmdText'], Object,
              stack: "DjRadios-rcmdText"),
          shareCount: convertValueByType(jsonRes['shareCount'], int,
              stack: "DjRadios-shareCount"),
          subCount: convertValueByType(jsonRes['subCount'], int,
              stack: "DjRadios-subCount"),
          underShelf: convertValueByType(jsonRes['underShelf'], bool,
              stack: "DjRadios-underShelf"),
          videos: convertValueByType(jsonRes['videos'], Object,
              stack: "DjRadios-videos"),
        );
  Map<String, dynamic> toJson() => {
        'alg': alg,
        'buyed': buyed,
        'category': category,
        'categoryId': categoryId,
        'commentCount': commentCount,
        'composeVideo': composeVideo,
        'createTime': createTime,
        'desc': desc,
        'discountPrice': discountPrice,
        'dj': dj,
        'feeScope': feeScope,
        'finished': finished,
        'id': id,
        'lastProgramCreateTime': lastProgramCreateTime,
        'lastProgramId': lastProgramId,
        'lastProgramName': lastProgramName,
        'likedCount': likedCount,
        'name': name,
        'originalPrice': originalPrice,
        'picId': picId,
        'picUrl': picUrl,
        'price': price,
        'programCount': programCount,
        'purchaseCount': purchaseCount,
        'radioFeeType': radioFeeType,
        'rcmdtext': rcmdtext,
        'rcmdText': rcmdText,
        'shareCount': shareCount,
        'subCount': subCount,
        'underShelf': underShelf,
        'videos': videos,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Dj {
  int accountStatus;
  bool anchor;
  int authenticationTypes;
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

  Dj({
    this.accountStatus,
    this.anchor,
    this.authenticationTypes,
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

  factory Dj.fromJson(jsonRes) => jsonRes == null
      ? null
      : Dj(
          accountStatus: convertValueByType(jsonRes['accountStatus'], int,
              stack: "Dj-accountStatus"),
          anchor:
              convertValueByType(jsonRes['anchor'], bool, stack: "Dj-anchor"),
          authenticationTypes: convertValueByType(
              jsonRes['authenticationTypes'], int,
              stack: "Dj-authenticationTypes"),
          authority: convertValueByType(jsonRes['authority'], int,
              stack: "Dj-authority"),
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "Dj-authStatus"),
          avatarImgId: convertValueByType(jsonRes['avatarImgId'], int,
              stack: "Dj-avatarImgId"),
          avatarimgidStr: convertValueByType(jsonRes['avatarImgId_str'], String,
              stack: "Dj-avatarImgId_str"),
          avatarImgIdStr: convertValueByType(jsonRes['avatarImgIdStr'], String,
              stack: "Dj-avatarImgIdStr"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "Dj-avatarUrl"),
          backgroundImgId: convertValueByType(jsonRes['backgroundImgId'], int,
              stack: "Dj-backgroundImgId"),
          backgroundImgIdStr: convertValueByType(
              jsonRes['backgroundImgIdStr'], String,
              stack: "Dj-backgroundImgIdStr"),
          backgroundUrl: convertValueByType(jsonRes['backgroundUrl'], String,
              stack: "Dj-backgroundUrl"),
          birthday: convertValueByType(jsonRes['birthday'], int,
              stack: "Dj-birthday"),
          city: convertValueByType(jsonRes['city'], int, stack: "Dj-city"),
          defaultAvatar: convertValueByType(jsonRes['defaultAvatar'], bool,
              stack: "Dj-defaultAvatar"),
          description: convertValueByType(jsonRes['description'], String,
              stack: "Dj-description"),
          detailDescription: convertValueByType(
              jsonRes['detailDescription'], String,
              stack: "Dj-detailDescription"),
          djStatus: convertValueByType(jsonRes['djStatus'], int,
              stack: "Dj-djStatus"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "Dj-experts"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "Dj-expertTags"),
          followed: convertValueByType(jsonRes['followed'], bool,
              stack: "Dj-followed"),
          gender:
              convertValueByType(jsonRes['gender'], int, stack: "Dj-gender"),
          mutual:
              convertValueByType(jsonRes['mutual'], bool, stack: "Dj-mutual"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "Dj-nickname"),
          province: convertValueByType(jsonRes['province'], int,
              stack: "Dj-province"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "Dj-remarkName"),
          signature: convertValueByType(jsonRes['signature'], String,
              stack: "Dj-signature"),
          userId:
              convertValueByType(jsonRes['userId'], int, stack: "Dj-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "Dj-userType"),
          vipType:
              convertValueByType(jsonRes['vipType'], int, stack: "Dj-vipType"),
        );
  Map<String, dynamic> toJson() => {
        'accountStatus': accountStatus,
        'anchor': anchor,
        'authenticationTypes': authenticationTypes,
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

class Talk {
  bool more;
  List<int> resourceIds;
  List<Talks> talks;

  Talk({
    this.more,
    this.resourceIds,
    this.talks,
  });

  factory Talk.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<int> resourceIds = jsonRes['resourceIds'] is List ? [] : null;
    if (resourceIds != null) {
      for (var item in jsonRes['resourceIds']) {
        if (item != null) {
          tryCatch(() {
            resourceIds.add(item);
          });
        }
      }
    }

    List<Talks> talks = jsonRes['talks'] is List ? [] : null;
    if (talks != null) {
      for (var item in jsonRes['talks']) {
        if (item != null) {
          tryCatch(() {
            talks.add(Talks.fromJson(item));
          });
        }
      }
    }

    return Talk(
      more: convertValueByType(jsonRes['more'], bool, stack: "Talk-more"),
      resourceIds: resourceIds,
      talks: talks,
    );
  }
  Map<String, dynamic> toJson() => {
        'more': more,
        'resourceIds': resourceIds,
        'talks': talks,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Talks {
  String alg;
  int follows;
  bool hasTag;
  int mlogCount;
  int participations;
  ShareCover shareCover;
  ShowCover showCover;
  int showParticipations;
  int status;
  String talkDes;
  int talkId;
  String talkName;
  Object time;

  Talks({
    this.alg,
    this.follows,
    this.hasTag,
    this.mlogCount,
    this.participations,
    this.shareCover,
    this.showCover,
    this.showParticipations,
    this.status,
    this.talkDes,
    this.talkId,
    this.talkName,
    this.time,
  });

  factory Talks.fromJson(jsonRes) => jsonRes == null
      ? null
      : Talks(
          alg: convertValueByType(jsonRes['alg'], String, stack: "Talks-alg"),
          follows: convertValueByType(jsonRes['follows'], int,
              stack: "Talks-follows"),
          hasTag: convertValueByType(jsonRes['hasTag'], bool,
              stack: "Talks-hasTag"),
          mlogCount: convertValueByType(jsonRes['mlogCount'], int,
              stack: "Talks-mlogCount"),
          participations: convertValueByType(jsonRes['participations'], int,
              stack: "Talks-participations"),
          shareCover: ShareCover.fromJson(jsonRes['shareCover']),
          showCover: ShowCover.fromJson(jsonRes['showCover']),
          showParticipations: convertValueByType(
              jsonRes['showParticipations'], int,
              stack: "Talks-showParticipations"),
          status:
              convertValueByType(jsonRes['status'], int, stack: "Talks-status"),
          talkDes: convertValueByType(jsonRes['talkDes'], String,
              stack: "Talks-talkDes"),
          talkId:
              convertValueByType(jsonRes['talkId'], int, stack: "Talks-talkId"),
          talkName: convertValueByType(jsonRes['talkName'], String,
              stack: "Talks-talkName"),
          time:
              convertValueByType(jsonRes['time'], Object, stack: "Talks-time"),
        );
  Map<String, dynamic> toJson() => {
        'alg': alg,
        'follows': follows,
        'hasTag': hasTag,
        'mlogCount': mlogCount,
        'participations': participations,
        'shareCover': shareCover,
        'showCover': showCover,
        'showParticipations': showParticipations,
        'status': status,
        'talkDes': talkDes,
        'talkId': talkId,
        'talkName': talkName,
        'time': time,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ShareCover {
  int height;
  String nosKey;
  String picKey;
  String url;
  int width;

  ShareCover({
    this.height,
    this.nosKey,
    this.picKey,
    this.url,
    this.width,
  });

  factory ShareCover.fromJson(jsonRes) => jsonRes == null
      ? null
      : ShareCover(
          height: convertValueByType(jsonRes['height'], int,
              stack: "ShareCover-height"),
          nosKey: convertValueByType(jsonRes['nosKey'], String,
              stack: "ShareCover-nosKey"),
          picKey: convertValueByType(jsonRes['picKey'], String,
              stack: "ShareCover-picKey"),
          url: convertValueByType(jsonRes['url'], String,
              stack: "ShareCover-url"),
          width: convertValueByType(jsonRes['width'], int,
              stack: "ShareCover-width"),
        );
  Map<String, dynamic> toJson() => {
        'height': height,
        'nosKey': nosKey,
        'picKey': picKey,
        'url': url,
        'width': width,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ShowCover {
  int height;
  String nosKey;
  String picKey;
  String url;
  int width;

  ShowCover({
    this.height,
    this.nosKey,
    this.picKey,
    this.url,
    this.width,
  });

  factory ShowCover.fromJson(jsonRes) => jsonRes == null
      ? null
      : ShowCover(
          height: convertValueByType(jsonRes['height'], int,
              stack: "ShowCover-height"),
          nosKey: convertValueByType(jsonRes['nosKey'], String,
              stack: "ShowCover-nosKey"),
          picKey: convertValueByType(jsonRes['picKey'], String,
              stack: "ShowCover-picKey"),
          url: convertValueByType(jsonRes['url'], String,
              stack: "ShowCover-url"),
          width: convertValueByType(jsonRes['width'], int,
              stack: "ShowCover-width"),
        );
  Map<String, dynamic> toJson() => {
        'height': height,
        'nosKey': nosKey,
        'picKey': picKey,
        'url': url,
        'width': width,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class User {
  bool more;
  String moreText;
  List<int> resourceIds;
  List<Userprofiles> users;

  User({
    this.more,
    this.moreText,
    this.resourceIds,
    this.users,
  });

  factory User.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<int> resourceIds = jsonRes['resourceIds'] is List ? [] : null;
    if (resourceIds != null) {
      for (var item in jsonRes['resourceIds']) {
        if (item != null) {
          tryCatch(() {
            resourceIds.add(item);
          });
        }
      }
    }

    List<Userprofiles> users = jsonRes['users'] is List ? [] : null;
    if (users != null) {
      for (var item in jsonRes['users']) {
        if (item != null) {
          tryCatch(() {
            users.add(Userprofiles.fromJson(item));
          });
        }
      }
    }

    return User(
      more: convertValueByType(jsonRes['more'], bool, stack: "User-more"),
      moreText: convertValueByType(jsonRes['moreText'], String,
          stack: "User-moreText"),
      resourceIds: resourceIds,
      users: users,
    );
  }
  Map<String, dynamic> toJson() => {
        'more': more,
        'moreText': moreText,
        'resourceIds': resourceIds,
        'users': users,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
