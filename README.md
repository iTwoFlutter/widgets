# Flutter Widgets

各种常用的 Widget 实现

#### [Sku](https://github.com/iTwoFlutter/widgets/blob/master/lib/widgets/widget_sku.dart)
```dart
  Sku({
    Key key,
    // 后台返回的 sku 列表
    @required this.skuBeanList,
    // sku 的选择监听
    @required this.onSelected,
    // 0库存的是否允许选择
    this.zeroStockSelectEnable = true,
  });
```

<img width="216" height="384" src="https://github.com/iTwoFlutter/widgets/blob/master/png/sku.gif"/>
