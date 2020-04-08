import 'package:flutter/material.dart';

class SearchHistory extends StatefulWidget {
  @override
  _SearchHistoryState createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
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
                color: Color(0xffcdcdcd),
              ),
              onPressed: () {},
            )
          ],
        ),
        Container(
          height: 30.0,
          margin: EdgeInsets.only(bottom: 50.0),
          padding: EdgeInsets.only(right: 20.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Chip(
                  label: Text('后来'),
                ),
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
