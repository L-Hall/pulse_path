import '../models/app_user.dart';

abstract class AuthRepository {
  // Authentication state
  Stream<AppUser?> get authStateChanges;
  AppUser? get currentUser;
  
  // Email/Password authentication
  Future<AppUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  Future<AppUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  });
  
  // Anonymous authentication
  Future<AppUser> signInAnonymously();
  
  // Link anonymous account to email/password
  Future<AppUser> linkWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  // Password management
  Future<void> sendPasswordResetEmail(String email);
  Future<void> updatePassword(String newPassword);
  
  // Email verification
  Future<void> sendEmailVerification();
  Future<void> reloadUser();
  
  // Account management
  Future<void> updateDisplayName(String displayName);
  Future<void> deleteAccount();
  
  // Sign out
  Future<void> signOut();
}