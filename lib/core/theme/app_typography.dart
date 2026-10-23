import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static TextStyle screenTitle = GoogleFonts.manrope(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 1.05,
    letterSpacing: -0.96,
    color: AppColors.textPrimary,
  );

  static TextStyle loginTitle = GoogleFonts.manrope(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.15,
    letterSpacing: -0.84,
    color: AppColors.textPrimary,
  );

  static TextStyle sectionTitle = GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static TextStyle cardTitle = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.textPrimary,
  );

  static TextStyle button = GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1,
    color: AppColors.white,
  );

  static TextStyle body = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.textSecondary,
  );

  static TextStyle field = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  static TextStyle label = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  static TextStyle overline = GoogleFonts.dmSans(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 1.1,
    color: AppColors.secondary,
  );

  static TextStyle error = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.error,
  );
}
