import 'package:flutter/material.dart';

import '../../core/l10n/app_language.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../shell/app_shell.dart';
import 'auth_repository.dart';
import 'widgets/auth_header.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({required this.authRepository, super.key});

  final AuthRepository authRepository;

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String? _passwordError;
  String? _confirmError;
  bool _submitting = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _passwordError = null;
      _confirmError = null;
    });

    final strings = AppLanguageScope.stringsOf(context);
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    var hasError = false;
    final passwordError = AuthRepository.validatePassword(password, strings);
    if (passwordError != null) {
      _passwordError = passwordError;
      hasError = true;
    }
    if (confirm.isEmpty) {
      _confirmError = strings.confirmPasswordPrompt;
      hasError = true;
    } else if (password != confirm) {
      _confirmError = strings.passwordsDoNotMatch;
      hasError = true;
    }
    if (hasError) {
      setState(() {});
      return;
    }

    setState(() => _submitting = true);

    final error = await widget.authRepository.updatePassword(password);

    if (!mounted) {
      return;
    }

    if (error != null) {
      setState(() {
        _submitting = false;
        _passwordError = error;
      });
      return;
    }

    final sessionEmail = widget.authRepository.currentSession();
    if (sessionEmail == null) {
      setState(() {
        _submitting = false;
        _passwordError = strings.sessionConfirmFailed;
      });
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => AppShell(
          email: sessionEmail,
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
                  Text(strings.newPasswordTitle, style: AppTypography.loginTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    strings.updatePasswordSubtitle,
                    style: AppTypography.body,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    label: strings.password,
                    hint: strings.enterPassword,
                    icon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    controller: _passwordController,
                    errorText: _passwordError,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    label: strings.confirmPassword,
                    hint: strings.repeatPassword,
                    icon: Icons.lock_outline,
                    obscureText: _obscureConfirm,
                    controller: _confirmController,
                    errorText: _confirmError,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() => _obscureConfirm = !_obscureConfirm);
                      },
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: strings.savePassword,
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
