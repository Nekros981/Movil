import 'package:flutter/material.dart';

import 'app.dart';
import 'features/auth/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authRepository = await AuthRepository.create();
  runApp(CampusQuestApp(authRepository: authRepository));
}
