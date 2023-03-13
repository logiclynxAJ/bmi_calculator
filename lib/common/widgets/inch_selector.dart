import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/common/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'numberpicker.dart';

class InchSelector extends StatelessWidget {
  const InchSelector({
    super.key,
    required this.state,
    required this.textTheme,
    required this.themeData,
  });

  final BmiState state;
  final TextTheme textTheme;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shadowColor: shadowColor,
            child: NumberPicker(
              minValue: 0,
              maxValue: 15,
              value: state.heightInFeet,
              infiniteLoop: true,
              onChanged: (value) {
                final localInches = (value * 12) + state.heightInInches;
                context
                    .read<BmiBloc>()
                    .add(UpdateHeight(localInches.toDouble()));
              },
              selectedTextStyle: textTheme.titleLarge?.copyWith(
                color: themeData.colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
              textStyle: textTheme.titleMedium?.copyWith(
                color: Colors.grey,
              ),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: themeData.colorScheme.primary,
                    width: 1.5,
                  ),
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 24),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Card(
            shadowColor: shadowColor,
            child: NumberPicker(
              infiniteLoop: true,
              minValue: 0,
              maxValue: 11,
              value: state.heightInInches,
              onChanged: (value) {
                final localInches = (state.heightInFeet * 12) + value;
                context
                    .read<BmiBloc>()
                    .add(UpdateHeight(localInches.toDouble()));
              },
              selectedTextStyle: textTheme.titleLarge?.copyWith(
                color: themeData.colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
              textStyle: textTheme.titleMedium?.copyWith(
                color: Colors.grey,
              ),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: themeData.colorScheme.primary,
                    width: 1.5,
                  ),
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 24),
            ),
          ),
        ),
      ],
    );
  }
}
