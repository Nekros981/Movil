import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_banner.dart';
import '../../core/widgets/section_card.dart';
import '../archive/wiki_sections.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({required this.onGoToArchive, super.key});

  final VoidCallback onGoToArchive;

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
        const AppBanner(
          label: 'ARCHIVO OFICIAL',
          title: 'Campus Quest',
          description:
              'Explora el universo del videojuego: historia, personajes y storyboard.',
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text('EXPLORACIÓN', style: AppTypography.overline),
        const SizedBox(height: AppSpacing.xs),
        Text('¿Qué quieres explorar?', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.lg),
        for (var i = 0; i < wikiSections.length; i++) ...[
          SectionCard(
            indexLabel: '0${i + 1}',
            title: wikiSections[i].title,
            description: wikiSections[i].description,
            icon: wikiSections[i].icon,
            iconColor: wikiSections[i].color,
            iconBackground: wikiSections[i].iconBackground,
            onTap: onGoToArchive,
          ),
          if (i < wikiSections.length - 1) const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}
