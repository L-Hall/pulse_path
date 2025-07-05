import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Core providers
final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

// Settings cache box provider
final settingsCacheProvider = FutureProvider<Box<dynamic>>((ref) async {
  return await Hive.openBox<dynamic>('settings_cache');
});

// App state providers
final appInitializationProvider = FutureProvider<bool>((ref) async {
  // Initialize core services
  await Hive.initFlutter();
  
  // Initialize encryption keys
  // This will be expanded later
  
  return true;
});

// Feature providers will be added here as features are implemented
// - HRV providers
// - Dashboard providers  
// - Settings providers
// - Sync providers