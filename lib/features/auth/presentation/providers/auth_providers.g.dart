// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseInitializationStatusHash() =>
    r'fc5214777eae774cc2f0346d5ec6aba921022824';

/// Provider to track Firebase initialization status
///
/// Copied from [firebaseInitializationStatus].
@ProviderFor(firebaseInitializationStatus)
final firebaseInitializationStatusProvider =
    AutoDisposeStreamProvider<bool>.internal(
  firebaseInitializationStatus,
  name: r'firebaseInitializationStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseInitializationStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseInitializationStatusRef = AutoDisposeStreamProviderRef<bool>;
String _$authRepositoryHash() => r'22f0b4b198bb3b96967bde140f2ff7a7c7061c8a';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$authStateChangesHash() => r'5f27265a9bbdf46816782437ebc9b81daeda6769';

/// See also [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = AutoDisposeStreamProvider<AppUser?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateChangesRef = AutoDisposeStreamProviderRef<AppUser?>;
String _$currentUserHash() => r'e7538da46648b5808b0a4110189c6e9943c338ab';

/// See also [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeProvider<AppUser?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = AutoDisposeProviderRef<AppUser?>;
String _$isAuthenticatedHash() => r'6d1663acdb856e415c4d2bad9a978ab9e575bc42';

/// See also [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeProvider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAuthenticatedRef = AutoDisposeProviderRef<bool>;
String _$isAnonymousHash() => r'4cacf3a61829b0bfd4b8895ecf0e3f7842eff3e2';

/// See also [isAnonymous].
@ProviderFor(isAnonymous)
final isAnonymousProvider = AutoDisposeProvider<bool>.internal(
  isAnonymous,
  name: r'isAnonymousProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isAnonymousHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAnonymousRef = AutoDisposeProviderRef<bool>;
String _$authNotifierHash() => r'f957b0822730daf094d98de97550920bfb472e4b';

/// See also [AuthNotifier].
@ProviderFor(AuthNotifier)
final authNotifierProvider =
    AutoDisposeNotifierProvider<AuthNotifier, AuthState>.internal(
  AuthNotifier.new,
  name: r'authNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthNotifier = AutoDisposeNotifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
