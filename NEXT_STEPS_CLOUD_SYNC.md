# Next Steps: Cloud Sync Implementation

**Current Status**: Phase 1 Complete - Authentication Foundation ✅  
**Latest Update**: Authentication UI & Firebase Configuration Issues Resolved ✅  
**Next Phase**: Phase 2 - Cloud Data Repositories & Firestore Operations  
**Worktree**: `cloud-sync`  
**Last Updated**: January 6, 2025

## ⚠️ **IMPORTANT: Resolve Merge Conflicts Before Proceeding**

Before starting Phase 2 of cloud sync, the following merge conflicts from worktree integration must be resolved:

### **Critical Files with Merge Conflicts**
1. **Test Files** (4 files):
   - `test/integration/app_integration_test.dart`
   - `test/support/test_utils.dart`
   - `test/support/mock_data_service.dart`
   - `test/performance/performance_test_suite.dart`

2. **Core Services** (3 files):
   - `lib/core/services/performance_monitoring_service.dart`
   - `lib/core/services/logging_service.dart`
   - `lib/core/utils/migration_helper.dart`

3. **BLE Service** (1 file - partially fixed):
   - `lib/features/ble/domain/services/hrv_quality_service.dart`

### **Resolution Steps**
1. Search for `<<<<<<< HEAD` markers in each file
2. Resolve conflicts by choosing correct code version
3. Remove all conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
4. Run `flutter analyze` to verify no syntax errors
5. Run `flutter test` to ensure tests pass
6. Commit resolved files


## 🎯 **Phase 2: Cloud Data Repositories** (Next Priority)

### **High Priority - Core Cloud Infrastructure**

#### 1. **Cloud HRV Repository** 
- [ ] Create `CloudHrvRepository` implementing `HrvRepositoryInterface`
- [ ] User-isolated Firestore collections: `/users/{uid}/hrv_readings`
- [ ] CRUD operations with proper error handling and offline support
- [ ] User-scoped data access with Firebase Auth integration

#### 2. **Encryption Service**
- [ ] Create `CloudEncryptionService` using pointycastle AES-GCM
- [ ] Client-side encryption before Firestore.set() operations
- [ ] Key derivation from user credentials (PBKDF2 + salt)
- [ ] Zero-knowledge architecture: Firebase never sees plaintext HRV data

#### 3. **Firestore Data Models**
- [ ] Create cloud-specific HRV data models with encryption metadata
- [ ] Document schema: `{ encryptedData: string, iv: string, timestamp: FieldValue }`
- [ ] Firestore security rules with user isolation
- [ ] Data validation and type safety for cloud operations

### **Medium Priority - Sync Orchestration**

#### 4. **Sync Service Architecture**
- [ ] Create `CloudSyncService` with queue management
- [ ] Offline/online state detection and sync triggers
- [ ] Background sync with exponential backoff retry logic
- [ ] Sync status indicators for UI (syncing/synced/error states)

#### 5. **Conflict Resolution**
- [ ] Last-write-wins strategy for HRV readings (timestamp-based)
- [ ] Client-side conflict detection using document versions
- [ ] Merge strategies for settings and preferences
- [ ] User notification for sync conflicts that need manual resolution

#### 6. **Data Migration Service**
- [ ] Migrate existing local data to cloud on first sign-in
- [ ] Bidirectional sync: cloud → local and local → cloud
- [ ] Progress tracking for large data migrations
- [ ] Rollback mechanisms for failed migrations

## 🔧 **Phase 3: Advanced Sync Features** (Future)

### **Sync Queue Management**
- [ ] Persistent sync queue using local database
- [ ] Priority-based sync (recent readings first)
- [ ] Batch operations for improved performance
- [ ] Network-aware sync (WiFi vs cellular considerations)

### **Multi-Device Coordination**
- [ ] Device registration and identification
- [ ] Cross-device conflict resolution
- [ ] Real-time sync using Firestore listeners
- [ ] Device-specific settings synchronization

### **Performance Optimization**
- [ ] Incremental sync (only changed data)
- [ ] Compression for large payloads
- [ ] Firestore query optimization with pagination
- [ ] Local cache invalidation strategies

## 🛠️ **Technical Implementation Plan**

### **Phase 2A: Firestore Integration (Week 1)**
```
1. Setup Firebase project with authentication & Firestore
2. Implement CloudEncryptionService with AES-GCM
3. Create CloudHrvRepository with basic CRUD operations
4. Add Firestore security rules with user isolation
5. Update dependency injection for cloud services
```

### **Phase 2B: Sync Service (Week 2)**
```
1. Implement CloudSyncService with online/offline detection
2. Create sync queue using local database
3. Add conflict resolution with timestamp-based strategy
4. Implement background sync with retry logic
5. Connect cloud sync toggle to actual functionality
```

### **Phase 2C: Integration & Testing (Week 3)**
```
1. Update UI to show sync status and progress
2. Add data migration from local to cloud
3. Implement bidirectional sync with conflict handling
4. End-to-end testing across multiple devices
5. Performance optimization and error handling
```

## 📋 **Current Architecture Ready for Integration**

### **✅ What's Already Built**
- **Authentication**: Complete Firebase Auth with email/password + anonymous ✅
- **Firebase Configuration**: All platforms properly configured with real project credentials ✅
- **Authentication UI**: Login/signup forms with responsive design and overflow fixes ✅
- **Local Repository**: `DatabaseHrvRepository` with SQLCipher encryption ✅
- **Repository Interface**: `HrvRepositoryInterface` for seamless cloud integration ✅
- **Error Handling**: `AuthException` and comprehensive error management ✅
- **UI Components**: User profile widget showing sync status ✅
- **Dependency Injection**: GetIt container ready for cloud services ✅


### **🔗 Integration Points**
- **Repository Swapping**: Replace `DatabaseHrvRepository` with `CloudHrvRepository` when online
- **Auth Integration**: Use `currentUser.uid` for Firestore document paths
- **Sync Status**: Update `UserProfileWidget` with real sync status from `CloudSyncService`
- **Settings Toggle**: Connect privacy settings cloud sync toggle to actual functionality

## 🚨 **Critical Implementation Notes**

### **Security Requirements**
- **End-to-End Encryption**: All HRV data encrypted client-side before Firestore
- **Zero-Knowledge**: Firebase/Google never has access to plaintext biometric data
- **User Isolation**: Firestore security rules prevent cross-user data access
- **Key Management**: Encryption keys derived from user credentials, not stored

### **Performance Targets**
- **Sync Latency**: <3 seconds for recent HRV readings
- **Offline Support**: Full app functionality without internet connection
- **Background Sync**: Automatic sync when app returns to foreground
- **Conflict Resolution**: <1 second for timestamp-based conflicts

### **Testing Strategy**
- **Multi-Device Testing**: Same user account on 2+ devices with concurrent usage
- **Network Simulation**: Test sync with poor/intermittent connectivity
- **Encryption Validation**: Verify encrypted data in Firestore console
- **Security Audit**: Test Firestore rules with different user accounts

## 📁 **File Structure for Phase 2**

```
lib/features/
├── auth/ ✅ (COMPLETED)
└── cloud_sync/ 🚧 (NEXT)
    ├── data/
    │   ├── repositories/
    │   │   ├── cloud_hrv_repository.dart
    │   │   └── cloud_settings_repository.dart
    │   └── services/
    │       ├── cloud_encryption_service.dart
    │       ├── firestore_service.dart
    │       └── cloud_sync_service.dart
    ├── domain/
    │   ├── models/
    │   │   ├── cloud_hrv_document.dart
    │   │   ├── sync_status.dart
    │   │   └── sync_conflict.dart
    │   └── repositories/
    │       └── cloud_sync_repository.dart
    └── presentation/
        ├── providers/
        │   ├── cloud_sync_providers.dart
        │   └── sync_status_providers.dart
        └── widgets/
            ├── sync_status_widget.dart
            └── cloud_settings_widget.dart
```

## 🎯 **Success Criteria for Phase 2**

### **Functional Requirements**
- [ ] User can sign in and see their data synced across devices
- [ ] Anonymous users can upgrade and migrate their local data to cloud
- [ ] Cloud sync toggle in settings actually enables/disables synchronization
- [ ] App works seamlessly offline with automatic sync when online
- [ ] HRV data is encrypted end-to-end (verify in Firestore console)

### **Performance Requirements**
- [ ] Sync completes within 3 seconds for recent data
- [ ] No impact on dashboard load time (<400ms target maintained)
- [ ] Background sync doesn't affect app responsiveness
- [ ] Conflict resolution resolves automatically without user intervention

### **Security Requirements**
- [ ] Firestore security rules prevent unauthorized access
- [ ] All HRV data encrypted before leaving device
- [ ] User isolation verified across multiple test accounts
- [ ] No plaintext biometric data visible in Firebase console

## 🔄 **Ready to Begin Phase 2**

The authentication foundation is complete and production-ready. The next session should focus on implementing the `CloudEncryptionService` and `CloudHrvRepository` to begin the core cloud data synchronization functionality.

**Estimated Timeline**: 2-3 weeks for complete cloud sync implementation  
**Risk Level**: Low (solid foundation already established)  
**Dependencies**: Firebase project setup (follow FIREBASE_SETUP.md)