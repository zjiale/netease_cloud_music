import "package:flutter/material.dart";

class MusicSong {
  /// 歌曲id
  int id;

  /// mv id
  int mvid;

  /// 歌曲总时长
  int duration;

  /// 评论数量
  int commentCount;

  /// 歌曲名称
  String name;

  /// 歌曲翻译
  String subName;

  /// 演唱者
  String artists;

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

  MusicSong(
      {this.id,
      this.mvid = 0,
      this.duration,
      this.commentCount,
      this.name,
      this.subName = "",
      this.artists,
      this.album,
      this.picUrl,
      this.st = 0,
      this.isHighQuality = false,
      this.isVip = false});

  @override
  String toString() {
    return '{"id": $id, "mvid": $mvid, "duration": $duration, "commentCount": $commentCount, "name": "$name", "subName": "$subName", "artists": "$artists", "album": "$album", "picUrl": "$picUrl",  "st": $st, "isHighQuality": $isHighQuality, "isVip": $isVip}';
  }

  factory MusicSong.fromJson(jsonRes) => jsonRes == null
      ? null
      : MusicSong(
          album: jsonRes['album'],
          artists: jsonRes['artists'],
          commentCount: jsonRes['commentCount'],
          id: jsonRes['id'],
          isHighQuality: jsonRes['isHighQuality'],
          isVip: jsonRes['isVip'],
          mvid: jsonRes['mvid'],
          name: jsonRes['name'],
          picUrl: jsonRes['picUrl'],
          st: jsonRes['st'],
          subName: jsonRes['subName'],
          duration: jsonRes['duration'],
        );
  Map<String, dynamic> toJson() => {
        'album': album,
        'artists': artists,
        'commentCount': commentCount,
        'id': id,
        'isHighQuality': isHighQuality,
        'isVip': isVip,
        'mvid': mvid,
        'name': name,
        'picUrl': picUrl,
        'st': st,
        'subName': subName,
        'duration': duration,
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
