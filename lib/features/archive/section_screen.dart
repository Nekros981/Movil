import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'wiki_sections.dart';

class SectionScreen extends StatelessWidget {
  const SectionScreen({required this.section, super.key});

  final WikiSection section;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text(section.title, style: AppTypography.cardTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          0,
          AppSpacing.screen,
          AppSpacing.xl,
        ),
        children: [
          Text(section.overline, style: AppTypography.overline),
          const SizedBox(height: AppSpacing.xs),
          Text(section.title, style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.sm),
          Text(section.intro, style: AppTypography.body),
          const SizedBox(height: AppSpacing.xl),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.placeholder,
              borderRadius: BorderRadius.circular(AppRadii.card),
              border: Border.all(
                color: AppColors.textSecondary,
                style: BorderStyle.solid,
              ),
            ),
            child: Text(
              'Contenido en preparación',
              textAlign: TextAlign.center,
              style: AppTypography.label.copyWith(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
