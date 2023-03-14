import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/common/constants/colors.dart';
import 'package:bmi_calculator/common/types.dart';
import 'package:bmi_calculator/common/utils.dart';
import 'package:bmi_calculator/common/widgets/enum_based_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'inch_selector.dart';

class HeightSelector extends StatelessWidget {
  const HeightSelector({super.key, required this.state});

  final BmiState state;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = textThemeOf(context);
    return Card(
      shadowColor: shadowColor,
      surfaceTintColor: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: AnimatedContainer(
        height: state.heightUnit == Height.inch ? 280 : 230,
        duration: kThemeAnimationDuration,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            EnumDropDown<Height>(
              value: state.heightUnit,
              onChanged: (value) {
                if (value == null) return;
                context.read<BmiBloc>().add(UpdateHeightUnit(value));
              },
              values: Height.values,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: state.heightUnit == Height.inch
                    ? InchSelector(
                        state: state,
                        textTheme: textTheme,
                        themeData: themeData,
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              style: textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: primaryText,
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLines: 1,
                              decoration: const InputDecoration.collapsed(
                                hintText: '',
                              ),
                              onChanged: (value) {
                                final number =
                                    (num.tryParse(value) ?? 0).toDouble();
                                context
                                    .read<BmiBloc>()
                                    .add(UpdateHeight(cmToInch(number)));
                              },
                              initialValue: inchToCm(state.height).toString(),
                            ),
                            const SizedBox(
                              width: 180,
                              child: Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: Divider(color: primary, thickness: 6),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              state.formattedHeight,
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
