import 'dart:async';

import 'package:flutter/cupertino.dart';

/// 倒计时的 text

typedef CountDownWidgetBuilder = Widget Function(BuildContext context, int tick);

class CustomCountDown extends StatefulWidget {
  final CountDownWidgetBuilder startChild; //开始的 widget
  final CountDownWidgetBuilder endChild; //结束的 widget
  final CountDownWidgetBuilder processChild; //进行中的 widget
  final CountDownWidgetBuilder disableChild;
  bool clickEnable; //是否允许开始倒计时
  int count; //总时间，默认60

  CustomCountDown({
    @required this.startChild,
    this.endChild,
    this.processChild,
    this.disableChild,
    this.clickEnable = true,
    this.count = 60,
  });

  @override
  _CustomCountDownState createState() => _CustomCountDownState();
}

class _CustomCountDownState extends State<CustomCountDown> {
  var _countStreamController = StreamController<int>();
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _countStreamController.stream,
      initialData: 0,
      builder: (context, snapshot) => _buildWidget(context, snapshot),
    );
  }

  Widget _buildWidget(BuildContext context, AsyncSnapshot<int> snapshot) {
    var tick = snapshot.data;
    if (tick > 0 && tick < widget.count) return widget.processChild.call(context, widget.count - tick);
    if (!widget.clickEnable) {
      return widget.disableChild?.call(context, tick) ?? widget.startChild.call(context, tick);
    }
    if (tick >= widget.count) return GestureDetector(behavior: HitTestBehavior.translucent, onTap: _onTop, child: widget.endChild.call(context, tick));
    var widgetStart = widget.startChild.call(context, tick);
    return GestureDetector(behavior: HitTestBehavior.translucent, onTap: _onTop, child: widgetStart);
  }

  _onTop() {
    if (timer != null && !timer.isActive) timer = null;
    if (!widget.clickEnable) return;
    if (timer == null) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        var tick = timer.tick;
        _countStreamController.sink.add(tick);
        if (tick >= widget.count) {
          timer.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _countStreamController?.close();
    timer?.cancel();
  }
}
