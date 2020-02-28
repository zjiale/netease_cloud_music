import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wangyiyun/model/music_song_model.dart';

class PlaySongModel with ChangeNotifier {
  AudioPlayer _audioPlayer = AudioPlayer();
  StreamController<String> _curPositionController =
      StreamController<String>.broadcast();

  int _mode = 0;
  AudioPlayerState _curState;
  Duration curSongDuration;

  int _curIndex = 0;
  int _sequenceIndex;
  int _randomIndex = 0;

  List<MusicSong> _curList = [];
  List<MusicSong> _sequenceList = [];
  List<MusicSong> _randomList = [];
  MusicSong _curSong;

  bool isChange = false;

  int get mode => _mode;
  List<MusicSong> get curList => _curList;
  MusicSong get curSong => _curList[_curIndex];
  AudioPlayerState get curState => _curState;
  Stream<String> get curPositionStream =>
      _curPositionController.stream; // SteamController的出口

  void init() {
    AudioPlayer.logEnabled = false;
    _audioPlayer.setReleaseMode(ReleaseMode.STOP);
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
          ? sinkProgress(p.inMilliseconds >= curSong.totalTime
              ? curSong.totalTime
              : p.inMilliseconds)
          : _curPositionController.sink.done;
    });

    _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
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
    if (_curState == AudioPlayerState.PAUSED) {
      resume();
    } else {
      pause();
    }
  }

  void playOneSong(MusicSong song) {
    _curSong = _curList[_curIndex];
    _curList.insert(0, song);
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
    _audioPlayer
        .setUrl(
            'https://music.163.com/song/media/outer/url?id=${_curList[_curIndex].id}.mp3')
        .then((result) {
      print(result);
      resume();
    }).catchError((error) async {
      showToast(
        '网络出现点问题，请检查下网络！',
        position: ToastPosition.bottom,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.grey,
        radius: 13.0,
        textStyle: TextStyle(fontSize: 15.0),
      );
    });
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

  void next() {
    _curList = _mode == 0 ? _sequenceList : _randomList;
    _curIndex =
        _mode == 0 && _sequenceIndex != null ? _sequenceIndex : _curIndex;
    if (_curIndex == _curList.length) {
      _curIndex = 0;
    } else {
      _curIndex++;
    }
    _sequenceIndex = _curIndex;
    play();
  }

  void previous() {
    _curList = _mode == 0 ? _sequenceList : _randomList;
    _curIndex =
        _mode == 0 && _sequenceIndex != null ? _sequenceIndex : _curIndex;
    if (_curIndex == 0) {
      _curIndex = _curList.length - 1;
    } else {
      _curIndex--;
    }
    _sequenceIndex = _curIndex;
    play();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
