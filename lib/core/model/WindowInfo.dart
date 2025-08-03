class WindowInfo {
  final int left;
  final int top;
  final int right;
  final int bottom;

  WindowInfo(this.left, this.top, this.right, this.bottom);

  @override
  String toString() => '左: $left, 上: $top, 右: $right, 下: $bottom';
}