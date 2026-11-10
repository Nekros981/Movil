import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_colors.dart';

class WikiSection {
  const WikiSection({
    required this.id,
    required this.overlineEs,
    required this.overlineEn,
    required this.titleEs,
    required this.titleEn,
    required this.descriptionEs,
    required this.descriptionEn,
    required this.color,
    required this.iconBackground,
    required this.icon,
    required this.introEs,
    required this.introEn,
  });

  final String id;
  final String overlineEs;
  final String overlineEn;
  final String titleEs;
  final String titleEn;
  final String descriptionEs;
  final String descriptionEn;
  final Color color;
  final Color iconBackground;
  final IconData icon;
  final String introEs;
  final String introEn;

  String localizedOverline(AppStrings s) =>
      s.isEnglish ? overlineEn : overlineEs;

  String localizedTitle(AppStrings s) => s.isEnglish ? titleEn : titleEs;

  String localizedDescription(AppStrings s) =>
      s.isEnglish ? descriptionEn : descriptionEs;

  String localizedIntro(AppStrings s) => s.isEnglish ? introEn : introEs;
}

class WikiEntry {
  const WikiEntry({
    required this.title,
    required this.imageAsset,
    this.titleEn,
    this.introEs,
    this.introEn,
  });

  final String title;
  final String imageAsset;
  final String? titleEn;
  final String? introEs;
  final String? introEn;

  String localizedTitle(AppStrings s) {
    if (s.isEnglish && titleEn != null) {
      return titleEn!;
    }
    return title;
  }

  String localizedIntro(AppStrings s, String sectionIntro) {
    if (s.isEnglish) {
      return introEn ?? introEs ?? sectionIntro;
    }
    return introEs ?? sectionIntro;
  }
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
      introEs:
          'La corrupcion a llegado a la base de seguridad publica y como nuevo estudiante es nuestro deber romper la corrupcion.',
      introEn:
          'Corruption has reached the public security base and, as a new student, it is our duty to break the corruption.',
    ),
  ],
  'personajes': [
    WikiEntry(
      title: 'Personaje principal',
      titleEn: 'Main character',
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
    overlineEs: 'EL ORIGEN DE LA AVENTURA',
    overlineEn: 'THE ORIGIN OF THE ADVENTURE',
    titleEs: 'Historia',
    titleEn: 'Story',
    descriptionEs: 'Origen del juego, lore y capítulos del universo.',
    descriptionEn: 'Game origin, lore, and chapters of the universe.',
    color: AppColors.secondary,
    iconBackground: AppColors.secondarySoft,
    icon: Icons.menu_book_outlined,
    introEs:
        'Un apagón inesperado ha despertado antiguos secretos bajo el campus. Ahora, un estudiante deberá reunir los sellos para poder conseguir su titulo universitario.',
    introEn:
        'An unexpected blackout has awakened ancient secrets beneath the campus. Now a student must gather the seals to earn their university degree.',
  ),
  WikiSection(
    id: 'personajes',
    overlineEs: 'COMPAÑEROS DE MISIÓN',
    overlineEn: 'MISSION COMPANIONS',
    titleEs: 'Personajes',
    titleEn: 'Characters',
    descriptionEs: 'Aliados, rivales y figuras del campus.',
    descriptionEn: 'Allies, rivals, and figures across campus.',
    color: AppColors.sage,
    iconBackground: AppColors.sageSoft,
    icon: Icons.groups_outlined,
    introEs:
        'Conoce al equipo que hará de esta aventura algo inolvidable. Cada personaje tiene habilidades críticas para superar los desafíos del campus.',
    introEn:
        'Meet the team that will make this adventure unforgettable. Each character has skills critical to overcoming the challenges of campus.',
  ),
  WikiSection(
    id: 'storyboard',
    overlineEs: 'DETRÁS DE CADA ESCENA',
    overlineEn: 'BEHIND EVERY SCENE',
    titleEs: 'Storyboard',
    titleEn: 'Storyboard',
    descriptionEs: 'Escenas, paneles y secuencias del juego.',
    descriptionEn: 'Scenes, panels, and sequences from the game.',
    color: AppColors.storyboard,
    iconBackground: AppColors.accentSoft,
    icon: Icons.dashboard_outlined,
    introEs:
        'Sigue la aventura cuadro por cuadro y descubre cómo se construyen los momentos más importantes de Campus Quest.',
    introEn:
        'Follow the adventure frame by frame and discover how the most important moments of Campus Quest are built.',
  ),
];
