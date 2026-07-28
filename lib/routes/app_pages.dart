import 'package:go_router/go_router.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/auth/login.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../models/user_model.dart';
import 'app_routes.dart';

class AppPages {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ), // GoRoute

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ), // GoRoute

      GoRoute(
        path: AppRoutes.dashboard,
        // Data user dikirim lewat parameter "extra" pas navigasi (context.go(..., extra: user))
        // Di sini kita ambil lagi dan "cast" jadi tipe UserModel
        builder: (context, state) {
          final user = state.extra as UserModel;
          return DashboardScreen(user: user);
        },
      ), // GoRoute
    ],
  ); // GoRouter
}