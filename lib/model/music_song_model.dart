import "package:flutter/material.dart";

class MusicSong {
  /// 歌曲id
  int id;

  /// mv id
  int mvid;

  /// 歌曲总时长或者歌单总数量
  int total;

  /// 评论数量或者播放数量
  int count;

  /// 歌曲名称
  String name;

  /// 歌曲翻译
  String subName;

  /// 演唱者
  String artists;

  /// 演唱者名字翻译
  String artistsTrans;

  /// 专辑名
  String album;

  /// 图片
  String picUrl;

  ///歌曲状态
  int st;

  ///是否高清
  bool isHighQuality;

  ///是否需要vip

  bool isVip;

  /// 专辑发行时间
  int publishTime;

  MusicSong(
      {this.id,
      this.mvid = 0,
      this.total,
      this.count,
      this.name,
      this.subName = "",
      this.artists,
      this.artistsTrans,
      this.album,
      this.picUrl,
      this.publishTime = 0,
      this.st = 0,
      this.isHighQuality = false,
      this.isVip = false});

  @override
  String toString() {
    return '{"id": $id, "mvid": $mvid, "total": $total, "count": $count, "name": "$name", "subName": "$subName", "artists": "$artists", "artistsTrans": "$artistsTrans", "album": "$album", "picUrl": "$picUrl", "publishTime": "$publishTime", "st": $st, "isHighQuality": $isHighQuality, "isVip": $isVip}';
  }

  factory MusicSong.fromJson(jsonRes) => jsonRes == null
      ? null
      : MusicSong(
          album: jsonRes['album'],
          artists: jsonRes['artists'],
          artistsTrans: jsonRes['artistsTrans'],
          count: jsonRes['count'],
          id: jsonRes['id'],
          isHighQuality: jsonRes['isHighQuality'],
          isVip: jsonRes['isVip'],
          mvid: jsonRes['mvid'],
          name: jsonRes['name'],
          picUrl: jsonRes['picUrl'],
          publishTime: jsonRes['publishTime'],
          st: jsonRes['st'],
          subName: jsonRes['subName'],
          total: jsonRes['total'],
        );
  Map<String, dynamic> toJson() => {
        'album': album,
        'artists': artists,
        'artistsTrans': artistsTrans,
        'count': count,
        'id': id,
        'isHighQuality': isHighQuality,
        'isVip': isVip,
        'mvid': mvid,
        'name': name,
        'picUrl': picUrl,
        'publishTime': publishTime,
        'st': st,
        'subName': subName,
        'total': total,
      };

  void tryCatch(Function f) {
    try {
      f?.call();
    } catch (e, stack) {
      debugPrint("$e");
      debugPrint("$stack");
    }
  }
}
