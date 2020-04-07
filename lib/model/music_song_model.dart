import "package:flutter/material.dart";

class MusicSong {
  int id; // 歌曲id
  int mvid; //mv id
  int totalTime; //歌曲总时长
  int commentCount; //评论数量
  String name; // 歌曲名称
  String subName; // 歌曲翻译
  String artists; // 演唱者
  String album; // 专辑名
  String picUrl; // 歌曲图片
  int st; //歌曲状态
  bool isHighQuality; //是否高清
  bool isVip; //是否需要vip

  MusicSong(
      {this.id,
      this.mvid,
      this.totalTime,
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
    return '{"id": $id, "mvid": $mvid, "totalTime": $totalTime, "commentCount": $commentCount, "name": "$name", "subName": "$subName", "artists": "$artists", "album": "$album", "picUrl": "$picUrl", "st": $st, "isHighQuality": $isHighQuality, "isVip": $isVip}';
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
          totalTime: jsonRes['totalTime'],
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
        'totalTime': totalTime,
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
