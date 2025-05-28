import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pot_front/config/assets/app_images.dart';
import 'package:smart_pot_front/config/routes/app_routes.dart';
import 'package:smart_pot_front/config/themes/app_colors.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.authBg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              'Ухаживай за растениями просто!',
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Здесь ты можешь заботиться о растении вне дома',
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                context.go(AppRoutes.authSignIn);
              },
              child: Text('Логин'),
            ),
            SizedBox(
              height: 16,
            ),
            OutlinedButton(
              onPressed: () {
                context.go(AppRoutes.authSignUp);
              },
              child: Text('Регситрация'),
            ),
          ],
        ),
      ),
    );
  }
}
