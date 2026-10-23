import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  AuthRepository(this._prefs);

  static const _usersKey = 'auth_users';
  static const _sessionKey = 'auth_session';

  final SharedPreferences _prefs;

  static Future<AuthRepository> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AuthRepository(prefs);
  }

  String? currentSession() {
    final session = _prefs.getString(_sessionKey);
    if (session == null || session.isEmpty) {
      return null;
    }
    return session;
  }

  Future<String?> register(String username, String password) async {
    final trimmed = username.trim();
    if (trimmed.isEmpty) {
      return 'Ingresa un usuario.';
    }
    if (password.isEmpty) {
      return 'Ingresa una contraseña.';
    }
    if (_findExistingKey(trimmed) != null) {
      return 'Ese usuario ya existe.';
    }

    final users = _loadUsers();
    users[trimmed] = password;
    await _saveUsers(users);
    return null;
  }

  Future<String?> login(
    String username,
    String password, {
    required bool remember,
  }) async {
    final trimmed = username.trim();
    if (trimmed.isEmpty) {
      return 'Ingresa tu usuario.';
    }
    if (password.isEmpty) {
      return 'Ingresa tu contraseña.';
    }

    final key = _findExistingKey(trimmed);
    if (key == null) {
      return 'Usuario o contraseña incorrectos.';
    }

    final users = _loadUsers();
    if (users[key] != password) {
      return 'Usuario o contraseña incorrectos.';
    }

    if (remember) {
      await _prefs.setString(_sessionKey, key);
    } else {
      await _prefs.remove(_sessionKey);
    }
    return null;
  }

  Future<void> logout() async {
    await _prefs.remove(_sessionKey);
  }

  Map<String, String> _loadUsers() {
    final raw = _prefs.getString(_usersKey);
    if (raw == null || raw.isEmpty) {
      return {};
    }
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map(
      (key, value) => MapEntry(key, value as String),
    );
  }

  Future<void> _saveUsers(Map<String, String> users) async {
    await _prefs.setString(_usersKey, jsonEncode(users));
  }

  String? _findExistingKey(String username) {
    final lower = username.toLowerCase();
    for (final key in _loadUsers().keys) {
      if (key.toLowerCase() == lower) {
        return key;
      }
    }
    return null;
  }
}
