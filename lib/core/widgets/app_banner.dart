import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    required this.label,
    required this.title,
    required this.description,
    super.key,
  });

  final String label;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppRadii.bannerBorder,
        boxShadow: const [AppShadows.medium],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.overline.copyWith(color: AppColors.accent),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                height: 1.13,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              description,
              style: AppTypography.body.copyWith(
                color: const Color(0xA3FFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
