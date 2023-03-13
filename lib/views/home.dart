import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/common/constants/colors.dart';
import 'package:bmi_calculator/common/types.dart';
import 'package:bmi_calculator/common/utils.dart';
import 'package:bmi_calculator/common/widgets/gender_selector.dart';
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
              ],
            ),
          );
        },
      ),
    );
  }
}

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
        height: state.heightUnit == Height.fts ? 280 : 230,
        duration: kThemeAnimationDuration,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            DropdownButton<Height>(
              underline: const SizedBox.shrink(),
              value: state.heightUnit,
              items: const [
                DropdownMenuItem(
                  value: Height.fts,
                  child: Text('Height (inch)'),
                ),
                DropdownMenuItem(
                  value: Height.cms,
                  child: Text('Height (cms)'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                context.read<BmiBloc>().add(UpdateHeightUnit(value));
              },
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: state.heightUnit == Height.fts
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
                              child: Divider(color: primary, thickness: 6),
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
