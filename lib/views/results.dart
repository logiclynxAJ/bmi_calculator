import 'dart:developer';

import 'package:bmi_calculator/common/constants/colors.dart';
import 'package:bmi_calculator/common/utils.dart';
import 'package:bmi_calculator/common/widgets/bmi_chart.dart';
import 'package:bmi_calculator/common/widgets/generic_card.dart';
import 'package:davinci/core/davinci_capture.dart';
import 'package:davinci/core/davinci_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bmi_bloc.dart';

class BMIResults extends StatelessWidget {
  const BMIResults({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = textThemeOf(context);
    final themeData = Theme.of(context);
    final color = themeData.colorScheme.onBackground;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Your Result',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<BmiBloc, BmiState>(
          buildWhen: (previous, current) {
            return previous.bmi != current.bmi;
          },
          builder: (context, state) {
            final colorRange = state.bmi > 29
                ? const [
                    Color(0xffcad8fd),
                    Color(0xffa7befc),
                    Color(0xff608afa),
                    Color(0xff4e7df9),
                  ]
                : const [
                    Color(0xffbaccfd),
                    Color(0xff81a3ff),
                    Color(0xff4e7df9),
                  ];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: LayoutBuilder(builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Davinci(
                      builder: (key) {
                        context.read<BmiBloc>().add(UpdateGlobalKey(key));
                        return BmiChart(
                          textTheme: textTheme,
                          color: color,
                          colorRange: colorRange,
                          state: state,
                          constraints: constraints,
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 36, left: 4, right: 4),
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(state.bmiMessage),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            try {
                              final bloc = context.read<BmiBloc>();
                              if (bloc.state.key != null) {
                                await DavinciCapture.click(bloc.state.key!);
                              }
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                          icon: const Icon(Icons.share),
                        ),
                        const SizedBox(width: 24),
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
