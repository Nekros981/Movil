import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';
import '../home/home_screen.dart';
import 'auth_repository.dart';
import 'widgets/auth_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({required this.authRepository, super.key});

  final AuthRepository authRepository;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String? _usernameError;
  String? _passwordError;
  String? _confirmError;
  bool _submitting = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _usernameError = null;
      _passwordError = null;
      _confirmError = null;
    });

    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    var hasError = false;
    if (username.trim().isEmpty) {
      _usernameError = 'Ingresa un usuario.';
      hasError = true;
    }
    if (password.isEmpty) {
      _passwordError = 'Ingresa una contraseña.';
      hasError = true;
    }
    if (confirm.isEmpty) {
      _confirmError = 'Confirma tu contraseña.';
      hasError = true;
    } else if (password != confirm) {
      _confirmError = 'Las contraseñas no coinciden.';
      hasError = true;
    }
    if (hasError) {
      setState(() {});
      return;
    }

    setState(() => _submitting = true);

    final registerError = await widget.authRepository.register(
      username,
      password,
    );

    if (!mounted) {
      return;
    }

    if (registerError != null) {
      setState(() {
        _submitting = false;
        _usernameError = registerError;
      });
      return;
    }

    final loginError = await widget.authRepository.login(
      username,
      password,
      remember: false,
    );

    if (!mounted) {
      return;
    }

    if (loginError != null) {
      setState(() {
        _submitting = false;
        _passwordError = loginError;
      });
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => HomeScreen(
          username: username.trim(),
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
                  Text('NUEVA PARTIDA', style: AppTypography.overline),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Crea tu cuenta', style: AppTypography.loginTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Elige un usuario y una contraseña para entrar al archivo.',
                    style: AppTypography.body,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    label: 'Usuario',
                    hint: 'tu_usuario',
                    icon: Icons.person_outline,
                    controller: _usernameController,
                    errorText: _usernameError,
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
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    label: 'Confirmar contraseña',
                    hint: 'Repite tu contraseña',
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
                        'Iniciar sesión',
                        style: AppTypography.label.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: 'Crear cuenta  →',
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
