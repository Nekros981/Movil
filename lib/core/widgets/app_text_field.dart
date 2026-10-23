import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    required this.hint,
    this.icon,
    this.obscureText = false,
    this.controller,
    this.errorText,
    this.suffix,
    super.key,
  });

  final String label;
  final String hint;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? errorText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.label),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: AppTypography.field,
          cursorColor: AppColors.sage,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.field.copyWith(color: AppColors.textMuted),
            prefixIcon: icon == null
                ? null
                : Icon(icon, color: AppColors.textSecondary, size: 20),
            suffixIcon: suffix,
            filled: true,
            fillColor: AppColors.white,
            errorText: errorText,
            errorStyle: AppTypography.error,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            enabledBorder: _border(AppColors.border),
            focusedBorder: _border(AppColors.sage, width: 1.5),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error, width: 1.5),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadii.field),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
