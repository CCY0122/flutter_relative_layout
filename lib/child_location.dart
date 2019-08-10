import 'dart:ui';

class ChildLocation {
  //宽高
  Size _size;
  //坐标
  Offset _location;

  Size get size => _size;

  Offset get location => _location;

  ChildLocation(this._size, this._location);
}
