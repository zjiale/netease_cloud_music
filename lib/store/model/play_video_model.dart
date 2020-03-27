import 'dart:async';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

class PlayVideoModel with ChangeNotifier {
  /// 定义初始的视频下标
  ValueNotifier<int> _currentIndex = ValueNotifier(0);

  /// 获取到视窗第一个视频，判断是否能够开始播放了
  ValueNotifier<bool> _canPlay = ValueNotifier(false);

  /// 判断当前是否播放视频
  bool _isPlaying = false;

  ValueNotifier<int> get index => _currentIndex;
  ValueNotifier<bool> get canplay => _canPlay;
  bool get isplay => _isPlaying;

  void changeIndex(int _newIndex) {
    if (_currentIndex.value == _newIndex) return;
    _currentIndex.value = _newIndex;
    _canPlay.value = true;
    notifyListeners();
  }

  void resetIndex() {
    if (_currentIndex.value == 0) return;
    _currentIndex.value = 0;
  }

  void stopPlay() {
    if (!_canPlay.value) return;
    _canPlay.value = false;
    // notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
