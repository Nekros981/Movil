import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proycto_1/app.dart';
import 'package:proycto_1/features/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('Login muestra título y botón de sesión', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final authRepository = AuthRepository(
      await SharedPreferences.getInstance(),
    );

    await tester.pumpWidget(CampusQuestApp(authRepository: authRepository));
    await tester.pumpAndSettle();

    expect(find.text('Continúa tu aventura'), findsOneWidget);
    expect(find.text('Iniciar sesión  →'), findsOneWidget);
    expect(find.text('Crear cuenta'), findsOneWidget);
  });
}
