class MusicSong {
  int id; // 歌曲id
  int totalTime; //歌曲总时长
  String name; // 歌曲名称
  String artists; // 演唱者
  String picUrl; // 歌曲图片

  MusicSong(this.id, {this.totalTime, this.name, this.artists, this.picUrl});

  @override
  String toString() {
    return 'Song{id: $id, name: $name, artists: $artists}';
  }
}
