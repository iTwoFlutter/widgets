import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgets/page/page_count_down.dart';
import 'package:flutter_widgets/page/page_sku.dart';

void main() {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Widgets', theme: ThemeData(platform: TargetPlatform.iOS, brightness: Brightness.light), home: _Home());
  }
}

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Widgets")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              CupertinoButton(child: Text("Sku"), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => SkuPage())), color: Colors.blue),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              CupertinoButton(child: Text("倒计时"), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => CountDownPage())), color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
