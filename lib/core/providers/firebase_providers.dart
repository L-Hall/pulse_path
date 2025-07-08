import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../firebase_options.dart';

/// Provider for Firebase initialization
final firebaseInitializationProvider = FutureProvider<FirebaseApp>((ref) async {
  debugPrint('🔥 Initializing Firebase...');
  try {
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('✅ Firebase initialized successfully');
    return app;
  } catch (e) {
    debugPrint('❌ Firebase initialization failed: $e');
    // For development, we can continue without Firebase
    if (kDebugMode) {
      throw Exception('Firebase initialization failed (development mode): $e');
    }
    rethrow;
  }
});

/// Provider to check if Firebase is ready
final isFirebaseReadyProvider = Provider<bool>((ref) {
  final firebaseAsync = ref.watch(firebaseInitializationProvider);
  return firebaseAsync.hasValue && Firebase.apps.isNotEmpty;
});