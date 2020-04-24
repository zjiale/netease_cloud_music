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

class CommentModel {
  int cnum;
  int code;
  List<Comments> comments;
  List<HotComments> hotComments;
  bool isMusician;
  bool more;
  bool moreHot;
  List<Object> topComments;
  int total;
  int userId;

  CommentModel({
    this.cnum,
    this.code,
    this.comments,
    this.hotComments,
    this.isMusician,
    this.more,
    this.moreHot,
    this.topComments,
    this.total,
    this.userId,
  });

  factory CommentModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Comments> comments = jsonRes['comments'] is List ? [] : null;
    if (comments != null) {
      for (var item in jsonRes['comments']) {
        if (item != null) {
          tryCatch(() {
            comments.add(Comments.fromJson(item));
          });
        }
      }
    }

    List<HotComments> hotComments = jsonRes['hotComments'] is List ? [] : null;
    if (hotComments != null) {
      for (var item in jsonRes['hotComments']) {
        if (item != null) {
          tryCatch(() {
            hotComments.add(HotComments.fromJson(item));
          });
        }
      }
    }

    List<Object> topComments = jsonRes['topComments'] is List ? [] : null;
    if (topComments != null) {
      for (var item in jsonRes['topComments']) {
        if (item != null) {
          tryCatch(() {
            topComments.add(item);
          });
        }
      }
    }

    return CommentModel(
      cnum:
          convertValueByType(jsonRes['cnum'], int, stack: "CommentModel-cnum"),
      code:
          convertValueByType(jsonRes['code'], int, stack: "CommentModel-code"),
      comments: comments,
      hotComments: hotComments,
      isMusician: convertValueByType(jsonRes['isMusician'], bool,
          stack: "CommentModel-isMusician"),
      more:
          convertValueByType(jsonRes['more'], bool, stack: "CommentModel-more"),
      moreHot: convertValueByType(jsonRes['moreHot'], bool,
          stack: "CommentModel-moreHot"),
      topComments: topComments,
      total: convertValueByType(jsonRes['total'], int,
          stack: "CommentModel-total"),
      userId: convertValueByType(jsonRes['userId'], int,
          stack: "CommentModel-userId"),
    );
  }
  Map<String, dynamic> toJson() => {
        'cnum': cnum,
        'code': code,
        'comments': comments,
        'hotComments': hotComments,
        'isMusician': isMusician,
        'more': more,
        'moreHot': moreHot,
        'topComments': topComments,
        'total': total,
        'userId': userId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class HotComments {
  List<HotCommentsBeReplied> beReplied;
  int commentId;
  int commentLocationType;
  String content;
  Object decoration;
  Object expressionUrl;
  bool liked;
  int likedCount;
  int parentCommentId;
  HotCommentsPendantData pendantData;
  Object repliedMark;
  Object showFloorComment;
  int status;
  int time;
  HotCommentsUser user;

  HotComments({
    this.beReplied,
    this.commentId,
    this.commentLocationType,
    this.content,
    this.decoration,
    this.expressionUrl,
    this.liked,
    this.likedCount,
    this.parentCommentId,
    this.pendantData,
    this.repliedMark,
    this.showFloorComment,
    this.status,
    this.time,
    this.user,
  });

  factory HotComments.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<HotCommentsBeReplied> beReplied =
        jsonRes['beReplied'] is List ? [] : null;
    if (beReplied != null) {
      for (var item in jsonRes['beReplied']) {
        if (item != null) {
          tryCatch(() {
            beReplied.add(HotCommentsBeReplied.fromJson(item));
          });
        }
      }
    }

    return HotComments(
      beReplied: beReplied,
      commentId: convertValueByType(jsonRes['commentId'], int,
          stack: "HotComments-commentId"),
      commentLocationType: convertValueByType(
          jsonRes['commentLocationType'], int,
          stack: "HotComments-commentLocationType"),
      content: convertValueByType(jsonRes['content'], String,
          stack: "HotComments-content"),
      decoration: convertValueByType(jsonRes['decoration'], Object,
          stack: "HotComments-decoration"),
      expressionUrl: convertValueByType(jsonRes['expressionUrl'], Object,
          stack: "HotComments-expressionUrl"),
      liked: convertValueByType(jsonRes['liked'], bool,
          stack: "HotComments-liked"),
      likedCount: convertValueByType(jsonRes['likedCount'], int,
          stack: "HotComments-likedCount"),
      parentCommentId: convertValueByType(jsonRes['parentCommentId'], int,
          stack: "HotComments-parentCommentId"),
      pendantData: HotCommentsPendantData.fromJson(jsonRes['pendantData']),
      repliedMark: convertValueByType(jsonRes['repliedMark'], Object,
          stack: "HotComments-repliedMark"),
      showFloorComment: convertValueByType(jsonRes['showFloorComment'], Object,
          stack: "HotComments-showFloorComment"),
      status: convertValueByType(jsonRes['status'], int,
          stack: "HotComments-status"),
      time: convertValueByType(jsonRes['time'], int, stack: "HotComments-time"),
      user: HotCommentsUser.fromJson(jsonRes['user']),
    );
  }
  Map<String, dynamic> toJson() => {
        'beReplied': beReplied,
        'commentId': commentId,
        'commentLocationType': commentLocationType,
        'content': content,
        'decoration': decoration,
        'expressionUrl': expressionUrl,
        'liked': liked,
        'likedCount': likedCount,
        'parentCommentId': parentCommentId,
        'pendantData': pendantData,
        'repliedMark': repliedMark,
        'showFloorComment': showFloorComment,
        'status': status,
        'time': time,
        'user': user,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class HotCommentsUser {
  int authStatus;
  String avatarUrl;
  Object experts;
  Object expertTags;
  Object liveInfo;
  Object locationInfo;
  String nickname;
  Object remarkName;
  int userId;
  int userType;
  HotCommentsVipRights vipRights;
  int vipType;

  HotCommentsUser({
    this.authStatus,
    this.avatarUrl,
    this.experts,
    this.expertTags,
    this.liveInfo,
    this.locationInfo,
    this.nickname,
    this.remarkName,
    this.userId,
    this.userType,
    this.vipRights,
    this.vipType,
  });

  factory HotCommentsUser.fromJson(jsonRes) => jsonRes == null
      ? null
      : HotCommentsUser(
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "HotCommentsUser-authStatus"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "HotCommentsUser-avatarUrl"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "HotCommentsUser-experts"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "HotCommentsUser-expertTags"),
          liveInfo: convertValueByType(jsonRes['liveInfo'], Object,
              stack: "HotCommentsUser-liveInfo"),
          locationInfo: convertValueByType(jsonRes['locationInfo'], Object,
              stack: "HotCommentsUser-locationInfo"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "HotCommentsUser-nickname"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "HotCommentsUser-remarkName"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "HotCommentsUser-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "HotCommentsUser-userType"),
          vipRights: HotCommentsVipRights.fromJson(jsonRes['vipRights']),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "HotCommentsUser-vipType"),
        );
  Map<String, dynamic> toJson() => {
        'authStatus': authStatus,
        'avatarUrl': avatarUrl,
        'experts': experts,
        'expertTags': expertTags,
        'liveInfo': liveInfo,
        'locationInfo': locationInfo,
        'nickname': nickname,
        'remarkName': remarkName,
        'userId': userId,
        'userType': userType,
        'vipRights': vipRights,
        'vipType': vipType,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class HotCommentsVipRights {
  HotCommentsAssociator associator;
  HotCommentsMusicPackage musicPackage;
  int redVipAnnualCount;

  HotCommentsVipRights({
    this.associator,
    this.musicPackage,
    this.redVipAnnualCount,
  });

  factory HotCommentsVipRights.fromJson(jsonRes) => jsonRes == null
      ? null
      : HotCommentsVipRights(
          associator: HotCommentsAssociator.fromJson(jsonRes['associator']),
          musicPackage:
              HotCommentsMusicPackage.fromJson(jsonRes['musicPackage']),
          redVipAnnualCount: convertValueByType(
              jsonRes['redVipAnnualCount'], int,
              stack: "HotCommentsVipRights-redVipAnnualCount"),
        );
  Map<String, dynamic> toJson() => {
        'associator': associator,
        'musicPackage': musicPackage,
        'redVipAnnualCount': redVipAnnualCount,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class HotCommentsAssociator {
  bool rights;
  int vipCode;

  HotCommentsAssociator({
    this.rights,
    this.vipCode,
  });

  factory HotCommentsAssociator.fromJson(jsonRes) => jsonRes == null
      ? null
      : HotCommentsAssociator(
          rights: convertValueByType(jsonRes['rights'], bool,
              stack: "HotCommentsAssociator-rights"),
          vipCode: convertValueByType(jsonRes['vipCode'], int,
              stack: "HotCommentsAssociator-vipCode"),
        );
  Map<String, dynamic> toJson() => {
        'rights': rights,
        'vipCode': vipCode,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class HotCommentsMusicPackage {
  bool rights;
  int vipCode;

  HotCommentsMusicPackage({
    this.rights,
    this.vipCode,
  });

  factory HotCommentsMusicPackage.fromJson(jsonRes) => jsonRes == null
      ? null
      : HotCommentsMusicPackage(
          rights: convertValueByType(jsonRes['rights'], bool,
              stack: "HotCommentsMusicPackage-rights"),
          vipCode: convertValueByType(jsonRes['vipCode'], int,
              stack: "HotCommentsMusicPackage-vipCode"),
        );
  Map<String, dynamic> toJson() => {
        'rights': rights,
        'vipCode': vipCode,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class HotCommentsBeReplied {
  int beRepliedCommentId;
  String content;
  Object expressionUrl;
  int status;
  HotCommentsBeRepliedUser user;

  HotCommentsBeReplied({
    this.beRepliedCommentId,
    this.content,
    this.expressionUrl,
    this.status,
    this.user,
  });

  factory HotCommentsBeReplied.fromJson(jsonRes) => jsonRes == null
      ? null
      : HotCommentsBeReplied(
          beRepliedCommentId: convertValueByType(
              jsonRes['beRepliedCommentId'], int,
              stack: "HotCommentsBeReplied-beRepliedCommentId"),
          content: convertValueByType(jsonRes['content'], String,
              stack: "HotCommentsBeReplied-content"),
          expressionUrl: convertValueByType(jsonRes['expressionUrl'], Object,
              stack: "HotCommentsBeReplied-expressionUrl"),
          status: convertValueByType(jsonRes['status'], int,
              stack: "HotCommentsBeReplied-status"),
          user: HotCommentsBeRepliedUser.fromJson(jsonRes['user']),
        );
  Map<String, dynamic> toJson() => {
        'beRepliedCommentId': beRepliedCommentId,
        'content': content,
        'expressionUrl': expressionUrl,
        'status': status,
        'user': user,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class HotCommentsBeRepliedUser {
  int authStatus;
  String avatarUrl;
  Object experts;
  Object expertTags;
  Object liveInfo;
  Object locationInfo;
  String nickname;
  Object remarkName;
  int userId;
  int userType;
  Object vipRights;
  int vipType;

  HotCommentsBeRepliedUser({
    this.authStatus,
    this.avatarUrl,
    this.experts,
    this.expertTags,
    this.liveInfo,
    this.locationInfo,
    this.nickname,
    this.remarkName,
    this.userId,
    this.userType,
    this.vipRights,
    this.vipType,
  });

  factory HotCommentsBeRepliedUser.fromJson(jsonRes) => jsonRes == null
      ? null
      : HotCommentsBeRepliedUser(
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "HotCommentsBeRepliedUser-authStatus"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "HotCommentsBeRepliedUser-avatarUrl"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "HotCommentsBeRepliedUser-experts"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "HotCommentsBeRepliedUser-expertTags"),
          liveInfo: convertValueByType(jsonRes['liveInfo'], Object,
              stack: "HotCommentsBeRepliedUser-liveInfo"),
          locationInfo: convertValueByType(jsonRes['locationInfo'], Object,
              stack: "HotCommentsBeRepliedUser-locationInfo"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "HotCommentsBeRepliedUser-nickname"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "HotCommentsBeRepliedUser-remarkName"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "HotCommentsBeRepliedUser-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "HotCommentsBeRepliedUser-userType"),
          vipRights: convertValueByType(jsonRes['vipRights'], Object,
              stack: "HotCommentsBeRepliedUser-vipRights"),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "HotCommentsBeRepliedUser-vipType"),
        );
  Map<String, dynamic> toJson() => {
        'authStatus': authStatus,
        'avatarUrl': avatarUrl,
        'experts': experts,
        'expertTags': expertTags,
        'liveInfo': liveInfo,
        'locationInfo': locationInfo,
        'nickname': nickname,
        'remarkName': remarkName,
        'userId': userId,
        'userType': userType,
        'vipRights': vipRights,
        'vipType': vipType,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class HotCommentsPendantData {
  int id;
  String imageUrl;

  HotCommentsPendantData({
    this.id,
    this.imageUrl,
  });

  factory HotCommentsPendantData.fromJson(jsonRes) => jsonRes == null
      ? null
      : HotCommentsPendantData(
          id: convertValueByType(jsonRes['id'], int,
              stack: "HotCommentsPendantData-id"),
          imageUrl: convertValueByType(jsonRes['imageUrl'], String,
              stack: "HotCommentsPendantData-imageUrl"),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Comments {
  List<CommentsBeReplied> beReplied;
  int commentId;
  int commentLocationType;
  String content;
  Object decoration;
  Object expressionUrl;
  bool liked;
  int likedCount;
  int parentCommentId;
  CommentsPendantData pendantData;
  Object repliedMark;
  Object showFloorComment;
  int status;
  int time;
  CommentsUser user;

  Comments({
    this.beReplied,
    this.commentId,
    this.commentLocationType,
    this.content,
    this.decoration,
    this.expressionUrl,
    this.liked,
    this.likedCount,
    this.parentCommentId,
    this.pendantData,
    this.repliedMark,
    this.showFloorComment,
    this.status,
    this.time,
    this.user,
  });

  factory Comments.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<CommentsBeReplied> beReplied =
        jsonRes['beReplied'] is List ? [] : null;
    if (beReplied != null) {
      for (var item in jsonRes['beReplied']) {
        if (item != null) {
          tryCatch(() {
            beReplied.add(CommentsBeReplied.fromJson(item));
          });
        }
      }
    }

    return Comments(
      beReplied: beReplied,
      commentId: convertValueByType(jsonRes['commentId'], int,
          stack: "Comments-commentId"),
      commentLocationType: convertValueByType(
          jsonRes['commentLocationType'], int,
          stack: "Comments-commentLocationType"),
      content: convertValueByType(jsonRes['content'], String,
          stack: "Comments-content"),
      decoration: convertValueByType(jsonRes['decoration'], Object,
          stack: "Comments-decoration"),
      expressionUrl: convertValueByType(jsonRes['expressionUrl'], Object,
          stack: "Comments-expressionUrl"),
      liked:
          convertValueByType(jsonRes['liked'], bool, stack: "Comments-liked"),
      likedCount: convertValueByType(jsonRes['likedCount'], int,
          stack: "Comments-likedCount"),
      parentCommentId: convertValueByType(jsonRes['parentCommentId'], int,
          stack: "Comments-parentCommentId"),
      pendantData: CommentsPendantData.fromJson(jsonRes['pendantData']),
      repliedMark: convertValueByType(jsonRes['repliedMark'], Object,
          stack: "Comments-repliedMark"),
      showFloorComment: convertValueByType(jsonRes['showFloorComment'], Object,
          stack: "Comments-showFloorComment"),
      status:
          convertValueByType(jsonRes['status'], int, stack: "Comments-status"),
      time: convertValueByType(jsonRes['time'], int, stack: "Comments-time"),
      user: CommentsUser.fromJson(jsonRes['user']),
    );
  }
  Map<String, dynamic> toJson() => {
        'beReplied': beReplied,
        'commentId': commentId,
        'commentLocationType': commentLocationType,
        'content': content,
        'decoration': decoration,
        'expressionUrl': expressionUrl,
        'liked': liked,
        'likedCount': likedCount,
        'parentCommentId': parentCommentId,
        'pendantData': pendantData,
        'repliedMark': repliedMark,
        'showFloorComment': showFloorComment,
        'status': status,
        'time': time,
        'user': user,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class CommentsUser {
  int authStatus;
  String avatarUrl;
  Object experts;
  Object expertTags;
  Object liveInfo;
  Object locationInfo;
  String nickname;
  Object remarkName;
  int userId;
  int userType;
  CommentsVipRights vipRights;
  int vipType;

  CommentsUser({
    this.authStatus,
    this.avatarUrl,
    this.experts,
    this.expertTags,
    this.liveInfo,
    this.locationInfo,
    this.nickname,
    this.remarkName,
    this.userId,
    this.userType,
    this.vipRights,
    this.vipType,
  });

  factory CommentsUser.fromJson(jsonRes) => jsonRes == null
      ? null
      : CommentsUser(
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "CommentsUser-authStatus"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "CommentsUser-avatarUrl"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "CommentsUser-experts"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "CommentsUser-expertTags"),
          liveInfo: convertValueByType(jsonRes['liveInfo'], Object,
              stack: "CommentsUser-liveInfo"),
          locationInfo: convertValueByType(jsonRes['locationInfo'], Object,
              stack: "CommentsUser-locationInfo"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "CommentsUser-nickname"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "CommentsUser-remarkName"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "CommentsUser-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "CommentsUser-userType"),
          vipRights: CommentsVipRights.fromJson(jsonRes['vipRights']),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "CommentsUser-vipType"),
        );
  Map<String, dynamic> toJson() => {
        'authStatus': authStatus,
        'avatarUrl': avatarUrl,
        'experts': experts,
        'expertTags': expertTags,
        'liveInfo': liveInfo,
        'locationInfo': locationInfo,
        'nickname': nickname,
        'remarkName': remarkName,
        'userId': userId,
        'userType': userType,
        'vipRights': vipRights,
        'vipType': vipType,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class CommentsVipRights {
  CommentsAssociator associator;
  CommentsMusicPackage musicPackage;
  int redVipAnnualCount;

  CommentsVipRights({
    this.associator,
    this.musicPackage,
    this.redVipAnnualCount,
  });

  factory CommentsVipRights.fromJson(jsonRes) => jsonRes == null
      ? null
      : CommentsVipRights(
          associator: CommentsAssociator.fromJson(jsonRes['associator']),
          musicPackage: CommentsMusicPackage.fromJson(jsonRes['musicPackage']),
          redVipAnnualCount: convertValueByType(
              jsonRes['redVipAnnualCount'], int,
              stack: "CommentsVipRights-redVipAnnualCount"),
        );
  Map<String, dynamic> toJson() => {
        'associator': associator,
        'musicPackage': musicPackage,
        'redVipAnnualCount': redVipAnnualCount,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class CommentsAssociator {
  bool rights;
  int vipCode;

  CommentsAssociator({
    this.rights,
    this.vipCode,
  });

  factory CommentsAssociator.fromJson(jsonRes) => jsonRes == null
      ? null
      : CommentsAssociator(
          rights: convertValueByType(jsonRes['rights'], bool,
              stack: "CommentsAssociator-rights"),
          vipCode: convertValueByType(jsonRes['vipCode'], int,
              stack: "CommentsAssociator-vipCode"),
        );
  Map<String, dynamic> toJson() => {
        'rights': rights,
        'vipCode': vipCode,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class CommentsMusicPackage {
  bool rights;
  int vipCode;

  CommentsMusicPackage({
    this.rights,
    this.vipCode,
  });

  factory CommentsMusicPackage.fromJson(jsonRes) => jsonRes == null
      ? null
      : CommentsMusicPackage(
          rights: convertValueByType(jsonRes['rights'], bool,
              stack: "CommentsMusicPackage-rights"),
          vipCode: convertValueByType(jsonRes['vipCode'], int,
              stack: "CommentsMusicPackage-vipCode"),
        );
  Map<String, dynamic> toJson() => {
        'rights': rights,
        'vipCode': vipCode,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class CommentsBeReplied {
  int beRepliedCommentId;
  String content;
  Object expressionUrl;
  int status;
  CommentsBeRepliedUser user;

  CommentsBeReplied({
    this.beRepliedCommentId,
    this.content,
    this.expressionUrl,
    this.status,
    this.user,
  });

  factory CommentsBeReplied.fromJson(jsonRes) => jsonRes == null
      ? null
      : CommentsBeReplied(
          beRepliedCommentId: convertValueByType(
              jsonRes['beRepliedCommentId'], int,
              stack: "CommentsBeReplied-beRepliedCommentId"),
          content: convertValueByType(jsonRes['content'], String,
              stack: "CommentsBeReplied-content"),
          expressionUrl: convertValueByType(jsonRes['expressionUrl'], Object,
              stack: "CommentsBeReplied-expressionUrl"),
          status: convertValueByType(jsonRes['status'], int,
              stack: "CommentsBeReplied-status"),
          user: CommentsBeRepliedUser.fromJson(jsonRes['user']),
        );
  Map<String, dynamic> toJson() => {
        'beRepliedCommentId': beRepliedCommentId,
        'content': content,
        'expressionUrl': expressionUrl,
        'status': status,
        'user': user,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class CommentsBeRepliedUser {
  int authStatus;
  String avatarUrl;
  Object experts;
  Object expertTags;
  Object liveInfo;
  Object locationInfo;
  String nickname;
  Object remarkName;
  int userId;
  int userType;
  Object vipRights;
  int vipType;

  CommentsBeRepliedUser({
    this.authStatus,
    this.avatarUrl,
    this.experts,
    this.expertTags,
    this.liveInfo,
    this.locationInfo,
    this.nickname,
    this.remarkName,
    this.userId,
    this.userType,
    this.vipRights,
    this.vipType,
  });

  factory CommentsBeRepliedUser.fromJson(jsonRes) => jsonRes == null
      ? null
      : CommentsBeRepliedUser(
          authStatus: convertValueByType(jsonRes['authStatus'], int,
              stack: "CommentsBeRepliedUser-authStatus"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "CommentsBeRepliedUser-avatarUrl"),
          experts: convertValueByType(jsonRes['experts'], Object,
              stack: "CommentsBeRepliedUser-experts"),
          expertTags: convertValueByType(jsonRes['expertTags'], Object,
              stack: "CommentsBeRepliedUser-expertTags"),
          liveInfo: convertValueByType(jsonRes['liveInfo'], Object,
              stack: "CommentsBeRepliedUser-liveInfo"),
          locationInfo: convertValueByType(jsonRes['locationInfo'], Object,
              stack: "CommentsBeRepliedUser-locationInfo"),
          nickname: convertValueByType(jsonRes['nickname'], String,
              stack: "CommentsBeRepliedUser-nickname"),
          remarkName: convertValueByType(jsonRes['remarkName'], Object,
              stack: "CommentsBeRepliedUser-remarkName"),
          userId: convertValueByType(jsonRes['userId'], int,
              stack: "CommentsBeRepliedUser-userId"),
          userType: convertValueByType(jsonRes['userType'], int,
              stack: "CommentsBeRepliedUser-userType"),
          vipRights: convertValueByType(jsonRes['vipRights'], Object,
              stack: "CommentsBeRepliedUser-vipRights"),
          vipType: convertValueByType(jsonRes['vipType'], int,
              stack: "CommentsBeRepliedUser-vipType"),
        );
  Map<String, dynamic> toJson() => {
        'authStatus': authStatus,
        'avatarUrl': avatarUrl,
        'experts': experts,
        'expertTags': expertTags,
        'liveInfo': liveInfo,
        'locationInfo': locationInfo,
        'nickname': nickname,
        'remarkName': remarkName,
        'userId': userId,
        'userType': userType,
        'vipRights': vipRights,
        'vipType': vipType,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class CommentsPendantData {
  int id;
  String imageUrl;

  CommentsPendantData({
    this.id,
    this.imageUrl,
  });

  factory CommentsPendantData.fromJson(jsonRes) => jsonRes == null
      ? null
      : CommentsPendantData(
          id: convertValueByType(jsonRes['id'], int,
              stack: "CommentsPendantData-id"),
          imageUrl: convertValueByType(jsonRes['imageUrl'], String,
              stack: "CommentsPendantData-imageUrl"),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
