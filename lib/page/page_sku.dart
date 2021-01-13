

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/widgets/widget_sku.dart';

class SkuPage extends StatefulWidget {
  @override
  _SkuPageState createState() => _SkuPageState();
}

class _SkuPageState extends State<SkuPage> {
  List<ISkuBean> dataList = List<ISkuBean>()
    ..add(ISkuBean(iSkuBeanId: 1, iSkuStock: 0, skuTagMap: {"内存": "16G", "硬盘": "256G", "CPU": "I7 7770", "显卡": "GTX 660"}))
    ..add(ISkuBean(iSkuBeanId: 2, iSkuStock: 100, skuTagMap: {"内存": "32G", "硬盘": "256G", "CPU": "I7 7770", "显卡": "GTX 660"}))
    ..add(ISkuBean(iSkuBeanId: 3, iSkuStock: 100, skuTagMap: {"内存": "8G", "硬盘": "256G", "CPU": "I7 7770", "显卡": "GTX 660"}))
    ..add(ISkuBean(iSkuBeanId: 4, iSkuStock: 100, skuTagMap: {"内存": "64G", "硬盘": "256G", "CPU": "I7 7770", "显卡": "GTX 660"}))
    ..add(ISkuBean(iSkuBeanId: 5, iSkuStock: 100, skuTagMap: {"内存": "16G", "硬盘": "512G", "CPU": "I7 7770", "显卡": "GTX 660"}))
    ..add(ISkuBean(iSkuBeanId: 6, iSkuStock: 100, skuTagMap: {"内存": "16G", "硬盘": "1T", "CPU": "I7 7770", "显卡": "GTX 660"}))
    ..add(ISkuBean(iSkuBeanId: 7, iSkuStock: 100, skuTagMap: {"内存": "16G", "硬盘": "256G", "CPU": "I5 1040", "显卡": "GTX 660"}))
    ..add(ISkuBean(iSkuBeanId: 8, iSkuStock: 100, skuTagMap: {"内存": "16G", "硬盘": "256G", "CPU": "I5 1040", "显卡": "GTX 670"}))
    ..add(ISkuBean(iSkuBeanId: 9, iSkuStock: 100, skuTagMap: {"内存": "16G", "硬盘": "256G", "CPU": "I5 1040", "显卡": "GTX 1060"}))
    ..add(ISkuBean(iSkuBeanId: 10, iSkuStock: 100, skuTagMap: {"内存": "16G", "硬盘": "256G", "CPU": "I5 1040", "显卡": "GTX 1070"}))
    ..add(ISkuBean(iSkuBeanId: 11, iSkuStock: 100, skuTagMap: {"内存": "16G", "硬盘": "256G", "CPU": "I3 1060", "显卡": "GTX 1070"}))
    ..add(ISkuBean(iSkuBeanId: 12, iSkuStock: 100, skuTagMap: {"内存": "32G", "硬盘": "256G", "CPU": "I3 1060", "显卡": "GTX 1070"}))
    ..add(ISkuBean(iSkuBeanId: 13, iSkuStock: 100, skuTagMap: {"内存": "32G", "硬盘": "256G", "CPU": "I9 1160", "显卡": "GTX 1070"}))
    ..add(ISkuBean(iSkuBeanId: 14, iSkuStock: 100, skuTagMap: {"内存": "32G", "硬盘": "256G", "CPU": "I9 1260", "显卡": "GTX 1070"}))
  ;
  var result="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sku")),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Container(padding: EdgeInsets.all(15),height: 100, child: Text(result)),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Expanded(child: Padding(padding: const EdgeInsets.all(15), child: Sku(skuBeanList: dataList,zeroStockSelectEnable: false,  onSelected: (sku) => setState(()=>result=sku.toString())))),
          ],
        ),
      ),
    );
  }
}
