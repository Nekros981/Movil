import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/section_card.dart';
import 'section_screen.dart';
import 'wiki_sections.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

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
        Text('ARCHIVO', style: AppTypography.overline),
        const SizedBox(height: AppSpacing.xs),
        Text('Wiki del juego', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Elige una sección para leer su contenido.',
          style: AppTypography.body,
        ),
        const SizedBox(height: AppSpacing.lg),
        for (var i = 0; i < wikiSections.length; i++) ...[
          SectionCard(
            indexLabel: '0${i + 1}',
            title: wikiSections[i].title,
            description: wikiSections[i].description,
            icon: wikiSections[i].icon,
            iconColor: wikiSections[i].color,
            iconBackground: wikiSections[i].iconBackground,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => SectionScreen(section: wikiSections[i]),
                ),
              );
            },
          ),
          if (i < wikiSections.length - 1) const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}
