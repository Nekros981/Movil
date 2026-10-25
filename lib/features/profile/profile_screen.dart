import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/primary_button.dart';
import '../auth/auth_repository.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    required this.email,
    required this.authRepository,
    super.key,
  });

  final String email;
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

  String _initial() {
    final trimmed = email.trim();
    if (trimmed.isEmpty) {
      return '?';
    }
    return trimmed[0].toUpperCase();
  }

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
        Text('PERFIL', style: AppTypography.overline),
        const SizedBox(height: AppSpacing.xs),
        Text('Tu cuenta', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.xl),
        Center(
          child: CircleAvatar(
            radius: 44,
            backgroundColor: AppColors.sage,
            child: Text(
              _initial(),
              style: GoogleFonts.manrope(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Center(
          child: Text(
            email,
            textAlign: TextAlign.center,
            style: AppTypography.sectionTitle,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Center(
          child: Text(
            'Próximamente podrás cambiar tu foto y tu nombre desde aquí.',
            textAlign: TextAlign.center,
            style: AppTypography.body,
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        PrimaryButton(
          label: 'Cerrar sesión',
          onPressed: () => _logout(context),
        ),
      ],
    );
  }
}
