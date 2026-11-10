import 'package:flutter_test/flutter_test.dart';
import 'package:proycto_1/core/l10n/app_strings.dart';
import 'package:proycto_1/features/auth/auth_repository.dart';

void main() {
  const strings = AppStrings.spanish;

  group('validateName', () {
    test('vacío devuelve mensaje de requerido', () {
      expect(AuthRepository.validateName('', strings), strings.enterName);
      expect(AuthRepository.validateName('   ', strings), strings.enterName);
    });

    test('minúscula inicial no pasa', () {
      expect(AuthRepository.validateName('campus', strings), isNotNull);
    });

    test('menos de 5 caracteres no pasa', () {
      expect(AuthRepository.validateName('Camp', strings), isNotNull);
    });

    test('dos espacios seguidos no pasa', () {
      expect(AuthRepository.validateName('Miguel  Angel', strings), isNotNull);
    });

    test('segunda palabra sin mayúscula no pasa', () {
      expect(AuthRepository.validateName('Miguel angel', strings), isNotNull);
    });

    test('nombre de varias palabras válido', () {
      const fullName = 'Miguel Angel Sandoval Guardado';
      expect(AuthRepository.validateName(fullName, strings), isNull);
      expect(AuthRepository.validateName('  $fullName  ', strings), isNull);
    });

    test('nombre corto válido conserva formato', () {
      expect(AuthRepository.validateName('Campus', strings), isNull);
      expect(AuthRepository.validateName('Camp1', strings), isNotNull);
    });
  });
}
