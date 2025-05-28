import 'package:flutter/material.dart';
import 'package:smart_pot_front/config/assets/app_images.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.authBg,
            ),
          ),
        ),
      ),
    );
  }
}
