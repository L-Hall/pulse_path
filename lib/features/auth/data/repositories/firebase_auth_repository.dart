import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/models/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/exceptions/app_exceptions.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  
  FirebaseAuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<AppUser?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) => user != null ? _mapFirebaseUser(user) : null);
  }

  @override
  AppUser? get currentUser {
    final user = _firebaseAuth.currentUser;
    return user != null ? _mapFirebaseUser(user) : null;
  }

  @override
  Future<AppUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user == null) {
        throw const AuthException('Sign in failed: No user returned');
      }
      
      return _mapFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthError(e));
    } catch (e) {
      throw AuthException('Sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user == null) {
        throw const AuthException('Account creation failed: No user returned');
      }
      
      // Update display name if provided
      if (displayName != null && displayName.isNotEmpty) {
        await credential.user!.updateDisplayName(displayName);
        await credential.user!.reload();
      }
      
      return _mapFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthError(e));
    } catch (e) {
      throw AuthException('Account creation failed: ${e.toString()}');
    }
  }

  @override
  Future<AppUser> signInAnonymously() async {
    try {
      final credential = await _firebaseAuth.signInAnonymously();
      
      if (credential.user == null) {
        throw const AuthException('Anonymous sign in failed: No user returned');
      }
      
      return _mapFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthError(e));
    } catch (e) {
      throw AuthException('Anonymous sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<AppUser> linkWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const AuthException('No user currently signed in');
      }

      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      final linkedCredential = await user.linkWithCredential(credential);
      
      if (linkedCredential.user == null) {
        throw const AuthException('Account linking failed: No user returned');
      }
      
      return _mapFirebaseUser(linkedCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthError(e));
    } catch (e) {
      throw AuthException('Account linking failed: ${e.toString()}');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthError(e));
    } catch (e) {
      throw AuthException('Password reset failed: ${e.toString()}');
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const AuthException('No user currently signed in');
      }
      
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthError(e));
    } catch (e) {
      throw AuthException('Password update failed: ${e.toString()}');
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const AuthException('No user currently signed in');
      }
      
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthError(e));
    } catch (e) {
      throw AuthException('Email verification failed: ${e.toString()}');
    }
  }

  @override
  Future<void> reloadUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const AuthException('No user currently signed in');
      }
      
      await user.reload();
    } catch (e) {
      throw AuthException('User reload failed: ${e.toString()}');
    }
  }

  @override
  Future<void> updateDisplayName(String displayName) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const AuthException('No user currently signed in');
      }
      
      await user.updateDisplayName(displayName);
      await user.reload();
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthError(e));
    } catch (e) {
      throw AuthException('Display name update failed: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const AuthException('No user currently signed in');
      }
      
      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthError(e));
    } catch (e) {
      throw AuthException('Account deletion failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException('Sign out failed: ${e.toString()}');
    }
  }

  // Helper methods
  AppUser _mapFirebaseUser(User user) {
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      isAnonymous: user.isAnonymous,
      createdAt: user.metadata.creationTime,
      lastSignInAt: user.metadata.lastSignInTime,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      isEmailVerified: user.emailVerified,
    );
  }

  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email address.';
      case 'wrong-password':
        return 'Invalid password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'Password is too weak. Please choose a stronger password.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      case 'requires-recent-login':
        return 'Please sign in again to complete this action.';
      case 'credential-already-in-use':
        return 'This account is already linked to another user.';
      case 'provider-already-linked':
        return 'This account is already linked with this provider.';
      default:
        return e.message ?? 'An authentication error occurred.';
    }
  }
}