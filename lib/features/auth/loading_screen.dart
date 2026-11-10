import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/l10n/app_language.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../shell/app_shell.dart';
import 'auth_repository.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    required this.email,
    required this.authRepository,
    super.key,
  });

  final String email;
  final AuthRepository authRepository;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  static const _delay = Duration(milliseconds: 1500);

  @override
  void initState() {
    super.initState();
    _goToShell();
  }

  Future<void> _goToShell() async {
    await Future<void>.delayed(_delay);
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => AppShell(
          email: widget.email,
          authRepository: widget.authRepository,
        ),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLanguageScope.stringsOf(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.login),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/img/logo.jpeg',
                    width: 120,
                    height: 134,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  'Campus Quest',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                    letterSpacing: -0.03,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  strings.preparingArchive,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xA6FFFFFF),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                const CircularProgressIndicator(
                  color: AppColors.accent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
