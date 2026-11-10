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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({required this.authRepository, super.key});

  final AuthRepository authRepository;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmError;
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmError = null;
    });

    final strings = AppLanguageScope.stringsOf(context);
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    var hasError = false;
    final nameError = AuthRepository.validateName(name, strings);
    if (nameError != null) {
      _nameError = nameError;
      hasError = true;
    }
    if (email.trim().isEmpty) {
      _emailError = strings.enterEmail;
      hasError = true;
    } else if (!email.trim().contains('@')) {
      _emailError = strings.enterValidEmail;
      hasError = true;
    }
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

    final registerError = await widget.authRepository.register(
      name,
      email,
      password,
    );

    if (!mounted) {
      return;
    }

    if (registerError != null) {
      setState(() {
        _submitting = false;
        _emailError = registerError;
      });
      return;
    }

    final sessionEmail =
        widget.authRepository.currentSession() ?? email.trim();

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
                  Text(strings.newGame, style: AppTypography.overline),
                  const SizedBox(height: AppSpacing.xs),
                  Text(strings.createAccountTitle, style: AppTypography.loginTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    strings.registerSubtitle,
                    style: AppTypography.body,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    label: strings.name,
                    hint: 'Miguel Angel Sandoval',
                    icon: Icons.person_outline,
                    controller: _nameController,
                    errorText: _nameError,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    label: strings.email,
                    hint: 'tu@correo.com',
                    icon: Icons.email_outlined,
                    controller: _emailController,
                    errorText: _emailError,
                  ),
                  const SizedBox(height: AppSpacing.lg),
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
                    label: strings.createAccountButton,
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
