import 'package:flutter/material.dart';

import '../../core/l10n/app_language.dart';
import '../../core/theme/app_colors.dart';
import '../archive/archive_screen.dart';
import '../auth/auth_repository.dart';
import '../home/inicio_screen.dart';
import '../profile/profile_screen.dart';
import '../tracks/tracks_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    required this.email,
    required this.authRepository,
    this.initialIndex = 0,
    super.key,
  });

  final String email;
  final AuthRepository authRepository;
  final int initialIndex;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _index = widget.initialIndex;

  void _goToTab(int index) {
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLanguageScope.stringsOf(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: [
            InicioScreen(onGoToArchive: () => _goToTab(1)),
            ArchiveScreen(),
            TracksScreen(),
            ProfileScreen(
              email: widget.email,
              authRepository: widget.authRepository,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _goToTab,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: strings.tabHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.folder_outlined),
            selectedIcon: const Icon(Icons.folder),
            label: strings.tabArchive,
          ),
          NavigationDestination(
            icon: const Icon(Icons.music_note_outlined),
            selectedIcon: const Icon(Icons.music_note),
            label: strings.tabTracks,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: strings.tabProfile,
          ),
        ],
      ),
    );
  }
}
