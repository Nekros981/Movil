import 'package:flutter/material.dart';

import 'core/l10n/app_language.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/auth_gate.dart';
import 'features/auth/auth_repository.dart';

class CampusQuestApp extends StatelessWidget {
  const CampusQuestApp({
    required this.authRepository,
    required this.appLanguage,
    super.key,
  });

  final AuthRepository authRepository;
  final AppLanguage appLanguage;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appLanguage,
      builder: (context, _) {
        return AppLanguageScope(
          language: appLanguage,
          strings: appLanguage.strings,
          child: MaterialApp(
            title: 'Campus Quest',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: AuthGate(authRepository: authRepository),
          ),
        );
      },
    );
  }
}
