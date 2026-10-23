import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    return ColoredBox(
      color: AppColors.primary,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.login,
          top + AppSpacing.login,
          AppSpacing.login,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(child: _headerLine()),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                  child: Text(
                    'ARCHIVO OFICIAL DEL VIDEOJUEGO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xA6FFFFFF),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      height: 1.2,
                    ),
                  ),
                ),
                Expanded(child: _headerLine()),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Center(child: _logoCard()),
          ],
        ),
      ),
    );
  }

  Widget _logoCard() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadii.logoBorder,
        border: Border.all(color: const Color(0x38FFFFFF)),
        boxShadow: const [AppShadows.large],
      ),
      child: ClipRRect(
        borderRadius: AppRadii.logoBorder,
        child: Image.asset(
          'assets/img/logo.jpeg',
          width: 168,
          height: 188,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _headerLine() {
    return Container(
      height: 1,
      color: const Color(0x59FFFFFF),
    );
  }
}
