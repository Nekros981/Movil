import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.white,
      error: AppColors.error,
      onError: AppColors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        headlineLarge: AppTypography.screenTitle,
        headlineMedium: AppTypography.loginTitle,
        titleLarge: AppTypography.sectionTitle,
        titleMedium: AppTypography.cardTitle,
        bodyMedium: AppTypography.body,
        labelLarge: AppTypography.button,
        labelMedium: AppTypography.label,
      ),
    );
  }
}
