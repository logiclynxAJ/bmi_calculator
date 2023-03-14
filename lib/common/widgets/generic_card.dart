import 'package:flutter/material.dart';

import 'package:bmi_calculator/common/constants/colors.dart';

class GenericCard extends StatelessWidget {
  const GenericCard({super.key, this.children = const []});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Card(
        elevation: 10,
        shadowColor: shadowColor,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
