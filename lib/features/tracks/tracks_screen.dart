import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class TracksScreen extends StatelessWidget {
  const TracksScreen({super.key});

  static const _tracks = <String>[
    'Tema principal del campus',
    'Exploración nocturna',
    'Créditos del archivo',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.screen,
        AppSpacing.screen,
        AppSpacing.xl,
      ),
      children: [
        Text('PISTAS', style: AppTypography.overline),
        const SizedBox(height: AppSpacing.xs),
        Text('Música del juego', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Reproduce las pistas oficiales de Campus Quest.',
          style: AppTypography.body,
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final track in _tracks) ...[
          _TrackRow(title: track),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _TrackRow extends StatelessWidget {
  const _TrackRow({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(title, style: AppTypography.cardTitle),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
