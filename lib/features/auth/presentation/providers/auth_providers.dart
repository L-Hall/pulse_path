import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';
import '../../data/repositories/firebase_auth_repository.dart';
import '../../domain/models/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

/// Provider to track Firebase initialization status
@riverpod
Stream<bool> firebaseInitializationStatus(FirebaseInitializationStatusRef ref) async* {
  // Check initial state
  yield Firebase.apps.isNotEmpty;
  
  // Poll for Firebase initialization
  while (Firebase.apps.isEmpty) {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    yield Firebase.apps.isNotEmpty;
  }
  
  // Once initialized, maintain the state
  yield true;
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return FirebaseAuthRepository();
}

@riverpod
Stream<AppUser?> authStateChanges(AuthStateChangesRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  bool _hasAttemptedAutoSignIn = false;
  
  @override
  AuthState build() {
    // Listen to auth state changes
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            state = AuthState.authenticated(user);
            _hasAttemptedAutoSignIn = false; // Reset flag on successful auth
          } else {
            state = const AuthState.unauthenticated();
            // Only attempt auto-sign-in once per session and with proper Firebase check
            if (!_hasAttemptedAutoSignIn) {
              _hasAttemptedAutoSignIn = true;
              _attemptAutoSignIn();
            }
          }
        },
        loading: () => state = const AuthState.loading(),
        error: (error, stackTrace) {
          debugPrint('❌ Auth state error: $error');
          // Don't show error state for Firebase initialization issues
          if (error.toString().contains('Firebase') || 
              error.toString().contains('No Firebase App')) {
            debugPrint('🔄 Firebase not ready, staying in unauthenticated state');
            state = const AuthState.unauthenticated();
          } else {
            state = AuthState.error(error.toString());
          }
        },
      );
    });

    return const AuthState.initial();
  }

  Future<void> _attemptAutoSignIn() async {
    debugPrint('🔄 Attempting auto sign-in...');
    
    // Check if Firebase is initialized
    try {
      final apps = Firebase.apps;
      if (apps.isEmpty) {
        debugPrint('⏳ Firebase not initialized yet, waiting...');
        // Wait a bit for Firebase to initialize
        await Future<void>.delayed(const Duration(seconds: 2));
        
        // Check again
        final appsAfterWait = Firebase.apps;
        if (appsAfterWait.isEmpty) {
          debugPrint('❌ Firebase still not initialized after wait');
          return;
        }
      }
      
      debugPrint('✅ Firebase is initialized, proceeding with auto sign-in');
      await signInAnonymously();
    } catch (e) {
      debugPrint('❌ Auto sign-in check failed: $e');
      // Stay in unauthenticated state rather than error state
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      state = const AuthState.loading();
      final authRepository = ref.read(authRepositoryProvider);
      final user = await authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      state = const AuthState.loading();
      final authRepository = ref.read(authRepositoryProvider);
      final user = await authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signInAnonymously() async {
    try {
      // Check Firebase is initialized before attempting sign in
      if (Firebase.apps.isEmpty) {
        debugPrint('⚠️ Cannot sign in: Firebase not initialized');
        state = const AuthState.unauthenticated();
        return;
      }
      
      state = const AuthState.loading();
      final authRepository = ref.read(authRepositoryProvider);
      final user = await authRepository.signInAnonymously();
      state = AuthState.authenticated(user);
    } catch (e) {
      debugPrint('❌ Sign in anonymously failed: $e');
      // Check if it's a Firebase initialization error
      if (e.toString().contains('Firebase') || 
          e.toString().contains('No Firebase App')) {
        state = const AuthState.unauthenticated();
      } else {
        state = AuthState.error(e.toString());
      }
    }
  }

  Future<void> linkWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      state = const AuthState.loading();
      final authRepository = ref.read(authRepositoryProvider);
      final user = await authRepository.linkWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.sendPasswordResetEmail(email);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.sendEmailVerification();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.updateDisplayName(displayName);
      // Reload user to get updated info
      await authRepository.reloadUser();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.updatePassword(newPassword);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> deleteAccount() async {
    try {
      state = const AuthState.loading();
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.deleteAccount();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      state = const AuthState.loading();
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.signOut();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}

@riverpod
AppUser? currentUser(CurrentUserRef ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.maybeWhen(
    authenticated: (user) => user,
    orElse: () => null,
  );
}

@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );
}

@riverpod
bool isAnonymous(IsAnonymousRef ref) {
  final user = ref.watch(currentUserProvider);
  return user?.isAnonymous ?? false;
}