import 'package:flutter/widgets.dart';

enum RelativeOverFlow {
  ///子布局无法超出父布局的限制，始终会在父布局内。
  inside,

  ///子布局可以超出父布局的限制
  overflow,
}

class RelativeId {
  String id;
  RelativeOverFlow overFlow;

  //默认位置，未指定相对关系的轴将会使用alignment的位置
  Alignment alignment;

  String toLeftOf;
  String toRightOf;
  String below;
  String above;

  String alignLeft;
  String alignRight;
  String alignTop;
  String alignBottom;

  RelativeId(
    this.id, {
    this.overFlow = RelativeOverFlow.overflow,
    this.alignment = Alignment.center,
    this.toLeftOf,
    this.toRightOf,
    this.above,
    this.below,
    this.alignLeft,
    this.alignRight,
    this.alignTop,
    this.alignBottom,
  })  : assert(
            isAtMostOneSpecified([toLeftOf, toRightOf, alignLeft, alignRight]),
            'toRightOf、toLeftOf、alignLeft、alignRight can only specify one'),
        assert(isAtMostOneSpecified([above, below, alignTop, alignBottom]),
            'above、below、alignTop、alignBottom can only specify one');

  ///返回是否只有一个属性被赋值，其他都是null
  static bool isAtMostOneSpecified(List<String> fields) {
    int nonullCount = 0;
    fields.map((e) {
      if (e != null) {
        nonullCount++;
      }
    }).toList();
    return nonullCount <= 1;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RelativeId && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
