import 'package:go_router/go_router.dart';

import '../screens/splash/splash_screen.dart';
import '../screens/auth/login.dart';
import '../screens/auth/register_page.dart';
import '../screens/dashboard/dashboard_page.dart';
import '../models/user_model.dart';
import 'app_routes.dart';

class AppPages {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) =>  SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) =>  LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) =>  RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) {
          final user = state.extra as UserModel;
          return DashboardPage(user: user);
        },
      ),
    ],
  );
}