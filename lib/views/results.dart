import 'package:bmi_calculator/common/constants/colors.dart';
import 'package:bmi_calculator/common/utils.dart';
import 'package:bmi_calculator/common/widgets/generic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bmi_bloc.dart';

final colorRange = generateColorList(primary, length: 3);

class BMIResults extends StatelessWidget {
  const BMIResults({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = textThemeOf(context);
    final themeData = Theme.of(context);
    final color = themeData.colorScheme.onBackground;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Your Result',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<BmiBloc, BmiState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: LayoutBuilder(builder: (context, constraints) {
              final oneSectionWidth = (constraints.maxWidth * 0.8) / 4;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GenericCard(
                    width: constraints.maxWidth,
                    height: 320,
                    padding: const EdgeInsets.symmetric(vertical: 36),
                    children: [
                      Text(
                        'Your BMI is:',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              state.bmi.toStringAsFixed(2),
                              style: textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.8,
                              height: 12,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xff4e7df9),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  Container(
                                    width: oneSectionWidth * 3,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff81a3ff),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  Container(
                                    width: oneSectionWidth,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffbaccfd),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        state.bmiStatus,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}
