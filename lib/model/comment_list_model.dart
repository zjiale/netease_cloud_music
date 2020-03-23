class CommentListModel {
  String nickname;
  int id;
  String avatarUrl;
  String pendantDataUrl;
  String content;
  int likedCount;
  int time;
  bool liked;

  CommentListModel(
      {this.nickname,
      this.id,
      this.avatarUrl,
      this.pendantDataUrl,
      this.content,
      this.likedCount,
      this.time,
      this.liked});
}
