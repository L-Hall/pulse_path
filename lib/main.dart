import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_constants.dart';
import 'core/di/injection_container.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await initializeDependencies();
  
  runApp(const ProviderScope(child: PulsePathApp()));
}

class PulsePathApp extends ConsumerWidget {
  const PulsePathApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B73FF), // PulsePath brand color
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B73FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

