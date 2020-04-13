import 'package:extended_text/extended_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  /// whether show background for @somebody
  final bool isSearch;
  final String keyword;
  final bool showAtBackground;
  MySpecialTextSpanBuilder({
    this.isSearch = false,
    this.keyword = '',
    this.showAtBackground: false,
  });

  @override
  TextSpan build(String data, {TextStyle textStyle, onTap}) {
    var textSpan = super.build(data, textStyle: textStyle, onTap: onTap);
    return textSpan;
  }

  @override
  SpecialText createSpecialText(String flag,
      {TextStyle textStyle, SpecialTextGestureTapCallback onTap, int index}) {
    if (flag == null || flag == "") return null;

    if (isSearch) {
      return SearchText(
          startFlag: keyword[0], endFlag: keyword[keyword.length - 1]);
    }

    ///index is end index of start flag, so text start index should be index-(flag.length-1)
    if (isStart(flag, AtText.flag)) {
      return AtText(textStyle, onTap,
          start: index - (AtText.flag.length - 1),
          showAtBackground: showAtBackground);
    } else if (isStart(flag, NumText.flag)) {
      return NumText(textStyle, onTap,
          start: index - (NumText.flag.length - 1),
          showAtBackground: showAtBackground);
    } else if (isStart(flag, EventText.flag)) {
      return EventText(textStyle, onTap,
          start: index - (EventText.flag.length - 1),
          showAtBackground: showAtBackground);
    } else if (isStart(flag, UrlText.flag)) {
      return UrlText(textStyle, onTap,
          start: index - (UrlText.flag.length - 1),
          showAtBackground: showAtBackground);
    }
    return null;
  }
}

class SearchText extends SpecialText {
  final int start;

  /// whether show background for @somebody
  final bool showAtBackground;

  SearchText(
      {@required String startFlag,
      @required String endFlag,
      TextStyle textStyle,
      this.start,
      this.showAtBackground})
      : super(startFlag, endFlag, textStyle);

  @override
  InlineSpan finishText() {
    TextStyle textStyle = this
        .textStyle
        ?.copyWith(fontSize: ScreenUtil().setSp(20.0), color: Colors.blue[800]);

    final String keyword = getContent();

    return SpecialTextSpan(
        text: keyword,
        actualText: keyword,
        start: start,
        style: textStyle,
        recognizer: (TapGestureRecognizer()
          ..onTap = () {
            if (onTap != null) onTap(keyword);
          }));
  }
}

class AtText extends SpecialText {
  static const String flag = "@start";
  final int start;

  /// whether show background for @somebody
  final bool showAtBackground;

  AtText(TextStyle textStyle, SpecialTextGestureTapCallback onTap,
      {this.showAtBackground: false, this.start})
      : super(
          flag,
          '@',
          textStyle,
        );

  @override
  InlineSpan finishText() {
    TextStyle textStyle = this
        .textStyle
        ?.copyWith(fontSize: ScreenUtil().setSp(20.0), color: Colors.white70);

    final String atText = getContent();

    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blue.withOpacity(0.15),
            text: atText,
            actualText: atText,
            start: start,

            ///caret can move into special text
            deleteAll: true,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(atText);
              }))
        : SpecialTextSpan(
            text: atText,
            actualText: atText,
            start: start,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(atText);
              }));
  }
}

class NumText extends SpecialText {
  static const String flag = "@num";
  final int start;

  /// whether show background for @somebody
  final bool showAtBackground;

  NumText(TextStyle textStyle, SpecialTextGestureTapCallback onTap,
      {this.showAtBackground: false, this.start})
      : super(
          flag,
          '@',
          textStyle,
        );

  @override
  InlineSpan finishText() {
    TextStyle textStyle = this.textStyle?.copyWith(
        fontSize: ScreenUtil().setSp(28.0),
        color: Colors.white,
        fontWeight: FontWeight.bold);

    final String atText = getContent();

    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blue.withOpacity(0.15),
            text: atText,
            actualText: atText,
            start: start,

            ///caret can move into special text
            deleteAll: true,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(atText);
              }))
        : SpecialTextSpan(
            text: atText,
            actualText: atText,
            start: start,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(atText);
              }));
  }
}

class EventText extends SpecialText {
  static const String flag = "#";
  final int start;

  /// whether show background for @somebody
  final bool showAtBackground;

  EventText(TextStyle textStyle, SpecialTextGestureTapCallback onTap,
      {this.showAtBackground: false, this.start})
      : super(
          flag,
          flag,
          textStyle,
        );

  @override
  InlineSpan finishText() {
    TextStyle textStyle = this.textStyle?.copyWith(color: Colors.blue);

    final String atText = toString();

    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blue.withOpacity(0.15),
            text: atText,
            actualText: atText,
            start: start,

            ///caret can move into special text
            deleteAll: true,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(atText);
              }))
        : SpecialTextSpan(
            text: atText,
            actualText: atText,
            start: start,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(atText);
              }));
  }
}

class UrlText extends SpecialText {
  static const String flag = "http";
  final int start;

  /// whether show background for @somebody
  final bool showAtBackground;

  UrlText(TextStyle textStyle, SpecialTextGestureTapCallback onTap,
      {this.showAtBackground: false, this.start})
      : super(
          flag,
          " ",
          textStyle,
        );

  @override
  InlineSpan finishText() {
    TextStyle textStyle = this.textStyle?.copyWith(color: Colors.blue);

    final String atText = "\u261b 网页地址";

    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blue.withOpacity(0.15),
            text: atText,
            actualText: atText,
            start: start,

            ///caret can move into special text
            deleteAll: true,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(atText);
              }))
        : SpecialTextSpan(
            text: atText,
            actualText: atText,
            start: start,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(atText);
              }));
  }
}
