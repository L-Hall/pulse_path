# Git Worktrees Usage Guide for PulsePath Development

## Overview
This guide demonstrates how to use git worktrees to enable 4x parallel development across PulsePath features, eliminating context switching and accelerating time-to-market.

## Quick Start

### 1. List Available Worktrees
```bash
./scripts/dev.sh list-worktrees
```

### 2. Set Up Worktree Environments
```bash
# For BLE wearable integration (Phase 6)
./scripts/dev.sh setup-worktree ble_integration

# For Firebase cloud sync (Phase 7)
./scripts/dev.sh setup-worktree cloud_sync

# For subscription paywall (Phase 8)
./scripts/dev.sh setup-worktree subscription_paywall

# For adaptive pacing features (Phase 9)
./scripts/dev.sh setup-worktree adaptive_pacing

# For parallel testing/QA
./scripts/dev.sh setup-worktree testing_qa
```

### 3. Start Isolated Development Environment
```bash
# Start BLE development environment
./scripts/dev.sh start-worktree ble_integration

# Start cloud sync environment
./scripts/dev.sh start-worktree cloud_sync
```

### 4. Work in Parallel Environments

**Terminal 1 - BLE Integration:**
```bash
cd worktrees/ble_integration
# Work on Polar H10, Garmin HRM-Pro integration
flutter run -d chrome --web-port=8051
```

**Terminal 2 - Cloud Sync:**
```bash
cd worktrees/cloud_sync
# Work on Firebase authentication and Firestore sync
flutter run -d chrome --web-port=8052
```

**Terminal 3 - Testing/QA:**
```bash
cd worktrees/testing_qa
# Run comprehensive test suites
flutter test
```

**Terminal 4 - Subscription Features:**
```bash
cd worktrees/subscription_paywall
# Work on StoreKit 2 and Play Billing integration
flutter build apk --debug
```

## Environment Isolation

Each worktree has:
- **Independent Flutter ports**: 8051, 8052, 8053, 8054, 8055
- **Separate backend ports**: 8101, 8102, 8103, 8104, 8105
- **Isolated branch tracking**
- **Independent build artifacts**

## Development Commands

### Flutter Development
```bash
# Run Flutter app in specific worktree
./scripts/dev.sh flutter-run ble_integration

# Build app in specific worktree
./scripts/dev.sh flutter-build cloud_sync --release

# Run tests in specific worktree
./scripts/dev.sh flutter-test testing_qa
```

### Worktree Management
```bash
# Sync shared files (pubspec.yaml, CLAUDE.md, scripts) across all worktrees
./scripts/dev.sh sync-worktrees

# Stop services for a worktree
./scripts/dev.sh stop-worktree ble_integration

# Clean all worktree build artifacts
./scripts/dev.sh clean-worktrees

# Remove a worktree completely
./scripts/dev.sh remove-worktree subscription_paywall
```

## PulsePath Development Roadmap Mapping

| Worktree | Branch | Ports | Phase | Purpose |
|----------|--------|-------|-------|---------|
| `ble_integration` | `ble-integration` | 8051/8101 | **Phase 6** | BLE wearable integration |
| `cloud_sync` | `cloud-sync` | 8052/8102 | **Phase 7** | Firebase authentication & sync |
| `subscription_paywall` | `subscription-paywall` | 8053/8103 | **Phase 8** | Monetization features |
| `adaptive_pacing` | `adaptive-pacing` | 8054/8104 | **Phase 9** | Chronic illness support |
| `testing_qa` | `testing-qa` | 8055/8105 | **Continuous** | Parallel testing environment |

## Phase 6: BLE Integration Development

### High-Priority Tasks (worktrees/ble_integration)
1. **Complete BLE device pairing flow**
   - Polar H10 heart rate belt integration
   - Garmin HRM-Pro compatibility
   - Device discovery and connection UI

2. **Real-time data streaming**
   - 100Hz+ heart rate data capture
   - Integration with existing HRV calculation pipeline
   - Buffer management and data validation

3. **Device persistence**
   - Save paired devices for auto-reconnection
   - Connection state management
   - Error handling and reconnection logic

4. **Testing with real hardware**
   - Polar H10 validation
   - Performance benchmarking vs camera PPG
   - Cross-platform compatibility testing

### Development Environment Setup
```bash
cd worktrees/ble_integration
./scripts/dev.sh start-worktree ble_integration

# Enable Bluetooth permissions for testing
# iOS: Info.plist NSBluetoothAlwaysUsageDescription
# Android: android.permission.BLUETOOTH_CONNECT
```

## Phase 7: Cloud Sync Development

### High-Priority Tasks (worktrees/cloud_sync)
1. **Firebase Authentication**
   - Email/password authentication
   - Google Sign-In integration
   - Anonymous authentication for trial users

2. **Encrypted Firestore sync**
   - Client-side AES-GCM encryption before upload
   - Multi-device data continuity
   - Conflict resolution strategies

3. **Offline-first architecture**
   - Local-first data operations
   - Sync queue management
   - Connection state handling

### Development Environment Setup
```bash
cd worktrees/cloud_sync
# Configure Firebase project for development
firebase use development
./scripts/dev.sh start-worktree cloud_sync
```

## Benefits Achieved

✅ **4x Parallel Development**: All phases can progress simultaneously  
✅ **Zero Context Switching**: Each environment maintains focused state  
✅ **Environment Isolation**: No port conflicts or dependency issues  
✅ **Independent Testing**: Isolated test runs without cross-contamination  
✅ **Risk Reduction**: Feature isolation until proven stable  
✅ **Faster Integration**: Clean feature branches ready for merging  

## Performance Considerations

### Resource Usage
- **Disk Space**: ~15GB additional (5 complete worktrees)
- **Memory**: ~4GB additional (parallel Flutter environments)
- **Network**: Multiple emulator instances
- **CPU**: Parallel builds and tests

### Port Allocation
- **Main app**: Default Flutter ports (8080)
- **BLE Integration**: 8051 (Flutter) + 8101 (Backend)
- **Cloud Sync**: 8052 (Flutter) + 8102 (Backend)
- **Subscription**: 8053 (Flutter) + 8103 (Backend)
- **Adaptive Pacing**: 8054 (Flutter) + 8104 (Backend)
- **Testing/QA**: 8055 (Flutter) + 8105 (Backend)

## Integration Strategy

### Branch Management
1. **Feature Development**: Work in isolated worktree branches
2. **Regular Sync**: Use `sync-worktrees` to keep shared files updated
3. **Testing**: Validate in `testing_qa` worktree before merge
4. **Integration**: Merge feature branches to main when stable

### Shared File Synchronization
The following files are automatically synced across all worktrees:
- `pubspec.yaml` - Dependency management
- `pubspec.lock` - Version locking
- `analysis_options.yaml` - Code style rules
- `CLAUDE.md` - Project documentation
- `scripts/` - Development tools

## Troubleshooting

### Port Conflicts
```bash
# Check what's using a port
lsof -i :8051

# Stop worktree services
./scripts/dev.sh stop-worktree ble_integration
```

### Sync Issues
```bash
# Clean and rebuild
./scripts/dev.sh clean-worktrees
flutter clean && flutter pub get
```

### Branch Conflicts
```bash
# List all worktrees
git worktree list

# Remove problematic worktree
./scripts/dev.sh remove-worktree <name>

# Recreate clean worktree
./scripts/dev.sh setup-worktree <name>
```

## Timeline Acceleration

With worktrees enabling parallel development:
- **Sequential Development**: 10-12 weeks (Phase 6→7→8→9)
- **Parallel Development**: 6-8 weeks (All phases concurrent)
- **Time Savings**: 40-50% faster to Alpha release

## Next Steps for Maximum Velocity

1. **Start Phase 6 BLE integration** in `worktrees/ble_integration`
2. **Begin Phase 7 cloud sync** in `worktrees/cloud_sync`  
3. **Set up continuous testing** in `worktrees/testing_qa`
4. **Plan Phase 8-9 features** in remaining worktrees
5. **Maintain shared configurations** with regular sync

This worktree strategy transforms PulsePath development from sequential feature delivery to true parallel development, dramatically accelerating Alpha release while maintaining code quality and reducing integration risks.