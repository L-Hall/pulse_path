# PulsePath

A cross-platform Flutter app for HRV-based wellbeing tracking with real-time **Stress, Recovery, and Energy scores (0-100)** using 3-minute heart rate variability readings.

## Key Features

- **3-minute PPG HRV capture** via camera or BLE wearables
- **Adaptive Pacing Mode** for chronic illness recovery with PEM-risk detection
- **Encrypted cloud sync** with opt-out local-only mode
- **Transparent HRV scoring** with open formulas and citations
- **Privacy-first design** (GDPR compliant, no third-party ad SDKs)

## 🚀 4x Parallel Development with Git Worktrees

This project uses Git worktrees to enable simultaneous development across multiple features. **Work on 4+ features in parallel without context switching!**

### Quick Start for Parallel Development

```bash
# Set up all worktrees
./dev.sh list-worktrees              # View current setup
./dev.sh setup-worktree ble_integration  # Set up BLE worktree
./dev.sh setup-worktree cloud_sync   # Set up cloud sync worktree

# Launch 4 terminals automatically
./setup_terminals.sh                 # Auto-configures iTerm2/Terminal.app/tmux

# Or open VSCode multi-root workspace
code pulse_path.code-workspace        # All worktrees in one IDE
```

### Available Worktrees

| Worktree | Purpose | Port |
|----------|---------|------|
| **ble_integration** | BLE wearable integration (Phase 6) | 8051 |
| **cloud_sync** | Firebase cloud synchronization (Phase 7) | 8052 |
| **subscription_paywall** | Monetization and payments (Phase 8) | 8053 |
| **adaptive_pacing** | Chronic illness features (Phase 9) | 8054 |
| **testing_qa** | Parallel testing environment | 8055 |

### Typical 4x Workflow

```bash
# Terminal 1: Main coordination
./dev.sh sync-worktrees    # Sync shared files
git status                 # Monitor main branch

# Terminal 2: Feature development
cd worktrees/ble_integration
flutter run                # Develop with hot reload

# Terminal 3: Continuous testing  
cd worktrees/testing_qa
flutter test --watch       # Tests run as you code

# Terminal 4: Build verification
cd worktrees/cloud_sync
flutter build web          # Verify builds work
```

📖 **Full Documentation**: See [README_WORKTREES.md](README_WORKTREES.md) for complete worktree setup and usage guide.

## Standard Flutter Development

### Common Commands

```bash
# Development
flutter run                          # Run app
flutter test                         # Run tests
flutter analyze                      # Code analysis
flutter build apk --release          # Android release build
flutter build ios --release          # iOS release build

# Dependencies
flutter pub get                      # Get dependencies
flutter pub upgrade                  # Upgrade dependencies
flutter clean && flutter pub get    # Clean build

# Code Generation
flutter packages pub run build_runner build    # Generate code
flutter packages pub run build_runner watch    # Watch for changes
```

### Project Structure

```
lib/
├── core/                   # Core utilities, DI, themes
├── features/              # Feature-based modules
│   ├── dashboard/         # Main dashboard UI
│   ├── hrv/              # HRV calculation engine
│   ├── ble/              # BLE wearable integration
│   └── settings/         # App settings and preferences
└── shared/               # Shared models and repositories
    ├── models/           # Data models (Freezed)
    └── repositories/     # Data access layer
```

## Technology Stack

- **Flutter 4.x + Dart 3.4**: Cross-platform development
- **riverpod ^2.4.9**: State management
- **drift + SQLCipher**: Encrypted local database
- **firebase**: Cloud services and authentication
- **flutter_blue_plus**: BLE connectivity
- **camera**: PPG heart rate capture
- **fl_chart**: Data visualization

## Development Guidelines

### Quality Standards
- **Code coverage**: ≥80%
- **Static analysis**: Zero `flutter analyze` issues
- **Performance**: <2s cold start, <400ms dashboard load
- **Security**: AES-256 encryption for all biometric data

### Architecture
- **Offline-first**: Full feature parity without internet
- **Repository pattern**: Clean separation of data access
- **Feature modules**: Domain-driven structure
- **Encrypted storage**: No plaintext biometric data

## Platform Support

- **Android**: 8.1+ (API 27)
- **iOS**: 13.0+
- **Web**: Modern browsers
- **macOS**: 10.14+
- **Windows**: Windows 10+
- **Linux**: Ubuntu 18.04+

## Getting Started

### Prerequisites

```bash
# Install Flutter
flutter doctor -v              # Verify Flutter installation

# Get project dependencies
flutter pub get

# Set up development environment
flutter config --enable-web --enable-macos-desktop
```

### First Run

```bash
# Web (fastest for development)
flutter run -d chrome

# Mobile (requires emulator/device)
flutter run

# Specific platform
flutter run -d android
flutter run -d ios
```

### Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html

# Widget tests only
flutter test test/widget_test.dart

# Integration tests
flutter test integration_test/
```

## Contributing

1. **Use worktrees** for feature development (see worktree guide above)
2. **Follow conventions**: Check `CLAUDE.md` for detailed guidelines
3. **Test thoroughly**: Maintain ≥80% code coverage
4. **Security first**: Encrypt all biometric data
5. **Performance matters**: Profile critical paths

### Development Workflow

```bash
# 1. Set up feature worktree
./dev.sh setup-worktree my_feature

# 2. Develop in parallel
cd worktrees/my_feature
flutter run
# ... develop with hot reload ...

# 3. Test continuously
cd worktrees/testing_qa
flutter test --watch

# 4. Verify and merge
flutter analyze --no-fatal-infos
git checkout main
git merge my_feature
```

## Project Status

**Current Phase**: Phase 5 Complete - Database Migration Infrastructure ✅

**Completed Phases**:
- ✅ Phase 1: Foundation Setup
- ✅ Phase 2A: HRV Metrics Engine  
- ✅ Phase 2B: Camera PPG Capture
- ✅ Phase 3: Dashboard UI
- ✅ Phase 4: Database Infrastructure
- ✅ Phase 5: Platform Migration

**Next Phases**:
- 🔄 Phase 6: BLE Wearable Integration
- 📋 Phase 7: Cloud Sync Implementation
- 💳 Phase 8: Subscription Paywall
- 🏃 Phase 9: Adaptive Pacing Features

## Support

- **Worktree Issues**: See [README_WORKTREES.md](README_WORKTREES.md)
- **Development Guidelines**: Check `CLAUDE.md`
- **Flutter Documentation**: [docs.flutter.dev](https://docs.flutter.dev/)

---

**Happy coding with 4x parallel development!** 🚀