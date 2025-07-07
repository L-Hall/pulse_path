import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/firebase_auth_repository.dart';
import '../../domain/models/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

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
  @override
  AuthState build() {
    // Listen to auth state changes
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            state = AuthState.authenticated(user);
          } else {
            // Auto-sign in anonymously for better UX during development
            Future.microtask(() => signInAnonymously());
            state = const AuthState.unauthenticated();
          }
        },
        loading: () => state = const AuthState.loading(),
        error: (error, stackTrace) => state = AuthState.error(error.toString()),
      );
    });

    return const AuthState.initial();
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
      state = const AuthState.loading();
      final authRepository = ref.read(authRepositoryProvider);
      final user = await authRepository.signInAnonymously();
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
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