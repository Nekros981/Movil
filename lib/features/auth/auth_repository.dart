import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  AuthRepository(this._client);

  final SupabaseClient _client;

  String? currentSession() {
    return _client.auth.currentUser?.email;
  }

  Future<String?> register(String email, String password) async {
    final validation = _validateEmailPassword(email, password);
    if (validation != null) {
      return validation;
    }

    try {
      final response = await _client.auth.signUp(
        email: email.trim(),
        password: password,
      );

      if (response.session == null) {
        return 'Revisa tu correo para confirmar la cuenta.';
      }
      return null;
    } on AuthException catch (error) {
      return _mapAuthError(error, forRegister: true);
    } catch (_) {
      return 'No se pudo crear la cuenta. Intenta de nuevo.';
    }
  }

  Future<String?> login(String email, String password) async {
    final validation = _validateEmailPassword(email, password);
    if (validation != null) {
      return validation;
    }

    try {
      await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      return null;
    } on AuthException catch (error) {
      return _mapAuthError(error, forRegister: false);
    } catch (_) {
      return 'No se pudo iniciar sesión. Intenta de nuevo.';
    }
  }

  Future<String?> sendPasswordReset(String email) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty) {
      return 'Ingresa tu correo.';
    }
    if (!trimmed.contains('@')) {
      return 'Ingresa un correo válido.';
    }

    try {
      await _client.auth.resetPasswordForEmail(trimmed);
      return null;
    } on AuthException catch (error) {
      return _mapAuthError(error, forRegister: false);
    } catch (_) {
      return 'No se pudo enviar el enlace. Intenta de nuevo.';
    }
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }

  String? _validateEmailPassword(String email, String password) {
    final trimmed = email.trim();
    if (trimmed.isEmpty) {
      return 'Ingresa tu correo.';
    }
    if (!trimmed.contains('@')) {
      return 'Ingresa un correo válido.';
    }
    if (password.isEmpty) {
      return 'Ingresa tu contraseña.';
    }
    return null;
  }

  String _mapAuthError(AuthException error, {required bool forRegister}) {
    final message = error.message.toLowerCase();

    if (forRegister &&
        (message.contains('already registered') ||
            message.contains('user already registered') ||
            message.contains('already exists'))) {
      return 'Ese correo ya está registrado.';
    }

    if (message.contains('invalid login credentials') ||
        message.contains('invalid email or password')) {
      return 'Correo o contraseña incorrectos.';
    }

    if (message.contains('email not confirmed')) {
      return 'Confirma tu correo antes de iniciar sesión.';
    }

    return error.message;
  }
}
