import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class WikiSection {
  const WikiSection({
    required this.id,
    required this.overline,
    required this.title,
    required this.description,
    required this.color,
    required this.iconBackground,
    required this.icon,
    required this.intro,
  });

  final String id;
  final String overline;
  final String title;
  final String description;
  final Color color;
  final Color iconBackground;
  final IconData icon;
  final String intro;
}

const wikiSections = <WikiSection>[
  WikiSection(
    id: 'historia',
    overline: 'HISTORIA',
    title: 'Historia',
    description: 'Origen del juego, lore y capítulos del universo.',
    color: AppColors.secondary,
    iconBackground: AppColors.secondarySoft,
    icon: Icons.menu_book_outlined,
    intro:
        'Aquí irán los capítulos de la historia de Campus Quest. El contenido se cargará desde el archivo local de la wiki.',
  ),
  WikiSection(
    id: 'personajes',
    overline: 'PERSONAJES',
    title: 'Personajes',
    description: 'Aliados, rivales y figuras del campus.',
    color: AppColors.sage,
    iconBackground: AppColors.sageSoft,
    icon: Icons.groups_outlined,
    intro:
        'Aquí irán las fichas de personajes. El contenido se cargará desde el archivo local de la wiki.',
  ),
  WikiSection(
    id: 'storyboard',
    overline: 'STORYBOARD',
    title: 'Storyboard',
    description: 'Escenas, paneles y secuencias del juego.',
    color: AppColors.storyboard,
    iconBackground: AppColors.accentSoft,
    icon: Icons.dashboard_outlined,
    intro:
        'Aquí irán los paneles del storyboard. El contenido se cargará desde el archivo local de la wiki.',
  ),
];
