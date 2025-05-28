import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart_pot_front/config/themes/app_colors.dart';

class CustomFormInput extends HookWidget {
  final String? label;
  final String? placeholder;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Widget? suffixIcon;

  const CustomFormInput({
    super.key,
    this.label,
    this.placeholder,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    // Используем хук для хранения состояния видимости пароля
    final obscureText = useState(isPassword);

    Widget? resolvedSuffixIcon;
    if (suffixIcon != null) {
      resolvedSuffixIcon = suffixIcon;
    } else if (isPassword) {
      resolvedSuffixIcon = IconButton(
        icon: Icon(
          obscureText.value ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () => obscureText.value = !obscureText.value,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            suffixIcon: resolvedSuffixIcon,
          ),
          validator: validator,
          obscureText: isPassword ? obscureText.value : false,
        ),
      ],
    );
  }
}
