import 'package:flutter/material.dart';
import 'package:smart_pot_front/config/themes/app_colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        color: AppColors.secondary,
      ),
    );
  }
}
