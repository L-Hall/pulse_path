# PulsePath Testing Infrastructure

This directory contains comprehensive testing infrastructure for the PulsePath app, designed to support parallel feature development across multiple Git worktrees.

## Test Structure

### 📁 `/support/`
- **`test_utils.dart`** - Comprehensive test utilities and base classes
- **`mock_data_service.dart`** - Realistic mock data generation for all features

### 📁 `/features/`
- **`/hrv/`** - Unit tests for HRV calculation and scoring services
- **`/ble/`** - Unit tests for BLE device management and quality services

### 📁 `/integration/`
- **`app_integration_test.dart`** - End-to-end integration tests

### 📁 `/performance/`
- **`performance_test_suite.dart`** - Performance benchmarks and monitoring tests

## Test Categories

### 🔧 Unit Tests
- Pure business logic testing
- Service and repository layer testing
- Algorithm verification (HRV calculations)
- Error handling scenarios

### 🧩 Widget Tests
- UI component testing
- User interaction flows
- State management verification
- Visual regression testing

### 🏗️ Integration Tests
- Complete user journeys
- Cross-feature interactions
- Database operations
- BLE device connectivity

### ⚡ Performance Tests
- Service initialization times
- HRV calculation performance
- Memory usage monitoring
- UI responsiveness benchmarks

## Running Tests

### All Tests
```bash
flutter test
```

### Specific Test Categories
```bash
# Unit tests only
flutter test test/features/

# Widget tests only
flutter test test/widget_test.dart

# Integration tests only
flutter test integration_test/

# Performance tests only
flutter test test/performance/
```

### Coverage Report
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Mock Data Service

The `MockDataService` provides realistic test data for:

- **HRV Readings** - Complete with realistic RR intervals and calculated metrics
- **Dashboard Data** - Time series data with trend analysis
- **BLE Devices** - Simulated heart rate monitors with various states
- **Error Scenarios** - Comprehensive error conditions for testing
- **User Profiles** - Different user types (athlete, chronic illness, elderly)
- **Edge Cases** - Boundary conditions and unusual scenarios

## Test Utilities

The `TestUtils` class provides:

- **Mock Service Creation** - Pre-configured mocks for all services
- **Test Environment Setup** - Clean initialization and teardown
- **Performance Verification** - Built-in benchmarking helpers
- **Error Testing** - Exception verification utilities
- **Widget Helpers** - Common UI testing patterns

## Base Test Classes

### `BaseUnitTest`
```dart
class MyServiceTest extends BaseUnitTest {
  late MyService service;
  
  @override
  void setUpUnitTest() {
    super.setUpUnitTest();
    service = MyService();
  }
}
```

### `BaseWidgetTest`
```dart
class MyWidgetTest extends BaseWidgetTest {
  Future<void> testMyWidget() async {
    await pumpTestWidget(tester, MyWidget());
    testUtils.verifyTextExists(tester, 'Expected Text');
  }
}
```

### `BaseIntegrationTest`
```dart
class MyIntegrationTest extends BaseIntegrationTest {
  Future<void> testCompleteFlow() async {
    testUtils.setupTestScenario('experienced_user');
    // Test complete user journey
  }
}
```

## Performance Benchmarks

All tests verify against defined performance thresholds:

- **App Startup**: < 3 seconds
- **Widget Build**: < 16ms (60fps)
- **HRV Calculation**: < 500ms
- **Database Query**: < 100ms
- **BLE Connection**: < 10 seconds

## Test Scenarios

### Realistic User Scenarios
- **First-time user** - Empty data state
- **Experienced user** - Rich historical data
- **BLE connection success** - Successful device pairing
- **BLE connection failure** - Device connectivity issues
- **Database errors** - Storage layer failures

### Edge Cases
- Minimum viable HRV readings (30 RR intervals)
- Maximum realistic readings (300+ intervals)
- Poor quality data scenarios
- Network connectivity issues
- Permission denial scenarios

## CI/CD Integration

This testing infrastructure supports:
- Automated test execution in GitHub Actions
- Performance regression detection
- Coverage reporting
- Test result aggregation across worktrees

## Development Workflow

1. **Feature Development** - Write tests first in your worktree
2. **Mock Data** - Use `MockDataService` for realistic test scenarios
3. **Performance** - Verify all operations meet benchmarks
4. **Integration** - Test cross-feature interactions
5. **Merge** - Ensure all tests pass before merging to main

## Troubleshooting

### Common Issues

**Test Timeout**
```dart
await testUtils.waitForCondition(
  () => condition,
  timeout: Duration(seconds: 10),
);
```

**Mock Setup**
```dart
testUtils.setupTestScenario('experienced_user');
final mockRepo = testUtils.createMockHrvRepository(hasData: true);
```

**Performance Failures**
```dart
await testUtils.verifyPerformance(
  () async => myOperation(),
  Duration(milliseconds: 100),
  operationName: 'My Operation',
);
```

This testing infrastructure ensures high code quality and supports rapid parallel development across all PulsePath features.