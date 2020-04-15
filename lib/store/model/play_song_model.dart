import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/model/comment_model.dart';
import 'package:netease_cloud_music/utils/config.dart';
import 'package:oktoast/oktoast.dart';
import 'package:netease_cloud_music/model/music_song_model.dart';
import 'package:netease_cloud_music/utils/cache.dart';
import 'package:netease_cloud_music/utils/fluro_convert_util.dart';

class PlaySongModel with ChangeNotifier {
  static const String _SongKey = 'PLAYING_SONG';
  static const String _IndexKey = 'SONG_INDEX';
  int _code = Config.SUCCESS_CODE;

  CommentModel _commentModel;
  AudioPlayer _audioPlayer = AudioPlayer();
  StreamController<String> _curPositionController =
      StreamController<String>.broadcast();

  int _mode = 0;
  AudioPlayerState _curState;
  Duration curSongDuration;

  int _curIndex = 0;
  int _sequenceIndex;

  List<MusicSong> _curList = [];
  List<MusicSong> _sequenceList = [];
  List<MusicSong> _randomList = [];

  bool isChange = false;
  bool _isShow = false;

  bool get show => _isShow; // 迷你播放器是否显示
  int get mode => _mode; // 播放模式
  List<MusicSong> get curList => _curList; // 当前播放列表
  MusicSong get curSong => _curList[_curIndex]; // 当前播放歌曲
  CommentModel get comment => _commentModel;
  AudioPlayerState get curState => _curState; //当前播放器状态
  Stream<String> get curPositionStream =>
      _curPositionController.stream; // SteamController的出口

  void init() {
    AudioPlayer.logEnabled = false;
    _audioPlayer.setReleaseMode(ReleaseMode.STOP);

    var songList = SpUtil.preferences.get(_SongKey);
    if (songList == null) {
      _isShow = true;
    } else {
      // 将list字符串转成json list，然后再将json list转成转成字符串就可以获取列表第一个值
      List jsonStr = json.decode(json.encode(songList));
      for (int i = 0; i < jsonStr.length; i++) {
        _curList.insert(i, MusicSong.fromJson(json.decode(jsonStr[i])));
        getSongComment();
      }
      _sequenceList = _curList;
    }

    // 播放状态监听
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _curState = state;
      if (state == AudioPlayerState.COMPLETED) {
        next();
      }
      // 其实也只有在播放状态更新时才需要通知。
      notifyListeners();
    });

    _audioPlayer.onDurationChanged.listen((d) {
      curSongDuration = d;
    });

    // 当前播放进度监听
    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      !isChange
          ? sinkProgress(p.inMilliseconds >= curSong.duration
              ? curSong.duration
              : p.inMilliseconds)
          : _curPositionController.sink.done;
    });
  }

  // 当开始拖动slider的时候不再将值添加进流中
  void stopProgress() {
    isChange = true;
  }

  void startProgress() {
    isChange = false;
  }

  // 歌曲进度
  void sinkProgress(int m) {
    _curPositionController.sink.add('$m');
  }

  void togglePlay() {
    if (_curState == null) {
      play();
    } else if (_curState == AudioPlayerState.PAUSED) {
      resume();
    } else {
      pause();
    }
  }

  void playOneSong(MusicSong song) {
    _curList.insert(0, song);
    _sequenceList = _curList;
    play();
  }

  void playMoreSong(List<MusicSong> playList, {int index}) {
    _curList = playList;
    _sequenceList = playList;
    _randomList = List.from(playList);
    _randomList.shuffle();
    if (index != null) _curIndex = index;
    play();
  }

  void play() {
    getSongComment();
    _audioPlayer
        .setUrl(
            'https://music.163.com/song/media/outer/url?id=${_curList[_curIndex].id}.mp3')
        .then((result) {
      resume();
      if (_isShow) _isShow = false;
    }).catchError((error) async {
      print(error);
      showToast(
        '正在加载音乐,请稍等!!!',
        position: ToastPosition.bottom,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.grey,
        radius: 13.0,
        textStyle: TextStyle(fontSize: 15.0),
      );
    });
    save2sp();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void resume() {
    _audioPlayer.resume();
  }

  void changeMode() {
    switch (_mode) {
      case 0:
        // _sequenceIndex = _curIndex;
        _mode = 1; //单曲循环
        _audioPlayer.setReleaseMode(ReleaseMode.LOOP);
        break;
      case 1:
        _mode = 2; //随机播放
        _audioPlayer.setReleaseMode(ReleaseMode.STOP);
        break;
      case 2:
        _sequenceIndex = _sequenceList
            .indexWhere((song) => song.id == _curList[_curIndex].id);
        // print(_sequenceIndex);
        _mode = 0; //顺序播放
        break;
    }
    notifyListeners();
  }

  void seek(int milliseconds) {
    _audioPlayer.seek(Duration(milliseconds: milliseconds));
  }

  // 0为顺序播放，2为随机播放
  void playLogic({int i}) {
    if (_curList.length == 1) {
      showToast(
        '当前歌曲为最后一首，请添加歌曲！！！！',
        position: ToastPosition.bottom,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.grey,
        radius: 13.0,
        textStyle: TextStyle(fontSize: 15.0),
      );
      return;
    }
    // 播放模式判断
    if (_mode == 0) {
      _curList = _sequenceList;
      _curIndex = _sequenceIndex != null ? _sequenceIndex : _curIndex;
    } else if (_mode == 2) {
      _curList = _randomList;
    }

    // 临界判断
    if (_curIndex == _curList.length) {
      _curIndex = i == 0 ? 0 : _curList.length - 1;
    } else {
      i == 0 ? _curIndex++ : _curIndex--;
    }
    _sequenceIndex = _curIndex;
    play();
  }

  void next() {
    playLogic(i: 0);
  }

  void previous() {
    playLogic(i: 2);
  }

  void getSongComment({int offset = 0}) async {
    _commentModel = await CommmonService()
        .getSongComment(_curList[_curIndex].id, offset: offset);
  }

  void save2sp() {
    if (!_curList.any((song) => song.id == _curList[_curIndex].id)) return;
    SpUtil.preferences.remove(_SongKey);
    SpUtil.preferences.setInt(_IndexKey, _curIndex);
    SpUtil.preferences
        .setStringList(_SongKey, _curList.map((s) => s.toString()).toList());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
