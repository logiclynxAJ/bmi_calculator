import 'package:bmi_calculator/views/details.dart';
import 'package:bmi_calculator/views/home.dart';
import 'package:bmi_calculator/views/results.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String home = '/home';
  static const String results = '/results';
  static const String details = '/info';
}

final routerConfig = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: kIsWeb ? null : (context, state) => const HomeView(),
      pageBuilder: !kIsWeb
          ? null
          : (context, state) {
              return const NoTransitionPage(child: HomeView());
            },
    ),
    GoRoute(
      path: Routes.results,
      builder: kIsWeb ? null : (context, state) => const BMIResults(),
      pageBuilder: !kIsWeb
          ? null
          : (context, state) {
              return const NoTransitionPage(child: BMIResults());
            },
    ),
    GoRoute(
      path: Routes.details,
      builder: kIsWeb ? null : (context, state) => const Details(),
      pageBuilder: !kIsWeb
          ? null
          : (context, state) {
              return const NoTransitionPage(child: Details());
            },
    ),
  ],
);
