import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  Indicator({
    this.controller,
    this.itemCount: 0,
  }) : assert(controller != null);

  /// PageView的控制器
  final PageController controller;

  /// 指示��的个数
  final int itemCount;

  /// 普通的颜色
  final Color normalColor = Colors.grey[300];

  /// 选中的颜色
  final Color selectedColor = Colors.grey;

  /// 点的大小
  final double size = 8.0;

  /// 点的间距
  final double spacing = 4.0;

  /// 点的Widget
  Widget _buildIndicator(int index, int pageCount, double dotSize, double spacing) {
    // 是否是当前页面被选中
    bool isCurrentPageSelected = index == (controller.page != null ? controller.page.round() % pageCount : 0);

    return Container(
      height: size,
      width: size + (2 * spacing),
      child: Center(
        child: Material(
          color: isCurrentPageSelected ? selectedColor : normalColor,
          type: MaterialType.circle,
          child: Container(
            width: dotSize,
            height: dotSize,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, (int index) {
        return _buildIndicator(index, itemCount, size, spacing);
      }),
    );
  }
}
