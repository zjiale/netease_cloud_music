import 'package:flutter/material.dart';

typedef bool CanAccept(int oldIndex, int newIndex);

typedef Widget DataWidgetBuilder<T>(BuildContext context, T data);

class SortableGridView<T> extends StatefulWidget {
  final DataWidgetBuilder<T>
      itemBuilder; //用于生成GridView的Item Widget的函数，接收一个context参数和一个数据源参数，返回一个Widget
  final CanAccept canAccept; //是否接受拖拽过来的数据的回调函数
  final List<T> dataList; //数据源List
  final Axis scrollDirection; //GridView的滚动方向

  SortableGridView(
    this.dataList, {
    Key key,
    this.scrollDirection = Axis.vertical,
    @required this.itemBuilder,
    @required this.canAccept,
  })  : assert(itemBuilder != null),
        assert(canAccept != null),
        assert(dataList != null && dataList.length >= 0),
        super(key: key);
  @override
  State<StatefulWidget> createState() => _SortableGridViewState<T>();
}

class _SortableGridViewState<T> extends State<SortableGridView> {
  List<T> _dataList; //数据源
  List<T> _dataListBackup; //数据源备份，在拖动时 会直接在数据源上修改 来影响UI变化，当拖动取消等情况，需要通过备份还原
  bool _showItemWhenCovered = false; //手指覆盖的地方，即item被拖动时 底部的那个widget是否可见；
  int _willAcceptIndex = -1; //当拖动覆盖到某个item上的时候，记录这个item的坐标
//  int _draggingItemIndex = -1; //当前被拖动的item坐标
//  ScrollController _scrollController;//当item数量超出屏幕 拖动Item到底部或顶部 可使用ScrollController滚动GridView 实现自动滚动的效果。

  @override
  void initState() {
    super.initState();
    _dataList = widget.dataList;
    _dataListBackup = _dataList.sublist(0);
//    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: _buildGridChildren(context).reversed.toList());
  }

  //生成widget列表
  List<Widget> _buildGridChildren(BuildContext context) {
    final List list = List<Widget>();
    double offset = 50.0;
    for (int x = 0; x < _dataList.length; x++) {
      list.add(Transform.translate(
          offset: x == 0 ? Offset.zero : Offset(x == 1 ? -offset : offset, 0),
          child: Container(width: 100.0, child: _buildDraggable(context, x))));
    }
    return list;
  }

  //绘制一个可拖拽的控件。
  Widget _buildDraggable(BuildContext context, int index) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return LongPressDraggable(
          data: index,
          axis: Axis.horizontal,
          child: DragTarget<int>(
            //松手时 如果onWillAccept返回true 那么久会调用，本案例不使用。
            onAccept: (int data) {},
            //绘制widget
            builder: (context, data, rejects) {
              return _willAcceptIndex >= 0 && _willAcceptIndex == index
                  ? null
                  : widget.itemBuilder(context, _dataList[index]);
            },
            //手指拖着一个widget从另一个widget头上滑走时会调用
            onLeave: (int data) {
              //TODO 这里应该还可以优化，当用户滑出而又没有滑入某个item的时候 可以重新排列  让当前被拖走的item的空白被填满
              print('$data is Leaving item $index');
              _willAcceptIndex = -1;
              setState(() {
                _showItemWhenCovered = false;
                _dataList = _dataListBackup.sublist(0);
              });
            },
            //接下来松手 是否需要将数据给这个widget？  因为需要在拖动时改变UI，所以在这里直接修改数据源
            onWillAccept: (int fromIndex) {
              print('$index will accept item $fromIndex');
              final accept = fromIndex != index;
              if (accept) {
                _willAcceptIndex = index;
                _showItemWhenCovered = true;
                _dataList = _dataListBackup.sublist(0);
                final fromData = _dataList[fromIndex];
                setState(() {
                  _dataList.removeAt(fromIndex);
                  _dataList.insert(index, fromData);
                });
              }
              return accept;
            },
          ),
          onDragStarted: () {
            //开始拖动，备份数据源
//            _draggingItemIndex = index;
            _dataListBackup = _dataList.sublist(0);
            print('item $index ---------------------------onDragStarted');
          },
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            print(
                'item $index ---------------------------onDraggableCanceled,velocity = $velocity,offset = $offset');
            //拖动取消，还原数据源

            setState(() {
              _willAcceptIndex = -1;
              _showItemWhenCovered = false;
              _dataList = _dataListBackup.sublist(0);
            });
          },
          onDragCompleted: () {
            //拖动完成，刷新状态，重置willAcceptIndex
            print("item $index ---------------------------onDragCompleted");
            setState(() {
              _showItemWhenCovered = false;
              _willAcceptIndex = -1;
            });
          },
          //用户拖动item时，那个给用户看起来被拖动的widget，（就是会跟着用户走的那个widget）
          feedback: SizedBox(
            width: constraint.maxWidth,
            height: constraint.maxHeight,
            child: widget.itemBuilder(context, _dataList[index]),
          ),
          //这个是当item被拖动时，item原来位置用来占位的widget，（用户把item拖走后原来的地方该显示啥？就是这个）
          childWhenDragging: Container(
            child: SizedBox(
              child: _showItemWhenCovered
                  ? widget.itemBuilder(context, _dataList[index])
                  : null,
            ),
          ),
        );
      },
    );
  }
}
