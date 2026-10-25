import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'features/auth/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://khaxjerxneoluzoktrdc.supabase.co',
    publishableKey: 'sb_publishable_ojJLV24jKUueycBNPiDeEg_45MsY4db',
  );
  final authRepository = AuthRepository(Supabase.instance.client);
  runApp(CampusQuestApp(authRepository: authRepository));
}
