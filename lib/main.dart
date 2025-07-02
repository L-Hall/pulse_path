import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/constants/app_constants.dart';
import 'core/di/injection_container.dart';
import 'core/theme/liquid_glass_theme.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with error handling
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Firebase initialized successfully');
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
    // Continue without Firebase for development
  }
  
  // Initialize dependencies in background (don't block UI)
  debugPrint('Starting dependency initialization in background...');
  initializeDependencies().then((_) {
    debugPrint('Dependencies initialized successfully');
  }).catchError((Object e) {
    debugPrint('Dependency initialization failed: $e');
    // Providers will handle missing dependencies gracefully
  });
  
  runApp(const ProviderScope(child: PulsePathApp()));
}

class PulsePathApp extends ConsumerWidget {
  const PulsePathApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const seedColor = Color(0xFF6B73FF); // PulsePath brand color
    
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

