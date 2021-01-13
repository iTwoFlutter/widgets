/// 倒计时的 widget

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/widgets/widget_count_down.dart';

class CountDownPage extends StatefulWidget {
  @override
  _CountDownPageState createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage> {
  TextEditingController _controller = TextEditingController();
  var _countDownEnable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("倒计时")),body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
          Container(margin: EdgeInsets.only(top: 20), alignment: Alignment.center, child: _buildCustomCountDown),
          Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
          Container(
            margin: EdgeInsets.all(20),
            height: 50,
            padding: EdgeInsets.only(left: 15,right: 15),
            decoration: ShapeDecoration(color: Colors.white, shape: OutlineInputBorder( borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.all(Radius.circular(10)))),
            alignment: Alignment.center,
            child: CupertinoTextField(
              decoration: BoxDecoration(color: Colors.transparent),
              placeholder:"请输入手机号",
              textAlign: TextAlign.end,
              controller: _controller,
              onChanged: (s) => setState(() => _countDownEnable = (s?.length ?? 0) >= 5),
            ),
          ),
        ],
      ),

    ));
  }
  Widget get _buildCustomCountDown => CustomCountDown(
    startChild: (c, i) => Container(width: 180, height: 50, color: Colors.blue, alignment: Alignment.center, child: Text("获取验证码",style: TextStyle(color: Colors.white),)),
    endChild: (c, i) => Container(width: 180, height: 50, color: Colors.blue, alignment: Alignment.center, child: Text("重新验证码",style: TextStyle(color: Colors.white),)),
    processChild: (c, i) => Container(width: 180, height: 50, color: Colors.blue, alignment: Alignment.center, child: Text("倒计时 $i 秒",style: TextStyle(color: Colors.white),)),
    disableChild: (c, i) => Container(width: 180, height: 50, color: Colors.blue, alignment: Alignment.center, child: Text("禁止点击",style: TextStyle(color: Colors.white),)),
    clickEnable: _countDownEnable,
  );
}
