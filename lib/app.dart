import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/auth_gate.dart';
import 'features/auth/auth_repository.dart';

class CampusQuestApp extends StatelessWidget {
  const CampusQuestApp({required this.authRepository, super.key});

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Quest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: AuthGate(authRepository: authRepository),
    );
  }
}
