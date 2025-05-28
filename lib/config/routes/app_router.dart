import 'package:go_router/go_router.dart';
import 'package:smart_pot_front/config/routes/app_routes.dart';
import 'package:smart_pot_front/features/presentation/pages/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
