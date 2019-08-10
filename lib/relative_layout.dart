library relative_layout;

import 'package:flutter/widgets.dart';

import 'relative_layout_delegate.dart';

export 'relative_id.dart';

class RelativeLayout extends CustomMultiChildLayout {
  RelativeLayout({
    Key key,
    List<Widget> children = const <Widget>[],
  }) : super(
            key: key,
            delegate: RelativeLayoutDelegate(
                RelativeLayoutDelegate.generateIds(children)),
            children: children);
}
