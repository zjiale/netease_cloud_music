import 'package:flutter/material.dart';

class SearchHistory extends StatefulWidget {
  final List<String> list;

  SearchHistory({Key key, this.list}) : super(key: key);

  @override
  _SearchHistoryState createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  void showDeleteDialog(BuildContext context) {
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
              height: 100.0,
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                child: Chip(
                  label: Text(widget.list[index]),
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
