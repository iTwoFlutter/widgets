import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/util/util_extension.dart';

typedef SkuItemWidgetBuilder = Widget Function(BuildContext context, ISkuTag sku);

/// zeroStockSelectEnable  库存为0时，tag是否可选
class Sku extends StatefulWidget {
  final List<ISkuBean> skuBeanList;
  final void Function(ISkuBean sku) onSelected;
  final bool zeroStockSelectEnable;

  Sku({
    Key key,
    @required this.skuBeanList,
    @required this.onSelected,
    this.zeroStockSelectEnable = true,
  }) : super(key: key);

  @override
  _SkuState createState() => _SkuState();
}

class _SkuState extends State<Sku> {
  SkuItemWidgetBuilder normalItemBuild;

  SkuItemWidgetBuilder selectedItemBuild;

  SkuItemWidgetBuilder disableItemBuild;

  List<List<ISkuTag>> _dataList = List<List<ISkuTag>>();
  HashSet<ISkuTag> _selectedTagList = HashSet<ISkuTag>();
  Map<String, String> _selectedTagMapTemp = {};

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: _dataList.length, itemBuilder: (c, i) => _buildAttribute(c, _dataList[i]));
  }

  Widget _buildAttribute(BuildContext context, List<ISkuTag> _skuTagList) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_skuTagList.first?.key ?? "", style: TextStyle(fontSize: 16, color: Color(0xFF333333))),
        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        Container(
          width: double.infinity,
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 8,
            runAlignment: WrapAlignment.start,
            runSpacing: 10,
            children: _skuTagList.map((e) => _buildItem(context, e)).toList(),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 8)),
      ],
    );
  }

  Widget _buildItem(BuildContext context, ISkuTag tag) {
    if (tag.state == _SkuTagState.normal) {
      return GestureDetector(behavior: HitTestBehavior.translucent, child: normalItemBuild?.call(context, tag) ?? _defaultNormalItem(tag), onTap: () => _onTap(tag));
    } else if (tag.state == _SkuTagState.selected) {
      return GestureDetector(behavior: HitTestBehavior.translucent, child: selectedItemBuild?.call(context, tag) ?? _defaultSelectItem(tag), onTap: () => _onTap(tag));
    } else {
      return disableItemBuild?.call(context, tag) ?? _defaultDisableItem(tag);
    }
  }

  Widget _defaultNormalItem(ISkuTag bean) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
      child: Text(bean.value, style: TextStyle(color: Color(0xFF666666))),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(15))),
    );
  }

  Widget _defaultSelectItem(ISkuTag bean) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
      child: Text(bean.value, style: TextStyle(color: Colors.grey[200])),
      decoration: BoxDecoration(color: Colors.grey, border: Border.all(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(15))),
    );
  }

  Widget _defaultDisableItem(ISkuTag bean) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
      child: Text(bean.value, style: TextStyle(color: Colors.grey[400])),
      decoration: BoxDecoration(color: Colors.grey[300], border: Border.all(color: Colors.grey[300]), borderRadius: BorderRadius.all(Radius.circular(15))),
    );
  }

  void _initData() {
    Map<String, List<ISkuTag>> map = Map<String, List<ISkuTag>>();
    widget.skuBeanList.forEach((element) {
      // ISkuBean bean=element;
      element.skuTagMap.forEach((key, value) {
        var list = map[key] ?? <ISkuTag>[];
        var iSkuTag = ISkuTag(key: key, value: value);
        if (!list.contains(iSkuTag)) {
          list.add(iSkuTag);
        }
        map[key] = list;
      });
    });
    _dataList.addAll(map.values);
  }

  void _onTap(ISkuTag tag) {
    if (tag.state == _SkuTagState.normal) {
      tag.state = _SkuTagState.selected;
      //从已选中移除相同的规格目录
      _selectedTagList.removeWhere((element) => element.key == tag.key);
      _selectedTagList.add(tag);
    } else {
      tag.state = _SkuTagState.normal;
      _selectedTagList.remove(tag);
    }

    _dataList.forEach((list) {
      for (var value in list) {
        var bool = _selectable(value);
        //未选中的 tag 先变成 normal
        if (!_selectedTagList.contains(value)) value.state = _SkuTagState.normal;
        if (!bool) {
          //不可选的 tag
          value.state = _SkuTagState.disable;
        }
      }
    });
    if (mounted) setState(() {});
    var map = {};
    _selectedTagList.forEach((element) => map[element.key] = element.value);
    ISkuBean chooseBean;
    widget.skuBeanList.forEach((element) {
      var all = map.containsAll(element.skuTagMap);
      if (all) chooseBean = element;
    });
    widget.onSelected?.call(chooseBean);
  }

  //每个 tag 是否可选
  bool _selectable(ISkuTag tag) {
    //传入 tag  已选
    if (_selectedTagList.contains(tag)) return true;
    _selectedTagMapTemp.clear();
    //已选的 tag 转成 map
    _selectedTagList.forEach((element) => _selectedTagMapTemp[element.key] = element.value);
    //把想判断的 tag 加入临时 map中
    _selectedTagMapTemp[tag.key] = tag.value;

    //包含已选 tag 和当前判断的 ISkuTag 的原始 skuBean
    List<ISkuBean> containsSkuTag = widget.skuBeanList.filter((e) => e.skuTagMap.containsAll(_selectedTagMapTemp));
    if (containsSkuTag == null || containsSkuTag.isEmpty) return false;
    if (!widget.zeroStockSelectEnable) {
      var bool = containsSkuTag.any((element) => element.iSkuStock != 0);
      return bool;
    }
    return true;
  }
}

enum _SkuTagState { normal, selected, disable }

class ISkuTag {
  String key;
  String value;
  _SkuTagState state = _SkuTagState.normal;

  ISkuTag({this.key, this.value});

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is ISkuTag && runtimeType == other.runtimeType && key == other.key && value == other.value;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode;

  Map<String, dynamic> toJson() {
    return {"key": key, "value": value, "state": state};
  }

  @override
  String toString() {
    return 'ISkuTag{key: $key, value: $value, state: $state}';
  }
}

//外部传入的规格列表
class ISkuBean {
  final dynamic iSkuBeanId; //sku id
  final int iSkuStock; // sku 库存
  final Map<String, String> skuTagMap;

  ISkuBean({this.iSkuBeanId, this.iSkuStock, this.skuTagMap});

  @override
  String toString() {
    return 'ISkuBean{iSkuBeanId: $iSkuBeanId, iSkuStock: $iSkuStock, skuTagMap: $skuTagMap}';
  }
}

class SkuAttributeBean {
  final String key;
  final String value;

  SkuAttributeBean(this.key, this.value);
}
