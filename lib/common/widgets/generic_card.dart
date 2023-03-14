import 'package:flutter/material.dart';

import 'package:bmi_calculator/common/constants/colors.dart';

class GenericCard extends StatelessWidget {
  const GenericCard({
    super.key,
    this.children = const [],
    this.width,
    this.height = 180,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
  });

  final List<Widget> children;

  /// If non-null, requires the child to have exactly this width.
  final double? width;

  /// If non-null, requires the child to have exactly this height.
  final double? height;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      height: height,
      width: width,
      child: Card(
        elevation: 10,
        shadowColor: shadowColor,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: padding,
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
