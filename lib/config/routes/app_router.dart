import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pot_front/config/routes/app_routes.dart';
import 'package:smart_pot_front/features/presentation/pages/auth/auth_page.dart';
import 'package:smart_pot_front/features/presentation/pages/auth/sign_in_page.dart';
import 'package:smart_pot_front/features/presentation/pages/auth/sign_up_page.dart';
import 'package:smart_pot_front/features/presentation/pages/auth/verify_page.dart';
import 'package:smart_pot_front/features/presentation/pages/home_page.dart';
import 'package:smart_pot_front/features/presentation/pages/splash_screen.dart';

CustomTransitionPage<T> fadeTransitionPage<T>({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

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
        GoRoute(
          path: AppRoutes.emailVerify,
          builder: (context, state) {
            final email = state.extra as String;
            return EmailVerificationPage(email: email);
          },
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => fadeTransitionPage(
        child: const HomePage(),
        state: state,
      ),
    ),
  ],
);
