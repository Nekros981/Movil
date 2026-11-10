import 'package:flutter/material.dart';

import '../../core/l10n/app_language.dart';
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
    final strings = AppLanguageScope.stringsOf(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.screen,
        AppSpacing.screen,
        AppSpacing.xl,
      ),
      children: [
        AppBanner(
          label: strings.officialArchiveLabel,
          title: 'Campus Quest',
          description: strings.homeBannerDescription,
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text(strings.exploration, style: AppTypography.overline),
        const SizedBox(height: AppSpacing.xs),
        Text(strings.whatToExplore, style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.lg),
        for (var i = 0; i < wikiSections.length; i++) ...[
          SectionCard(
            indexLabel: '0${i + 1}',
            title: wikiSections[i].localizedTitle(strings),
            description: wikiSections[i].localizedDescription(strings),
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
