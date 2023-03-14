import 'package:bmi_calculator/common/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';

import 'bloc/bmi_bloc.dart';
import 'common/constants/colors.dart';

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BmiBloc(),
      child: FlutterWebFrame(
        builder: (context) {
          return MaterialApp.router(
            routerConfig: routerConfig,
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(useMaterial3: true).copyWith(
              scaffoldBackgroundColor: background,
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
              iconButtonTheme: IconButtonThemeData(
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: const BorderSide(color: primary),
                  foregroundColor: primary,
                  padding: const EdgeInsets.all(12),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadowColor: shadowColor,
                  elevation: 5,
                ),
              ),
            ),
            builder: (context, child) {
              return GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: child,
              );
            },
          );
        },
        maximumSize: const Size(475.0, 852.0),
        enabled: kIsWeb,
      ),
    );
  }
}
