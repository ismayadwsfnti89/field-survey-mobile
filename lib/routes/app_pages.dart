import 'package:go_router/go_router.dart';
import '../models/user_model.dart';
import '../screens/auth/login.dart';
import '../screens/auth/register_page.dart';
import '../screens/dashboard/dashboard_page.dart';
import '../screens/profile/profile_page.dart';
import '../screens/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final router = GoRouter(
    initialLocation: AppRoutes.login,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) {
          final user = state.extra as UserModel?;
          return DashboardPage(user: user);
        },
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) {
          final user = state.extra as UserModel?;
          return ProfilePage(user: user);
        },
      ),
    ],
  );
}