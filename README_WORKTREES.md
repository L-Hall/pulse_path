# Git Worktrees for 4x Parallel Development

This document provides a comprehensive guide to using Git worktrees for parallel development on the PulsePath project.

## Overview

Git worktrees enable simultaneous development across multiple feature branches, allowing the team to work on 4+ features in parallel without context switching or merge conflicts.

## Current Worktree Setup

### Active Worktrees

| Worktree Name | Branch | Purpose | Port Range |
|---------------|---------|---------|------------|
| `ble_integration` | `ble-integration` | BLE wearable integration (Phase 6) | 8051/8101 |
| `cloud_sync` | `cloud-sync` | Firebase cloud synchronization (Phase 7) | 8052/8102 |
| `subscription_paywall` | `subscription-paywall` | Monetization and payments (Phase 8) | 8053/8103 |
| `adaptive_pacing` | `adaptive-pacing` | Chronic illness features (Phase 9) | 8054/8104 |
| `testing_qa` | `testing-qa` | Parallel testing environment | 8055/8105 |

### Directory Structure

```
pulse_path/                    # Main repository (main branch)
├── worktrees/
│   ├── ble_integration/       # BLE development environment
│   ├── cloud_sync/           # Cloud sync development environment
│   ├── subscription_paywall/ # Payment system development environment
│   ├── adaptive_pacing/      # Chronic illness features environment
│   └── testing_qa/          # Testing and QA environment
├── dev.sh                   # Worktree management script
├── setup_terminals.sh       # Terminal automation script
└── pulse_path.code-workspace # VSCode multi-root workspace
```

## Quick Start Guide

### 1. List Current Worktrees

```bash
./dev.sh list-worktrees
```

### 2. Set Up a New Worktree

```bash
./dev.sh setup-worktree ble_integration
```

### 3. Start Development in a Worktree

```bash
./dev.sh start-worktree ble_integration
```

### 4. Run Flutter Commands in a Worktree

```bash
./dev.sh flutter-run ble_integration
./dev.sh flutter-test ble_integration
./dev.sh flutter-build ble_integration web
```

## Terminal Setup for 4x Parallel Development

Use the provided terminal setup script to automatically configure 4 terminal windows:

```bash
./setup_terminals.sh
```

This creates:
- **Terminal 1**: Main repository (for coordination)
- **Terminal 2**: Active feature development (e.g., ble_integration)
- **Terminal 3**: Testing environment (testing_qa worktree)
- **Terminal 4**: Build/deployment tasks

## VSCode Multi-Root Workspace

Open the multi-root workspace for development across all worktrees:

```bash
code pulse_path.code-workspace
```

Benefits:
- See all worktrees simultaneously in the sidebar
- Search across all workspaces
- Debug configurations for each worktree
- Integrated terminals for each workspace

## Development Workflow

### Typical 4x Parallel Workflow

1. **Feature Development** (Terminal 2):
   ```bash
   cd worktrees/ble_integration
   flutter run
   # Develop BLE features with hot reload
   ```

2. **Continuous Testing** (Terminal 3):
   ```bash
   cd worktrees/testing_qa
   flutter test --watch
   # Run tests continuously as you develop
   ```

3. **Build Verification** (Terminal 4):
   ```bash
   cd worktrees/cloud_sync
   flutter build web
   flutter analyze
   ```

4. **Coordination** (Terminal 1):
   ```bash
   ./dev.sh sync-worktrees  # Sync shared files
   git status               # Monitor main branch
   ```

### File Synchronization

Shared files are automatically synced across worktrees:
- `pubspec.yaml` / `pubspec.lock`
- `analysis_options.yaml`
- `CLAUDE.md`
- `scripts/` directory

Run manual sync when needed:
```bash
./dev.sh sync-worktrees
```

## Advanced Commands

### Worktree Management

```bash
# Clean all worktree build artifacts
./dev.sh clean-worktrees

# Stop all services for a worktree
./dev.sh stop-worktree ble_integration

# Remove a worktree (with confirmation)
./dev.sh remove-worktree old_feature

# Show detailed git worktree status
git worktree list
```

### Development Commands

```bash
# Run Flutter commands in specific worktree
./dev.sh flutter-run ble_integration --debug
./dev.sh flutter-build cloud_sync apk --release
./dev.sh flutter-test testing_qa --coverage

# Start with specific port
cd worktrees/ble_integration
flutter run -d chrome --web-port=8051
```

## Best Practices

### 1. Branch Naming Convention
- Use kebab-case: `ble-integration`, `cloud-sync`
- Match worktree directory names for consistency

### 2. Commit Strategy
- Commit frequently in feature branches
- Keep main branch stable
- Use descriptive commit messages with feature context

### 3. Testing Strategy
- Use `testing_qa` worktree for cross-feature testing
- Run `flutter analyze` before merging
- Maintain test coverage ≥80%

### 4. Port Management
- Each worktree has dedicated port range (see table above)
- Avoid port conflicts by using assigned ranges
- Check port usage: `lsof -i :8051`

### 5. File Management
- Keep feature-specific files in respective worktrees
- Use shared files only for project-wide changes
- Run `sync-worktrees` after updating shared files

## Troubleshooting

### Common Issues

**Port Already in Use:**
```bash
lsof -i :8051                    # Check what's using the port
kill -TERM $(lsof -ti :8051)     # Kill process on port
./dev.sh stop-worktree ble_integration  # Use script to stop
```

**Worktree Not Found:**
```bash
./dev.sh setup-worktree ble_integration  # Re-setup if needed
git worktree list                         # Verify worktrees
```

**Flutter Dependencies Out of Sync:**
```bash
./dev.sh sync-worktrees          # Sync shared files
cd worktrees/ble_integration
flutter clean && flutter pub get  # Clean and reinstall
```

**Git Branch Issues:**
```bash
git branch -a                    # List all branches
git worktree prune              # Clean up orphaned worktrees
```

## Performance Tips

### Memory Optimization
- Close unused worktree terminals
- Use `flutter clean` in inactive worktrees
- Monitor system resources with multiple Flutter instances

### Build Optimization
- Use `flutter build web` for faster web builds
- Share build cache between worktrees when possible
- Use `--debug` flag for development builds

### Network Optimization
- Different ports prevent conflicts
- Use localhost for development
- Consider using --web-hostname for network access

## Team Collaboration

### Sharing Worktree Setup
1. Each team member runs: `./dev.sh setup-worktree <feature_name>`
2. Shared files automatically sync via the script
3. Use the same port assignments for consistency

### Code Reviews
- Review code within specific worktrees
- Use GitHub's branch comparison for feature branches
- Merge feature branches to main when ready

### CI/CD Integration
- GitHub Actions can test each worktree branch
- Parallel builds for faster CI/CD pipeline
- Deploy specific features independently

## Integration with Development Tools

### IDE Setup
- **VSCode**: Use `pulse_path.code-workspace`
- **Android Studio**: Open each worktree as separate project
- **Xcode**: iOS builds work from any worktree

### Debugging
- Each worktree can debug independently
- Use different device connections per worktree
- Monitor logs separately per feature

### Version Control
- Each worktree maintains its own git status
- Branch switching affects only that worktree
- Main repository coordinates overall project state

## Future Enhancements

### Planned Improvements
- Automated worktree setup on project clone
- Integration with GitHub Actions for parallel CI
- Enhanced terminal automation scripts
- Cross-worktree debugging tools

### Extensibility
- Add new worktrees for additional features
- Customize port ranges for team preferences
- Integrate with project management tools

---

## Support

For issues with the worktree setup:
1. Check this documentation first
2. Run `./dev.sh --help` for command reference
3. Review git worktree status: `git worktree list`
4. Check project CLAUDE.md for development guidelines

**Happy parallel development!** 🚀