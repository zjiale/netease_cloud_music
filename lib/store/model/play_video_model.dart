import 'dart:async';

import 'package:flutter/material.dart';

class PlayVideoModel with ChangeNotifier {
  /// 定义初始的视频下标
  int _currentIndex = 0;

  /// 获取到视窗第一个视频，判断是否能够开始播放了
  bool _canPlay = false;

  /// 判断当前是否播放视频
  bool _isPlaying = false;

  int get index => _currentIndex;
  bool get canplay => _canPlay;
  bool get isplay => _isPlaying;

  void changeIndex(int _newIndex) {
    _currentIndex = _newIndex;
    _canPlay = true;
    notifyListeners();
  }

  void stopPlay() {
    _canPlay = false;
    _currentIndex = 0;
    // notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
