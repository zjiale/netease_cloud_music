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

class BannersModel {
  List<Banners> banners;
  int code;

  BannersModel({
    this.banners,
    this.code,
  });

  factory BannersModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Banners> banners = jsonRes['banners'] is List ? [] : null;
    if (banners != null) {
      for (var item in jsonRes['banners']) {
        if (item != null) {
          tryCatch(() {
            banners.add(Banners.fromJson(item));
          });
        }
      }
    }

    return BannersModel(
      banners: banners,
      code:
          convertValueByType(jsonRes['code'], int, stack: "BannersModel-code"),
    );
  }
  Map<String, dynamic> toJson() => {
        'banners': banners,
        'code': code,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Banners {
  String pic;
  int targetId;
  Object adid;
  int targetType;
  String titleColor;
  String typeTitle;
  Object url;
  Object adurlV2;
  bool exclusive;
  Object monitorImpress;
  Object monitorClick;
  Object monitorType;
  List<Object> monitorImpressList;
  List<Object> monitorClickList;
  Object monitorBlackList;
  Object extMonitor;
  Object extMonitorInfo;
  Object adSource;
  Object adLocation;
  String encodeId;
  Object program;
  Object event;
  Object video;
  Object dynamicVideoData;
  Song song;
  String bannerId;
  Object alg;
  String scm;
  String requestId;
  bool showAdTag;
  Object pid;
  Object showContext;
  Object adDispatchJson;

  Banners({
    this.pic,
    this.targetId,
    this.adid,
    this.targetType,
    this.titleColor,
    this.typeTitle,
    this.url,
    this.adurlV2,
    this.exclusive,
    this.monitorImpress,
    this.monitorClick,
    this.monitorType,
    this.monitorImpressList,
    this.monitorClickList,
    this.monitorBlackList,
    this.extMonitor,
    this.extMonitorInfo,
    this.adSource,
    this.adLocation,
    this.encodeId,
    this.program,
    this.event,
    this.video,
    this.dynamicVideoData,
    this.song,
    this.bannerId,
    this.alg,
    this.scm,
    this.requestId,
    this.showAdTag,
    this.pid,
    this.showContext,
    this.adDispatchJson,
  });

  factory Banners.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Object> monitorImpressList =
        jsonRes['monitorImpressList'] is List ? [] : null;
    if (monitorImpressList != null) {
      for (var item in jsonRes['monitorImpressList']) {
        if (item != null) {
          tryCatch(() {
            monitorImpressList.add(item);
          });
        }
      }
    }

    List<Object> monitorClickList =
        jsonRes['monitorClickList'] is List ? [] : null;
    if (monitorClickList != null) {
      for (var item in jsonRes['monitorClickList']) {
        if (item != null) {
          tryCatch(() {
            monitorClickList.add(item);
          });
        }
      }
    }

    return Banners(
      pic: convertValueByType(jsonRes['pic'], String, stack: "Banners-pic"),
      targetId: convertValueByType(jsonRes['targetId'], int,
          stack: "Banners-targetId"),
      adid: convertValueByType(jsonRes['adid'], Object, stack: "Banners-adid"),
      targetType: convertValueByType(jsonRes['targetType'], int,
          stack: "Banners-targetType"),
      titleColor: convertValueByType(jsonRes['titleColor'], String,
          stack: "Banners-titleColor"),
      typeTitle: convertValueByType(jsonRes['typeTitle'], String,
          stack: "Banners-typeTitle"),
      url: convertValueByType(jsonRes['url'], Object, stack: "Banners-url"),
      adurlV2: convertValueByType(jsonRes['adurlV2'], Object,
          stack: "Banners-adurlV2"),
      exclusive: convertValueByType(jsonRes['exclusive'], bool,
          stack: "Banners-exclusive"),
      monitorImpress: convertValueByType(jsonRes['monitorImpress'], Object,
          stack: "Banners-monitorImpress"),
      monitorClick: convertValueByType(jsonRes['monitorClick'], Object,
          stack: "Banners-monitorClick"),
      monitorType: convertValueByType(jsonRes['monitorType'], Object,
          stack: "Banners-monitorType"),
      monitorImpressList: monitorImpressList,
      monitorClickList: monitorClickList,
      monitorBlackList: convertValueByType(jsonRes['monitorBlackList'], Object,
          stack: "Banners-monitorBlackList"),
      extMonitor: convertValueByType(jsonRes['extMonitor'], Object,
          stack: "Banners-extMonitor"),
      extMonitorInfo: convertValueByType(jsonRes['extMonitorInfo'], Object,
          stack: "Banners-extMonitorInfo"),
      adSource: convertValueByType(jsonRes['adSource'], Object,
          stack: "Banners-adSource"),
      adLocation: convertValueByType(jsonRes['adLocation'], Object,
          stack: "Banners-adLocation"),
      encodeId: convertValueByType(jsonRes['encodeId'], String,
          stack: "Banners-encodeId"),
      program: convertValueByType(jsonRes['program'], Object,
          stack: "Banners-program"),
      event:
          convertValueByType(jsonRes['event'], Object, stack: "Banners-event"),
      video:
          convertValueByType(jsonRes['video'], Object, stack: "Banners-video"),
      dynamicVideoData: convertValueByType(jsonRes['dynamicVideoData'], Object,
          stack: "Banners-dynamicVideoData"),
      song: Song.fromJson(jsonRes['song']),
      bannerId: convertValueByType(jsonRes['bannerId'], String,
          stack: "Banners-bannerId"),
      alg: convertValueByType(jsonRes['alg'], Object, stack: "Banners-alg"),
      scm: convertValueByType(jsonRes['scm'], String, stack: "Banners-scm"),
      requestId: convertValueByType(jsonRes['requestId'], String,
          stack: "Banners-requestId"),
      showAdTag: convertValueByType(jsonRes['showAdTag'], bool,
          stack: "Banners-showAdTag"),
      pid: convertValueByType(jsonRes['pid'], Object, stack: "Banners-pid"),
      showContext: convertValueByType(jsonRes['showContext'], Object,
          stack: "Banners-showContext"),
      adDispatchJson: convertValueByType(jsonRes['adDispatchJson'], Object,
          stack: "Banners-adDispatchJson"),
    );
  }
  Map<String, dynamic> toJson() => {
        'pic': pic,
        'targetId': targetId,
        'adid': adid,
        'targetType': targetType,
        'titleColor': titleColor,
        'typeTitle': typeTitle,
        'url': url,
        'adurlV2': adurlV2,
        'exclusive': exclusive,
        'monitorImpress': monitorImpress,
        'monitorClick': monitorClick,
        'monitorType': monitorType,
        'monitorImpressList': monitorImpressList,
        'monitorClickList': monitorClickList,
        'monitorBlackList': monitorBlackList,
        'extMonitor': extMonitor,
        'extMonitorInfo': extMonitorInfo,
        'adSource': adSource,
        'adLocation': adLocation,
        'encodeId': encodeId,
        'program': program,
        'event': event,
        'video': video,
        'dynamicVideoData': dynamicVideoData,
        'song': song,
        'bannerId': bannerId,
        'alg': alg,
        'scm': scm,
        'requestId': requestId,
        'showAdTag': showAdTag,
        'pid': pid,
        'showContext': showContext,
        'adDispatchJson': adDispatchJson,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Song {
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
  Object rurl;
  int mst;
  int cp;
  int mv;
  int rtype;
  int publishTime;
  Privilege privilege;

  Song({
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
    this.rurl,
    this.mst,
    this.cp,
    this.mv,
    this.rtype,
    this.publishTime,
    this.privilege,
  });

  factory Song.fromJson(jsonRes) {
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

    return Song(
      name: convertValueByType(jsonRes['name'], String, stack: "Song-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Song-id"),
      pst: convertValueByType(jsonRes['pst'], int, stack: "Song-pst"),
      t: convertValueByType(jsonRes['t'], int, stack: "Song-t"),
      ar: ar,
      alia: alia,
      pop: convertValueByType(jsonRes['pop'], int, stack: "Song-pop"),
      st: convertValueByType(jsonRes['st'], int, stack: "Song-st"),
      rt: convertValueByType(jsonRes['rt'], String, stack: "Song-rt"),
      fee: convertValueByType(jsonRes['fee'], int, stack: "Song-fee"),
      v: convertValueByType(jsonRes['v'], int, stack: "Song-v"),
      crbt: convertValueByType(jsonRes['crbt'], Object, stack: "Song-crbt"),
      cf: convertValueByType(jsonRes['cf'], String, stack: "Song-cf"),
      al: Al.fromJson(jsonRes['al']),
      dt: convertValueByType(jsonRes['dt'], int, stack: "Song-dt"),
      h: H.fromJson(jsonRes['h']),
      m: M.fromJson(jsonRes['m']),
      l: L.fromJson(jsonRes['l']),
      a: convertValueByType(jsonRes['a'], Object, stack: "Song-a"),
      cd: convertValueByType(jsonRes['cd'], String, stack: "Song-cd"),
      no: convertValueByType(jsonRes['no'], int, stack: "Song-no"),
      rtUrl: convertValueByType(jsonRes['rtUrl'], Object, stack: "Song-rtUrl"),
      ftype: convertValueByType(jsonRes['ftype'], int, stack: "Song-ftype"),
      rtUrls: rtUrls,
      djId: convertValueByType(jsonRes['djId'], int, stack: "Song-djId"),
      copyright: convertValueByType(jsonRes['copyright'], int,
          stack: "Song-copyright"),
      s_id: convertValueByType(jsonRes['s_id'], int, stack: "Song-s_id"),
      mark: convertValueByType(jsonRes['mark'], int, stack: "Song-mark"),
      rurl: convertValueByType(jsonRes['rurl'], Object, stack: "Song-rurl"),
      mst: convertValueByType(jsonRes['mst'], int, stack: "Song-mst"),
      cp: convertValueByType(jsonRes['cp'], int, stack: "Song-cp"),
      mv: convertValueByType(jsonRes['mv'], int, stack: "Song-mv"),
      rtype: convertValueByType(jsonRes['rtype'], int, stack: "Song-rtype"),
      publishTime: convertValueByType(jsonRes['publishTime'], int,
          stack: "Song-publishTime"),
      privilege: Privilege.fromJson(jsonRes['privilege']),
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
        'rurl': rurl,
        'mst': mst,
        'cp': cp,
        'mv': mv,
        'rtype': rtype,
        'publishTime': publishTime,
        'privilege': privilege,
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
