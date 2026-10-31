import 'package:flutter_test/flutter_test.dart';
import 'package:proycto_1/features/auth/auth_repository.dart';

void main() {
  group('validateName', () {
    test('vacío devuelve mensaje de requerido', () {
      expect(AuthRepository.validateName(''), 'Ingresa tu nombre.');
      expect(AuthRepository.validateName('   '), 'Ingresa tu nombre.');
    });

    test('minúscula inicial no pasa', () {
      expect(AuthRepository.validateName('campus'), isNotNull);
    });

    test('menos de 5 caracteres no pasa', () {
      expect(AuthRepository.validateName('Camp'), isNotNull);
    });

    test('dos espacios seguidos no pasa', () {
      expect(AuthRepository.validateName('Miguel  Angel'), isNotNull);
    });

    test('segunda palabra sin mayúscula no pasa', () {
      expect(AuthRepository.validateName('Miguel angel'), isNotNull);
    });

    test('nombre de varias palabras válido', () {
      const fullName = 'Miguel Angel Sandoval Guardado';
      expect(AuthRepository.validateName(fullName), isNull);
      expect(AuthRepository.validateName('  $fullName  '), isNull);
    });

    test('nombre corto válido conserva formato', () {
      expect(AuthRepository.validateName('Campus'), isNull);
      expect(AuthRepository.validateName('Camp1'), isNull);
    });
  });
}
