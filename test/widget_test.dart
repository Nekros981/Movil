import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proycto_1/app.dart';
import 'package:proycto_1/features/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  setUpAll(() async {
    GoogleFonts.config.allowRuntimeFetching = false;
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await Supabase.initialize(
      url: 'https://khaxjerxneoluzoktrdc.supabase.co',
      publishableKey: 'sb_publishable_ojJLV24jKUueycBNPiDeEg_45MsY4db',
    );
  });

  testWidgets('Login muestra título y acciones de sesión', (tester) async {
    final authRepository = AuthRepository(Supabase.instance.client);

    await tester.pumpWidget(CampusQuestApp(authRepository: authRepository));
    await tester.pumpAndSettle();

    expect(find.text('Continúa tu aventura'), findsOneWidget);
    expect(find.text('Iniciar sesión  →'), findsOneWidget);
    expect(find.text('Crear cuenta'), findsOneWidget);
    expect(find.text('¿Olvidaste tu contraseña?'), findsOneWidget);
  });
}
