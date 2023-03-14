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
          child: CustomPicker(
            state: state,
            textTheme: textTheme,
            themeData: themeData,
            suffix: 'ft',
            min: 0,
            max: 15,
            value: state.heightInFeet,
            onChanged: (value) {
              final localInches = (value * 12) + state.heightInInches;
              context.read<BmiBloc>().add(UpdateHeight(localInches.toDouble()));
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomPicker(
            state: state,
            textTheme: textTheme,
            themeData: themeData,
            suffix: 'in',
            min: 0,
            max: 11,
            value: state.heightInInches,
            onChanged: (value) {
              final localInches = (state.heightInFeet * 12) + value;
              context.read<BmiBloc>().add(UpdateHeight(localInches.toDouble()));
            },
          ),
        ),
      ],
    );
  }
}

class CustomPicker extends StatelessWidget {
  const CustomPicker({
    super.key,
    required this.state,
    required this.textTheme,
    required this.themeData,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
    required this.suffix,
  });

  final BmiState state;
  final TextTheme textTheme;
  final ThemeData themeData;
  final int min, max, value;
  final void Function(int) onChanged;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor,
      child: NumberPicker(
        suffix: suffix,
        minValue: min,
        maxValue: max,
        value: value,
        onChanged: onChanged,
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
    );
  }
}
