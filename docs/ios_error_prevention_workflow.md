# iOS Error Prevention Workflow

This document outlines a systematic approach to prevent and quickly resolve iOS build errors in the PulsePath Flutter project.

## 🚨 Pre-Development Checklist

Before making any changes that could affect iOS builds:

### 1. Environment Verification
```bash
# Check Flutter version and health
flutter --version
flutter doctor -v

# Verify Xcode is up to date
xcodebuild -version

# Check available simulators
flutter devices | grep ios
```

### 2. Dependency Health Check
```bash
# Check for outdated pods
cd ios && pod outdated

# Audit Flutter dependencies
flutter pub deps
flutter pub outdated
```

### 3. Code Analysis
```bash
# Run comprehensive analysis
flutter analyze --no-fatal-infos

# Count critical errors (should be 0)
flutter analyze --no-fatal-infos 2>&1 | grep "error •" | wc -l
```

## 🔧 Post-Change Verification Process

After making any code changes, always run this sequence:

### Step 1: Static Analysis
```bash
# Verify no compilation errors
flutter analyze --no-fatal-infos 2>&1 | grep "error •"

# If errors found, fix them before proceeding
```

### Step 2: Dependency Updates
```bash
# Clean and refresh dependencies
flutter clean
flutter pub get

# Update iOS pods if needed
cd ios && pod install --repo-update
```

### Step 3: Build Verification
```bash
# Test compilation without full build
flutter build ios --debug --no-codesign --simulator --dry-run

# If successful, run actual build test
flutter build ios --debug --no-codesign --simulator -d [DEVICE_ID]
```

## 🎯 Common Error Patterns & Solutions

### WatchConnectivity API Issues
**Problem**: Package API version mismatches
**Solution**: 
- Check package documentation for correct API methods
- Update service code to use available methods
- Consider package version changes if needed

**Example Fix**:
```dart
// Wrong (package v0.2.1+1)
await _watchConnectivity!.activateSession();

// Correct (package v0.2.1+1)
// Session auto-activates on instantiation
```

### Firebase/CocoaPods Conflicts
**Problem**: BoringSSL-GRPC compilation errors
**Solution**:
- Update Firebase SDK to latest compatible version
- Clean Pods directory and reinstall
- Check Xcode compatibility

**Commands**:
```bash
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
```

### Test File Structure Issues
**Problem**: Unexpected bracket/semicolon errors
**Solution**:
- Verify proper nesting structure
- Check for missing closing braces
- Ensure imports have no leading whitespace

**Check**:
```bash
# Count braces to verify balance
grep -c "{" test/file.dart && grep -c "}" test/file.dart
```

### Health Package Compatibility
**Problem**: Undefined enum constants (VO2_MAX, etc.)
**Solution**:
- Check health package version for available constants
- Use conditional compilation for newer features
- Provide fallback values for unavailable constants

## 🛠 XcodeBuildMCP Integration

For comprehensive build verification, use XcodeBuildMCP when available:

```bash
# Verify project structure
xcodebuild -list -workspace ios/Runner.xcworkspace

# Test build without full compilation
xcodebuild -workspace ios/Runner.xcworkspace -scheme Runner -sdk iphonesimulator -configuration Debug -allowProvisioningUpdates build-for-testing
```

## 📋 CI/CD Integration Points

### Pre-commit Hooks
Add to `.githooks/pre-commit`:
```bash
#!/bin/bash
# Run Flutter analyze
flutter analyze --no-fatal-infos
if [ $? -ne 0 ]; then
    echo "❌ Flutter analyze failed. Please fix errors before committing."
    exit 1
fi

# Count critical errors
ERROR_COUNT=$(flutter analyze --no-fatal-infos 2>&1 | grep "error •" | wc -l)
if [ $ERROR_COUNT -gt 0 ]; then
    echo "❌ Found $ERROR_COUNT critical errors. Please fix before committing."
    exit 1
fi

echo "✅ Pre-commit checks passed"
```

### GitHub Actions Workflow
```yaml
- name: iOS Build Test
  run: |
    flutter clean
    flutter pub get
    cd ios && pod install
    flutter build ios --debug --no-codesign --simulator
```

## 🔍 Troubleshooting Quick Reference

### Build Takes Too Long
- **Cause**: Large dependency tree (87+ targets)
- **Solution**: Use incremental builds, cache Pods directory
- **Command**: `flutter build ios --debug --no-codesign --simulator --no-pub`

### Simulator Not Found
- **Cause**: watchOS companion requires specific device
- **Solution**: List devices and specify explicitly
- **Command**: `flutter devices && flutter build ios -d [DEVICE_ID]`

### Memory Issues During Build
- **Cause**: Large Firebase/gRPC dependency compilation
- **Solution**: Increase Xcode build memory, close other apps
- **Check**: Activity Monitor for Xcode memory usage

## ✅ Success Criteria

A healthy iOS build setup should achieve:

- ✅ Zero `flutter analyze` critical errors
- ✅ All dependencies up to date and compatible
- ✅ Successful XcodeBuildMCP verification
- ✅ iOS simulator build completes within 10 minutes
- ✅ No deprecated API warnings (or documented plan to fix)

## 🚀 Automated Monitoring

Consider implementing:

1. **Daily dependency health checks**
2. **Automated iOS build testing on PRs**
3. **Xcode version compatibility alerts**
4. **Package version update notifications**

## 📝 Version Compatibility Matrix

| Component | Current Version | Tested Compatible | Notes |
|-----------|----------------|-------------------|-------|
| Flutter | 3.32.5 | ✅ | Latest stable |
| Xcode | 16.3 | ✅ | iOS 18 SDK |
| Firebase | 11.15.0 | ✅ | Latest compatible |
| watch_connectivity | 0.2.1+1 | ⚠️ | API limitations |
| health | 10.2.0 | ✅ | Missing some enums |

## 🔄 Maintenance Schedule

- **Weekly**: Check for Flutter/Xcode updates
- **Monthly**: Update non-breaking dependencies
- **Quarterly**: Review and update major dependencies
- **Before releases**: Full dependency audit and iOS build test

---

**Last Updated**: January 2025
**Maintained by**: PulsePath Development Team