import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
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

  int get mode => _mode;
  MusicSong get curSong => _curSong;
  AudioPlayerState get curState => _curState;
  Stream<String> get curPositionStream =>
      _curPositionController.stream; // SteamController的出口

  void init() {
    AudioPlayer.logEnabled = false;
    _audioPlayer.setReleaseMode(ReleaseMode.STOP);
    // 播放状态监听
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _curState = state;

      /// 先做顺序播放
      // if(state == AudioPlayerState.COMPLETED){
      //   nextPlay();
      // }
      // 其实也只有在播放状态更新时才需要通知。
      notifyListeners();
    });

    // 歌曲总时长
    _audioPlayer.onDurationChanged.listen((Duration d) {
      curSongDuration = d;
    });

    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      print(p.inMilliseconds);
      // _curPositionController.sink.add('${p.inMinutes}');
    });
  }

  void togglePlay() {
    if (_curState == AudioPlayerState.PAUSED) {
      this.resume();
    } else {
      this.pause();
    }
  }

  void playOneSong(MusicSong song) {
    this._curSong = song;
    this._curList.insert(0, song);
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

  @override
  void dispose() {
    super.dispose();
  }
}
