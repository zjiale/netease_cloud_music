import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:wangyiyun/model/music_song_model.dart';

class PlaySongModel with ChangeNotifier {
  AudioPlayer _audioPlayer = AudioPlayer();
  StreamController<String> _curPositionController =
      StreamController<String>.broadcast();

  int _mode = 0;
  AudioPlayerState _curState;
  Duration curSongDuration;

  int _curIndex = 0;
  List<MusicSong> _curList = [];
  MusicSong _curSong;

  bool isChange = false;

  int get mode => _mode;
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
          ? sinkProgress(p.inMilliseconds > curSong.totalTime
              ? curSong.totalTime
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
    if (_curState == AudioPlayerState.PAUSED) {
      this.resume();
    } else {
      this.pause();
    }
  }

  void playOneSong(MusicSong song) {
    this._curSong = _curList[_curIndex];
    this._curList.insert(0, song);
    this.play();
  }

  void playMoreSong(List<MusicSong> playList, {int index}) {
    this._curList = playList;
    if (index != null) _curIndex = index;
    this.play();
  }

  void play() {
    _audioPlayer.play(
        'https://music.163.com/song/media/outer/url?id=${this._curList[_curIndex].id}.mp3');
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
        _mode = 1; //单曲循环
        break;
      case 1:
        _mode = 2; //随机播放
        break;
      case 2:
        _mode = 0; //顺序播放
        break;
    }
  }

  void seek(int milliseconds) {
    _audioPlayer.seek(Duration(milliseconds: milliseconds));
  }

  void next() {
    if (this._curIndex == this._curList.length) {
      this._curIndex = 0;
    } else {
      this._curIndex++;
    }
    this.play();
  }

  void previous() {
    if (this._curIndex == 0) {
      this._curIndex = this._curList.length - 1;
    } else {
      this._curIndex--;
    }
    this.play();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
