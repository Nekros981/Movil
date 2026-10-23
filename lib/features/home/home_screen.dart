import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/primary_button.dart';
import '../auth/auth_repository.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.username,
    required this.authRepository,
    super.key,
  });

  final String username;
  final AuthRepository authRepository;

  Future<void> _logout(BuildContext context) async {
    await authRepository.logout();
    if (!context.mounted) {
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => LoginScreen(authRepository: authRepository),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Campus Quest', style: AppTypography.sectionTitle),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Sesión iniciada como $username.',
                style: AppTypography.body,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Aquí irá el inicio de la wiki.',
                style: AppTypography.body,
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Cerrar sesión',
                onPressed: () => _logout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
