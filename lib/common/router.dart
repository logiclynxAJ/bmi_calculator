import 'package:bmi_calculator/views/details.dart';
import 'package:bmi_calculator/views/home.dart';
import 'package:bmi_calculator/views/results.dart';
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
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: Routes.results,
      builder: (context, state) => const BMIResults(),
    ),
    GoRoute(
      path: Routes.details,
      builder: (context, state) => const Details(),
    ),
  ],
);
