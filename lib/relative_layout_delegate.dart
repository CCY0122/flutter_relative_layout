import 'package:flutter/widgets.dart';

import 'child_location.dart';
import 'relative_layout.dart';

class RelativeLayoutDelegate extends MultiChildLayoutDelegate {
  List<RelativeId> ids;

  Map<RelativeId, ChildLocation> childrenLocations = {};

  RelativeLayoutDelegate(this.ids);

  static generateIds(List<Widget> children) {
    List<RelativeId> ids = children.map((e) {
      assert(e is LayoutId, "RelativeLayout's children must be [LayoutId]");
      assert((e as LayoutId).id is RelativeId,
          "[LayoutId]'s [id] must be [RelativeId]");
      return ((e as LayoutId).id as RelativeId);
    }).toList();

    return ids;
  }

  @override
  void performLayout(Size size) {
    for (RelativeId id in ids) {
      if (hasChild(id)) {
        Size childSize;
        if (id.overFlow == RelativeOverFlow.inside) {
          //如果子布局不能超出父布局，那么它最大宽高不能超过父的宽高
          childSize = layoutChild(id, BoxConstraints.loose(size));
        } else {
          //如果子布局允许超出父布局，那么不限制它的最大宽高
          childSize = layoutChild(id, BoxConstraints());
        }

        //根据alignment的x、y值的含义易知：f(x) = 0.5x + 0.5;
        Alignment alignment = id.alignment;
        double xFraction = (0.5 * alignment.x + 0.5);
        double x = (size.width - childSize.width) * xFraction;

        double yFraction = (0.5 * alignment.y + 0.5);
        double y = (size.height - childSize.height) * yFraction;

        x = convertX(x, id, childSize);
        y = convertY(y, id, childSize);

        if (id.overFlow == RelativeOverFlow.inside) {
          x = x.clamp(0.0, size.width - childSize.width);
          y = y.clamp(0.0, size.height - childSize.height);
        }

        Offset childLocation = Offset(x, y);
        positionChild(id, childLocation);
        childrenLocations[id] = ChildLocation(childSize, childLocation);
      }
    }
  }

  ///x轴转换
  ///[x]默认x值
  ///[id]当前child对应的id
  ///[childSize]当前child的size
  double convertX(double x, RelativeId id, Size childSize) {
    ChildLocation relativedChildLocation;
    if ((relativedChildLocation = childrenLocations[RelativeId(id.toLeftOf)]) !=
        null) {
      x = relativedChildLocation.location.dx - childSize.width;
    } else if ((relativedChildLocation =
            childrenLocations[RelativeId(id.toRightOf)]) !=
        null) {
      x = relativedChildLocation.location.dx +
          relativedChildLocation.size.width;
    } else if ((relativedChildLocation =
            childrenLocations[RelativeId(id.alignLeft)]) !=
        null) {
      x = relativedChildLocation.location.dx;
    } else if ((relativedChildLocation =
            childrenLocations[RelativeId(id.alignRight)]) !=
        null) {
      x = relativedChildLocation.location.dx +
          relativedChildLocation.size.width -
          childSize.width;
    }
    return x;
  }

  ///y轴转换
  ///[y]默认x值
  ///[id]当前child对应的id
  ///[childSize]当前child的size
  double convertY(double y, RelativeId id, Size childSize) {
    ChildLocation relativedChildLocation;
    if ((relativedChildLocation = childrenLocations[RelativeId(id.above)]) !=
        null) {
      y = relativedChildLocation.location.dy - childSize.height;
    } else if ((relativedChildLocation =
            childrenLocations[RelativeId(id.below)]) !=
        null) {
      y = relativedChildLocation.location.dy +
          relativedChildLocation.size.height;
    } else if ((relativedChildLocation =
            childrenLocations[RelativeId(id.alignTop)]) !=
        null) {
      y = relativedChildLocation.location.dy;
    } else if ((relativedChildLocation =
            childrenLocations[RelativeId(id.alignBottom)]) !=
        null) {
      y = relativedChildLocation.location.dy +
          relativedChildLocation.size.height -
          childSize.height;
    }
    return y;
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    childrenLocations.clear();
    return true;
  }
}
