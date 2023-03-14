import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/common/constants/colors.dart';
import 'package:bmi_calculator/common/types.dart';
import 'package:bmi_calculator/common/utils.dart';
import 'package:bmi_calculator/common/widgets/gender_selector.dart';
import 'package:bmi_calculator/common/widgets/height_selector.dart';
import 'package:bmi_calculator/common/widgets/inch_selector.dart';
import 'package:bmi_calculator/common/widgets/numberpicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = textThemeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: background,
      body: BlocBuilder<BmiBloc, BmiState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                GenderSelector(state: state),
                const SizedBox(height: 16),
                HeightSelector(state: state),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
