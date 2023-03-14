import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

import 'generic_card.dart';

class BmiChart extends StatelessWidget {
  const BmiChart({
    super.key,
    required this.textTheme,
    required this.color,
    required this.colorRange,
    required this.constraints,
    required this.state,
  });

  final TextTheme textTheme;
  final Color color;
  final List<Color> colorRange;
  final BoxConstraints constraints;
  final BmiState state;

  @override
  Widget build(BuildContext context) {
    return GenericCard(
      width: constraints.maxWidth,
      height: 280,
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: [
        Text(
          'Your BMI is:',
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Expanded(
          child: AnimatedRadialGauge(
            radius: 100,
            value: state.bmi,
            axis: GaugeAxis(
              min: 0,
              max: state.bmi > 29 ? state.bmi : 29,
              segments: [
                GaugeSegment(
                  from: 0,
                  to: 18.5,
                  color: colorRange[0],
                ),
                GaugeSegment(
                  from: 18.6,
                  to: 24.9,
                  color: colorRange[1],
                ),
                GaugeSegment(
                  from: 25,
                  to: 29,
                  color: colorRange[2],
                ),
                if (state.bmi > 29)
                  GaugeSegment(
                    from: 29.1,
                    to: state.bmi,
                    color: colorRange[3],
                  ),
              ],
              pointer: RoundedTrianglePointer(
                borderRadius: 5,
                backgroundColor: color,
                size: 36,
              ),
            ),
            duration: Duration.zero,
            builder: (context, child, value) {
              return RadialGaugeLabel(
                style: textTheme.headlineLarge?.copyWith(
                  color: const Color(0xFF002E5F),
                  fontWeight: FontWeight.bold,
                ),
                value: value,
              );
            },
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
    );
  }
}
