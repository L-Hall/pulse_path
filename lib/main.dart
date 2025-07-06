import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/constants/app_constants.dart';
import 'core/di/injection_container.dart';
import 'core/theme/liquid_glass_theme.dart';
import 'features/auth/presentation/providers/auth_providers.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/cloud_sync/presentation/providers/cloud_sync_providers.dart';
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
      home: const AuthGate(),
    );
  }
}

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    
    // Initialize cloud sync manager to watch for settings changes
    ref.watch(cloudSyncManagerProvider);
    
    return authState.when(
      initial: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      authenticated: (user) => const DashboardPage(),
      unauthenticated: () => const AuthPage(),
      error: (message) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Authentication Error',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).signInAnonymously();
                },
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

