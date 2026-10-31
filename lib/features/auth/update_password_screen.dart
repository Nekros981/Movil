import 'package:flutter/material.dart';

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

    final password = _passwordController.text;
    final confirm = _confirmController.text;

    var hasError = false;
    final passwordError = AuthRepository.validatePassword(password);
    if (passwordError != null) {
      _passwordError = passwordError;
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
        _passwordError = 'No se pudo confirmar la sesión. Intenta de nuevo.';
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
                  Text('RECUPERACIÓN', style: AppTypography.overline),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Nueva contraseña', style: AppTypography.loginTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Elige una contraseña nueva para volver a entrar al archivo.',
                    style: AppTypography.body,
                  ),
                  const SizedBox(height: AppSpacing.xl),
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
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: 'Guardar contraseña  →',
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
