class MusicSong {
  int id; // 歌曲id
  int mvid; //mv id
  int totalTime; //歌曲总时长
  String name; // 歌曲名称
  String subName; // 歌曲翻译
  String artists; // 演唱者
  String album; // 专辑名
  String picUrl; // 歌曲图片
  int st; //歌曲状态
  bool isHighQuality; //是否高清
  bool isVip; //是否需要vip

  MusicSong(this.id,
      {this.mvid,
      this.totalTime,
      this.name,
      this.subName = '',
      this.artists,
      this.album,
      this.picUrl,
      this.st = 0,
      this.isHighQuality = false,
      this.isVip = false});

  @override
  String toString() {
    return 'Song{id: $id, name: $name, artists: $artists}';
  }
}
