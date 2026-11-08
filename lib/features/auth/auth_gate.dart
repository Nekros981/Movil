import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../shell/app_shell.dart';
import 'auth_repository.dart';
import 'login_screen.dart';
import 'update_password_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({required this.authRepository, super.key});

  final AuthRepository authRepository;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  String? _session;
  bool _loading = true;
  bool _needsPasswordUpdate = false;
  StreamSubscription<AuthState>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _session = widget.authRepository.currentSession();
    _loading = false;
    _authSubscription = widget.authRepository.authStateChanges().listen(
      _onAuthStateChange,
    );
  }

  void _onAuthStateChange(AuthState data) {
    if (!mounted) {
      return;
    }

    if (data.event == AuthChangeEvent.passwordRecovery) {
      setState(() {
        _needsPasswordUpdate = true;
        _session = data.session?.user.email ?? widget.authRepository.currentSession();
        _loading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
      return;
    }

    if (data.event == AuthChangeEvent.signedOut) {
      setState(() {
        _session = null;
        _needsPasswordUpdate = false;
        _loading = false;
      });
      return;
    }

    if (data.event == AuthChangeEvent.signedIn ||
        data.event == AuthChangeEvent.tokenRefreshed) {
      setState(() {
        _session = data.session?.user.email ?? widget.authRepository.currentSession();
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_needsPasswordUpdate) {
      return UpdatePasswordScreen(authRepository: widget.authRepository);
    }

    if (_session != null) {
      return AppShell(
        email: _session!,
        authRepository: widget.authRepository,
      );
    }

    return LoginScreen(authRepository: widget.authRepository);
  }
}
