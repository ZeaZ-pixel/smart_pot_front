import 'package:go_router/go_router.dart';
import 'package:smart_pot_front/config/routes/app_routes.dart';
import 'package:smart_pot_front/features/presentation/pages/auth/auth_page.dart';
import 'package:smart_pot_front/features/presentation/pages/auth/sign_in_page.dart';
import 'package:smart_pot_front/features/presentation/pages/auth/sign_up_page.dart';
import 'package:smart_pot_front/features/presentation/pages/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.auth,
      builder: (context, state) => const AuthPage(),
      routes: [
        GoRoute(
          path: AppRoutes.signIn,
          builder: (context, state) => const SignInPage(),
        ),
        GoRoute(
          path: AppRoutes.signUp,
          builder: (context, state) => const SignUpPage(),
        ),
      ],
    ),
  ],
);
