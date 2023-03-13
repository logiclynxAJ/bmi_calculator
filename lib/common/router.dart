import 'package:bmi_calculator/views/home.dart';
import 'package:go_router/go_router.dart';

class Router {
  static const String home = '/home';
}

final routerConfig = GoRouter(
  initialLocation: Router.home,
  routes: [
    GoRoute(
      path: Router.home,
      builder: (context, state) => const HomeView(),
    ),
  ],
);
