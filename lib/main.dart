import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_constants.dart';
import 'core/di/injection_container.dart';
import 'core/theme/liquid_glass_theme.dart';
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
    final seedColor = const Color(0xFF6B73FF); // PulsePath brand color
    
    return MaterialApp(
      title: AppConstants.appName,
      theme: LiquidGlassMaterial3Theme.lightTheme(
        ColorScheme.fromSeed(seedColor: seedColor),
      ),
      darkTheme: LiquidGlassMaterial3Theme.darkTheme(
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

