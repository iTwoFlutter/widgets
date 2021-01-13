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

# [获取验证码控件](https://github.com/iTwoFlutter/widgets/blob/master/lib/widgets/widget_count_down.dart)
```dart
  CustomCountDown({
  // 倒计时开始时的 widget
    @required this.startChild,
    // 倒计时结束时的 widget
    this.endChild,
    // 倒计时进行中的 widget
    this.processChild,
    // 不允许点击时的 widget
    this.disableChild,
    // 是否于心点击t
    this.clickEnable = true,
    // 倒计时时长
    this.count = 60,
  });
```
<img width="216" height="384" src="https://github.com/iTwoFlutter/widgets/blob/master/png/count_down.gif"/>