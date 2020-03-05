import 'package:flutter/material.dart';

class WReorderData {
  Widget widget;
  BuildContext context;
  double height;

  WReorderData(this.widget);
}

typedef IndexChanged<int> = void Function(int a, int b, int c);

double _offsetDx;

class WReorderList extends StatefulWidget {
  final List<Widget> children;
  final IndexChanged onIndexChanged;
  final Duration duration;

  WReorderList(
      {Key key,
      @required this.children,
      @required this.onIndexChanged,
      this.duration = const Duration(milliseconds: 500)})
      : super(key: key);

  @override
  WReorderListState createState() => WReorderListState();

  static WReorderListState of(BuildContext context, {bool nullOk = false}) {
    assert(context != null);
    assert(nullOk != null);
    final WReorderListState result =
        context.ancestorStateOfType(const TypeMatcher<WReorderListState>());
    if (nullOk || result != null) return result;
    throw FlutterError(
        'WReorderList.of() called with a context that does not contain an WReorderList.');
  }
}

class WReorderListState extends State<WReorderList>
    with TickerProviderStateMixin<WReorderList> {
  List<WReorderData> data;
  List<int> swapIndex = [];

  @override
  void initState() {
    super.initState();
    data = widget.children.map((d) => WReorderData(d)).toList();
    _offsetDx = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // print('update---localposition:${details.localPosition}');
        // print('update---x:${details.globalPosition.dx}');
        _offsetDx += details.globalPosition.dx;
        setState(() {});
      },
      onPanEnd: (details) => swap(0, 1, 2),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(10.0),
            itemBuilder: (context, index) {
              return Builder(builder: (context) {
                Future.delayed(Duration(milliseconds: 100), () {
                  data[index + 1].context = context;
                  data[index + 1].height = context.size.height;
                });
                return swapIndex.contains(index + 1)
                    ? Container(height: data[index + 1].height)
                    : data[index + 1].widget;
              });
            },
            itemCount: widget.children.length - 1,
          ),
          Builder(builder: (context) {
            Future.delayed(Duration(milliseconds: 100), () {
              data.first.context = context;
              data.first.height = context.size.height;
            });
            return swapIndex.contains(0)
                ? Container(height: data.first.height)
                : data.first.widget;
          })
        ],
      ),
    );
  }

  swap(int first, int second, int thrid) {
    setState(() {
      swapIndex = [first, second, thrid];
    });
    Navigator.push(
            context,
            WPopupPage(
                data1: data[first],
                data2: data[second],
                data3: data[thrid],
                duration: widget.duration))
        .then((v) {
      setState(() {
        var temp = data[first];
        data[first] = data[thrid];
        data[thrid] = data[second];
        data[second] = temp;
        widget.onIndexChanged(first, second, thrid);
        swapIndex = [];
      });
    });
  }
}

class WPopupPage extends PopupRoute {
  final WReorderData data1;
  final WReorderData data2;
  final WReorderData data3;
  final Duration duration;

  WPopupPage(
      {@required this.data1,
      @required this.data2,
      @required this.data3,
      @required this.duration});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return SwapIndexWidget(
        data1: data1, data2: data2, data3: data3, duration: duration);
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 100);
}

class SwapIndexWidget extends StatefulWidget {
  final WReorderData data1;
  final WReorderData data2;
  final WReorderData data3;
  final Duration duration;

  SwapIndexWidget(
      {@required this.data1,
      @required this.data2,
      @required this.data3,
      @required this.duration});

  @override
  _SwapIndexWidgetState createState() => _SwapIndexWidgetState();
}

class _SwapIndexWidgetState extends State<SwapIndexWidget> {
  RenderBox rb1;
  RenderBox rb2;
  RenderBox rb3;
  Rect child1Rect;
  Rect child2Rect;
  Rect child3Rect;
  Widget child1;
  Widget child2;
  Widget child3;

  @override
  void initState() {
    super.initState();
    rb1 = widget.data1.context.findRenderObject();
    rb2 = widget.data2.context.findRenderObject();
    rb3 = widget.data3.context.findRenderObject();
    child1Rect = Rect.fromPoints(rb1.localToGlobal(Offset.zero),
        rb1.localToGlobal(Offset(rb1.size.width, rb1.size.height)));
    child2Rect = Rect.fromPoints(rb2.localToGlobal(Offset.zero),
        rb2.localToGlobal(Offset(rb2.size.width, rb2.size.height)));
    child3Rect = Rect.fromPoints(rb3.localToGlobal(Offset.zero),
        rb3.localToGlobal(Offset(rb3.size.width, rb3.size.height)));

    child1 = widget.data1.widget;
    child2 = widget.data2.widget;
    child3 = widget.data3.widget;

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        var temp = child1Rect;
        child1Rect = child2Rect;
        child2Rect = child3Rect;
        child3Rect = temp;
      });
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          child1 = Container();
          child2 = Container();
          child3 = Container();
        });
        Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          AnimatedPositioned.fromRect(
            duration: widget.duration,
            rect: child2Rect,
            child: AnimatedOpacity(
                duration: widget.duration, opacity: 0.8, child: child2),
          ),
          AnimatedPositioned.fromRect(
            duration: widget.duration,
            rect: child3Rect,
            child: AnimatedOpacity(
                duration: widget.duration, opacity: 0.8, child: child3),
          ),
          AnimatedPositioned.fromRect(
            duration: widget.duration,
            rect: child1Rect,
            child: AnimatedOpacity(
                duration: widget.duration, opacity: 0.8, child: child1),
          ),
        ],
      ),
    );
  }
}
