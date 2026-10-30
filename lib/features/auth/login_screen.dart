import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../shell/app_shell.dart';
import 'auth_repository.dart';
import 'recover_screen.dart';
import 'register_screen.dart';
import 'widgets/auth_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.authRepository, super.key});

  final AuthRepository authRepository;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _openRegister() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RegisterScreen(authRepository: widget.authRepository),
      ),
    );
  }

  void _openRecover() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RecoverScreen(authRepository: widget.authRepository),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    var hasError = false;
    if (email.trim().isEmpty) {
      _emailError = 'Ingresa tu correo.';
      hasError = true;
    } else if (!email.trim().contains('@')) {
      _emailError = 'Ingresa un correo válido.';
      hasError = true;
    }
    final passwordError = AuthRepository.validatePassword(password);
    if (passwordError != null) {
      _passwordError = passwordError;
      hasError = true;
    }
    if (hasError) {
      setState(() {});
      return;
    }

    setState(() => _submitting = true);

    final error = await widget.authRepository.login(email, password);

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
                  Text('BIENVENIDO DE VUELTA', style: AppTypography.overline),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Continúa tu aventura', style: AppTypography.loginTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Ingresa con tu cuenta para explorar el universo de Campus Quest.',
                    style: AppTypography.body,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    label: 'Correo',
                    hint: 'tu@correo.com',
                    icon: Icons.email_outlined,
                    controller: _emailController,
                    errorText: _emailError,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    label: 'Contraseña',
                    hint: 'Ingresa tu contraseña',
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
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      TextButton(
                        onPressed: _openRecover,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.secondary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                          ),
                          minimumSize: const Size(44, 44),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          '¿Olvidaste tu contraseña?',
                          style: AppTypography.label.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: _openRegister,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.secondary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                          ),
                          minimumSize: const Size(44, 44),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Crear cuenta',
                          style: AppTypography.label.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: 'Iniciar sesión  →',
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
