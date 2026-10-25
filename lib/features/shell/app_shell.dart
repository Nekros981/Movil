import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: [
            InicioScreen(onGoToArchive: () => _goToTab(1)),
            const ArchiveScreen(),
            const TracksScreen(),
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
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'Archivo',
          ),
          NavigationDestination(
            icon: Icon(Icons.music_note_outlined),
            selectedIcon: Icon(Icons.music_note),
            label: 'Pistas',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
