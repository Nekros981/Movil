import 'package:flutter/material.dart';

import '../../core/l10n/app_language.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import 'auth_repository.dart';
import 'widgets/auth_header.dart';

class RecoverScreen extends StatefulWidget {
  const RecoverScreen({required this.authRepository, super.key});

  final AuthRepository authRepository;

  @override
  State<RecoverScreen> createState() => _RecoverScreenState();
}

class _RecoverScreenState extends State<RecoverScreen> {
  final _emailController = TextEditingController();

  String? _emailError;
  bool _submitting = false;
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _emailError = null;
      _sent = false;
    });

    final strings = AppLanguageScope.stringsOf(context);
    final email = _emailController.text;
    if (email.trim().isEmpty) {
      setState(() => _emailError = strings.enterEmail);
      return;
    }
    if (!email.trim().contains('@')) {
      setState(() => _emailError = strings.enterValidEmail);
      return;
    }

    setState(() => _submitting = true);

    final error = await widget.authRepository.sendPasswordReset(email);

    if (!mounted) {
      return;
    }

    setState(() {
      _submitting = false;
      if (error != null) {
        _emailError = error;
      } else {
        _sent = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLanguageScope.stringsOf(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.login,
                AppSpacing.xl,
                AppSpacing.login,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(strings.recoveryOverline, style: AppTypography.overline),
                  const SizedBox(height: AppSpacing.xs),
                  Text(strings.recoverAccess, style: AppTypography.loginTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    strings.recoverSubtitle,
                    style: AppTypography.body,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    label: strings.email,
                    hint: 'tu@correo.com',
                    icon: Icons.email_outlined,
                    controller: _emailController,
                    errorText: _emailError,
                  ),
                  if (_sent) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      strings.recoverEmailSent,
                      style: AppTypography.body.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.secondary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                        ),
                        minimumSize: const Size(44, 44),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        strings.signInLink,
                        style: AppTypography.label.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: strings.sendResetLink,
                    onPressed: _submitting ? null : _submit,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
