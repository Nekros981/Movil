import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import 'auth_repository.dart';
import 'login_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({required this.authRepository, super.key});

  final AuthRepository authRepository;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  String? _session;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _session = widget.authRepository.currentSession();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_session != null) {
      return HomeScreen(
        username: _session!,
        authRepository: widget.authRepository,
      );
    }

    return LoginScreen(authRepository: widget.authRepository);
  }
}
