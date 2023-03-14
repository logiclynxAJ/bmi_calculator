import 'package:bmi_calculator/common/constants/colors.dart';
import 'package:bmi_calculator/common/utils.dart';
import 'package:flutter/material.dart';

class BMIResults extends StatelessWidget {
  const BMIResults({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = textThemeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Your Result',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
