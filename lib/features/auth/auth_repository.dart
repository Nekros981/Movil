import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/l10n/app_language.dart';
import '../../core/l10n/app_strings.dart';

class AuthRepository {
  AuthRepository(this._client, this._language);

  static final passwordPattern = RegExp(
    r'^[A-Za-z0-9!@#$%^&*()_+\-=\[\]{};:,.?/]+$',
  );

  static final namePattern = RegExp(
    r'^(?=.{5,}$)[A-Z][A-Za-z]*(?: [A-Z][A-Za-z]*)*$',
  );

  static const passwordResetRedirect = 'com.example.proycto1://reset-password/';

  static const avatarBucket = 'avatars';

  final SupabaseClient _client;
  final AppLanguage _language;

  AppStrings get _s => _language.strings;

  static String? validateName(String name, AppStrings strings) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      return strings.enterName;
    }
    if (!namePattern.hasMatch(trimmed)) {
      return strings.nameRules;
    }
    return null;
  }

  static String? validatePassword(String password, AppStrings strings) {
    if (password.isEmpty) {
      return strings.enterPasswordPrompt;
    }
    if (password.length < 6 || !passwordPattern.hasMatch(password)) {
      return strings.passwordRules;
    }
    return null;
  }

  String? validateNameForLocale(String name) => validateName(name, _s);

  String? validatePasswordForLocale(String password) =>
      validatePassword(password, _s);

  String? currentSession() {
    return _client.auth.currentUser?.email;
  }

  String? currentName() {
    final name = _client.auth.currentUser?.userMetadata?['name'];
    if (name is String && name.trim().isNotEmpty) {
      return name.trim();
    }
    return null;
  }

  String? currentAvatarUrl() {
    final url = _client.auth.currentUser?.userMetadata?['avatar_url'];
    if (url is String && url.trim().isNotEmpty) {
      return url.trim();
    }
    return null;
  }

  Future<String?> uploadAvatar(Uint8List bytes) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      return _s.signInToUploadPhoto;
    }

    try {
      final path = '${user.id}/avatar.jpg';
      await _client.storage.from(avatarBucket).uploadBinary(
        path,
        bytes,
        fileOptions: const FileOptions(
          upsert: true,
          contentType: 'image/jpeg',
        ),
      );

      final publicUrl = _client.storage.from(avatarBucket).getPublicUrl(path);
      final cacheBusted =
          '$publicUrl?v=${DateTime.now().millisecondsSinceEpoch}';

      await _client.auth.updateUser(
        UserAttributes(data: {'avatar_url': cacheBusted}),
      );
      return null;
    } on StorageException catch (error) {
      return error.message;
    } on AuthException catch (error) {
      return _mapAuthError(error, forRegister: false);
    } catch (_) {
      return _s.uploadPhotoFailed;
    }
  }

  Future<String?> updateName(String name) async {
    final nameError = validateName(name, _s);
    if (nameError != null) {
      return nameError;
    }

    try {
      await _client.auth.updateUser(
        UserAttributes(data: {'name': name.trim()}),
      );
      return null;
    } on AuthException catch (error) {
      return _mapAuthError(error, forRegister: false);
    } catch (_) {
      return _s.updateNameFailed;
    }
  }

  Future<String?> register(String name, String email, String password) async {
    final nameError = validateName(name, _s);
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
        return _s.checkEmailConfirm;
      }
      return null;
    } on AuthException catch (error) {
      return _mapAuthError(error, forRegister: true);
    } catch (_) {
      return _s.registerFailed;
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
      return _s.loginFailed;
    }
  }

  Future<String?> sendPasswordReset(String email) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty) {
      return _s.enterEmail;
    }
    if (!trimmed.contains('@')) {
      return _s.enterValidEmail;
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
      return _s.sendLinkFailed;
    }
  }

  Future<String?> updatePassword(String password) async {
    final validation = validatePassword(password, _s);
    if (validation != null) {
      return validation;
    }

    try {
      await _client.auth.updateUser(UserAttributes(password: password));
      return null;
    } on AuthException catch (error) {
      return _mapAuthError(error, forRegister: false);
    } catch (_) {
      return _s.updatePasswordFailed;
    }
  }

  Stream<AuthState> authStateChanges() => _client.auth.onAuthStateChange;

  Future<void> logout() async {
    await _client.auth.signOut();
  }

  String? _validateEmailPassword(String email, String password) {
    final trimmed = email.trim();
    if (trimmed.isEmpty) {
      return _s.enterEmail;
    }
    if (!trimmed.contains('@')) {
      return _s.enterValidEmail;
    }
    return validatePassword(password, _s);
  }

  String _mapAuthError(AuthException error, {required bool forRegister}) {
    final message = error.message.toLowerCase();

    if (forRegister &&
        (message.contains('already registered') ||
            message.contains('user already registered') ||
            message.contains('already exists'))) {
      return _s.emailAlreadyRegistered;
    }

    if (message.contains('invalid login credentials') ||
        message.contains('invalid email or password')) {
      return _s.invalidCredentials;
    }

    if (message.contains('email not confirmed')) {
      return _s.confirmEmailBeforeLogin;
    }

    return error.message;
  }
}
