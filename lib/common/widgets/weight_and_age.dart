import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/common/constants/colors.dart';
import 'package:bmi_calculator/common/types.dart';
import 'package:bmi_calculator/common/utils.dart';

import 'enum_based_drop_down.dart';
import 'generic_card.dart';

class WeightAndAge extends StatelessWidget {
  const WeightAndAge({
    super.key,
    required this.state,
  });
  final BmiState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = textThemeOf(context);
    return Row(
      children: [
        Expanded(
          child: WeightSelector(
            textTheme: textTheme,
            state: state,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AgeInput(
            textTheme: textTheme,
            state: state,
          ),
        ),
      ],
    );
  }
}

class AgeInput extends StatelessWidget {
  const AgeInput({
    super.key,
    required this.textTheme,
    required this.state,
  });

  final TextTheme textTheme;
  final BmiState state;

  @override
  Widget build(BuildContext context) {
    return GenericCard(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Age',
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                key: ValueKey(state.weightUnit),
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryText,
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLines: 1,
                decoration: const InputDecoration.collapsed(
                  hintText: '',
                ),
                onChanged: (value) {
                  final number = (num.tryParse(value) ?? 0).toInt();
                  context.read<BmiBloc>().add(UpdateAge(number));
                },
                initialValue: state.age.toString(),
              ),
              const SizedBox(
                width: 100,
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Divider(color: primary, thickness: 4),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class WeightSelector extends StatelessWidget {
  const WeightSelector({
    super.key,
    required this.textTheme,
    required this.state,
  });

  final TextTheme textTheme;
  final BmiState state;

  @override
  Widget build(BuildContext context) {
    return GenericCard(children: [
      EnumDropDown<Weight>(
        value: state.weightUnit,
        values: Weight.values,
        onChanged: (value) {
          if (value == null) return;
          context.read<BmiBloc>().add(UpdateWeightUnit(value));
        },
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              key: ValueKey(state.weightUnit),
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: primaryText,
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLines: 1,
              decoration: const InputDecoration.collapsed(
                hintText: '',
              ),
              onChanged: (value) {
                final number = (num.tryParse(value) ?? 0).toDouble();
                if (state.weightUnit == Weight.kgs) {
                  context.read<BmiBloc>().add(UpdateWeight(number));
                } else {
                  context
                      .read<BmiBloc>()
                      .add(UpdateWeight(convertLbsToKgs(number)));
                }
              },
              initialValue: state.formattedWeight,
            ),
            const SizedBox(
              width: 100,
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: Divider(color: primary, thickness: 4),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
