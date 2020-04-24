import 'package:flutter/material.dart';
import 'package:netease_cloud_music/utils/cache.dart';

class SearchHistory extends StatefulWidget {
  final List<String> list;
  final callback;
  final selectedCallback;

  SearchHistory({Key key, this.list, this.callback, this.selectedCallback})
      : super(key: key);

  @override
  _SearchHistoryState createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  static const String SEARCH_KEY = 'SearchHistory';

  void showDeleteDialog(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    EdgeInsetsGeometry contentPadding =
        EdgeInsets.fromLTRB(15.0, 15.0, 24.0, 10.0);

    showGeneralDialog(
        context: context,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black54,
        pageBuilder: (BuildContext context, Animation<double> firstAnimation,
            Animation<double> secondAnimation) {
          return Center(
            child: Container(
              height: 110.0,
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: contentPadding,
                    child: DefaultTextStyle(
                      style: dialogTheme.contentTextStyle ??
                          theme.textTheme.subhead,
                      child: Text(
                        '确定清空全部历史纪录?',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "取消",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            SpUtil.preferences.remove(SEARCH_KEY);
                            widget.callback(true);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "清空",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '历史纪录',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.black54,
                ),
                onPressed: () => showDeleteDialog(context),
              )
            ],
          ),
        ),
        Container(
          height: 30.0,
          margin: EdgeInsets.only(bottom: 40.0),
          padding: EdgeInsets.only(right: 20.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: ActionChip(
                  backgroundColor: Color(0xfff1f1f1),
                  label: Text(widget.list[index]),
                  onPressed: () => widget.selectedCallback(widget.list[index]),
                ),
              );
            },
            itemCount: widget.list.length,
          ),
        ),
      ],
    );
  }
}
