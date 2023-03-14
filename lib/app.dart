import 'package:bmi_calculator/common/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bmi_bloc.dart';
import 'common/constants/colors.dart';

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BmiBloc(),
      child: MaterialApp.router(
        routerConfig: routerConfig,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true).copyWith(
          colorScheme: const ColorScheme.light(
            background: background,
            primary: primary,
            secondary: secondary,
            primaryContainer: background,
            onBackground: primaryText,
            onPrimary: primaryText,
            onSecondary: primaryText,
            onSurface: primaryText,
          ),
          appBarTheme: const AppBarTheme(
            surfaceTintColor: background,
            color: background,
          ),
          shadowColor: shadowColor,
        ),
        builder: (context, child) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: child,
          );
        },
      ),
    );
  }
}
