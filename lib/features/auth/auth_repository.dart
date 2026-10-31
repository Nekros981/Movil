import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  AuthRepository(this._client);

  static final passwordPattern = RegExp(
    r'^[A-Za-z0-9!@#$%^&*()_+\-=\[\]{};:,.?/]+$',
  );

  static const passwordRulesMessage =
      'Usa al menos 6 caracteres: letras, números o signos.';

  static final namePattern = RegExp(
    r'^(?=.{5,}$)[A-Z][A-Za-z]*(?: [A-Z][A-Za-z]*)*$',
  );

  static const nameRulesMessage =
      'Empieza con mayúscula, mínimo 5 caracteres y solo letras. '
      'Cada palabra con mayúscula inicial, un espacio entre palabras.';

  static const passwordResetRedirect = 'com.example.proycto1://reset-password/';

  final SupabaseClient _client;

  static String? validateName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      return 'Ingresa tu nombre.';
    }
    if (!namePattern.hasMatch(trimmed)) {
      return nameRulesMessage;
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Ingresa tu contraseña.';
    }
    if (password.length < 6 || !passwordPattern.hasMatch(password)) {
      return passwordRulesMessage;
    }
    return null;
  }

  String? currentSession() {
    return _client.auth.currentUser?.email;
  }

  Future<String?> register(String name, String email, String password) async {
    final nameError = validateName(name);
    if (nameError != null) {
      return nameError;
    }

    final validation = _validateEmailPassword(email, password);
    if (validation != null) {
      return validation;
    }

    try {
      final response = await _client.auth.signUp(
        email: email.trim(),
        password: password,
        data: {'name': name.trim()},
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
      await _client.auth.resetPasswordForEmail(
        trimmed,
        redirectTo: passwordResetRedirect,
      );
      return null;
    } on AuthException catch (error) {
      return _mapAuthError(error, forRegister: false);
    } catch (_) {
      return 'No se pudo enviar el enlace. Intenta de nuevo.';
    }
  }

  Future<String?> updatePassword(String password) async {
    final validation = validatePassword(password);
    if (validation != null) {
      return validation;
    }

    try {
      await _client.auth.updateUser(UserAttributes(password: password));
      return null;
    } on AuthException catch (error) {
      return _mapAuthError(error, forRegister: false);
    } catch (_) {
      return 'No se pudo actualizar la contraseña. Intenta de nuevo.';
    }
  }

  Stream<AuthState> authStateChanges() => _client.auth.onAuthStateChange;

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
    return validatePassword(password);
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
