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

class WikiEntry {
  const WikiEntry({
    required this.title,
    required this.imageAsset,
  });

  final String title;
  final String imageAsset;
}

const wikiEntriesBySection = <String, List<WikiEntry>>{
  'historia': [
    WikiEntry(
      title: 'Rectoría',
      imageAsset: 'assets/img/historia/Rectoria.jpeg',
    ),
    WikiEntry(
      title: 'SP',
      imageAsset: 'assets/img/historia/SP.jpeg',
    ),
  ],
  'personajes': [
    WikiEntry(
      title: 'Personaje principal',
      imageAsset: 'assets/img/personajes/Principal.png',
    ),
  ],
  'storyboard': [
    WikiEntry(
      title: 'Rectoría',
      imageAsset: 'assets/img/storyboard/Rectoria.jpeg',
    ),
    WikiEntry(
      title: 'Acertijo 1',
      imageAsset: 'assets/img/storyboard/Acertijo1.jpeg',
    ),
    WikiEntry(
      title: 'Acertijo 2',
      imageAsset: 'assets/img/storyboard/Acertijo2.jpeg',
    ),
    WikiEntry(
      title: 'Acertijo 3',
      imageAsset: 'assets/img/storyboard/Acertijo3.jpeg',
    ),
    WikiEntry(
      title: 'Cierre Rectoría',
      imageAsset: 'assets/img/storyboard/CierreRectoria.jpeg',
    ),
  ],
};

const wikiSections = <WikiSection>[
  WikiSection(
    id: 'historia',
    overline: 'EL ORIGEN DE LA AVENTURA',
    title: 'Historia',
    description: 'Origen del juego, lore y capítulos del universo.',
    color: AppColors.secondary,
    iconBackground: AppColors.secondarySoft,
    icon: Icons.menu_book_outlined,
    intro:
        'Un apagón inesperado ha despertado antiguos secretos bajo el campus. Ahora, una estudiante deberá reunir las piezas antes del gran festival universitario.',
  ),
  WikiSection(
    id: 'personajes',
    overline: 'COMPAÑEROS DE MISIÓN',
    title: 'Personajes',
    description: 'Aliados, rivales y figuras del campus.',
    color: AppColors.sage,
    iconBackground: AppColors.sageSoft,
    icon: Icons.groups_outlined,
    intro:
        'Conoce al equipo que hará de esta aventura algo inolvidable. Cada personaje tiene habilidades críticas para superar los desafíos del campus.',
  ),
  WikiSection(
    id: 'storyboard',
    overline: 'DETRÁS DE CADA ESCENA',
    title: 'Storyboard',
    description: 'Escenas, paneles y secuencias del juego.',
    color: AppColors.storyboard,
    iconBackground: AppColors.accentSoft,
    icon: Icons.dashboard_outlined,
    intro:
        'Sigue la aventura cuadro por cuadro y descubre cómo se construyen los momentos más importantes de Campus Quest.',
  ),
];
