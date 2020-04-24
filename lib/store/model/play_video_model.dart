import 'package:flutter/material.dart';

class PlayVideoModel with ChangeNotifier {
  /// 定义初始的视频下标
  ValueNotifier<int> _currentIndex = ValueNotifier(0);

  /// 用于判断详情里的视频是否能够播放,默认点击进详情能够播放视频
  ValueNotifier<bool> _canPlay = ValueNotifier(false);

  /// 判断当前是否播放视频
  bool _isPlaying = false;

  ValueNotifier<int> get index => _currentIndex;
  ValueNotifier<bool> get canplay => _canPlay;
  bool get isplay => _isPlaying;

  void changeIndex(int _newIndex) {
    if (_currentIndex.value == _newIndex) return;
    _currentIndex.value = _newIndex;
    if (_newIndex != -1) _isPlaying = true;
    notifyListeners();
  }

  void resetIndex({int resetIndex = 0}) {
    if (_currentIndex.value == resetIndex) return;
    _currentIndex.value = resetIndex;
    _isPlaying = false;
  }

  void startPlay() {
    if (_canPlay.value) return;
    _canPlay.value = true;
    _isPlaying = true;
    notifyListeners();
  }

  void stopPlay() {
    if (!_canPlay.value) return;
    _canPlay.value = false;
    _isPlaying = false;
    // notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
