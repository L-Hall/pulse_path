#!/bin/bash

# PulsePath Development Script with Git Worktree Support
# Enables parallel development across multiple feature tracks

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKTREE_DIR="$PROJECT_ROOT/worktrees"

# Worktree configuration (using functions for compatibility)
get_worktree_branches() {
    echo "ble_integration ble-integration cloud_sync cloud-sync subscription_paywall subscription-paywall adaptive_pacing adaptive-pacing testing_qa testing-qa"
}

get_worktree_ports() {
    case "$1" in
        "ble_integration") echo "8051 8101" ;;
        "cloud_sync") echo "8052 8102" ;;
        "subscription_paywall") echo "8053 8103" ;;
        "adaptive_pacing") echo "8054 8104" ;;
        "testing_qa") echo "8055 8105" ;;
        *) echo "" ;;
    esac
}

get_worktree_branch() {
    case "$1" in
        "ble_integration") echo "ble-integration" ;;
        "cloud_sync") echo "cloud-sync" ;;
        "subscription_paywall") echo "subscription-paywall" ;;
        "adaptive_pacing") echo "adaptive-pacing" ;;
        "testing_qa") echo "testing-qa" ;;
        *) echo "" ;;
    esac
}

get_all_worktrees() {
    echo "ble_integration cloud_sync subscription_paywall adaptive_pacing testing_qa"
}

# Shared files that should be synced across worktrees
SHARED_FILES=(
    "pubspec.yaml"
    "pubspec.lock"
    "analysis_options.yaml"
    "CLAUDE.md"
    "scripts/"
)

print_usage() {
    echo -e "${BLUE}PulsePath Development Script${NC}"
    echo ""
    echo "Usage: $0 [command] [options]"
    echo ""
    echo "Worktree Commands:"
    echo "  list-worktrees              List all git worktrees"
    echo "  setup-worktree <name>       Set up a new worktree environment"
    echo "  start-worktree <name>       Start services for a worktree"
    echo "  stop-worktree <name>        Stop services for a worktree"
    echo "  sync-worktrees              Sync shared files across all worktrees"
    echo "  clean-worktrees             Clean all worktree environments"
    echo "  remove-worktree <name>      Remove a worktree"
    echo ""
    echo "Available Worktrees:"
    echo "  ble_integration             BLE wearable integration (Phase 6)"
    echo "  cloud_sync                  Firebase cloud synchronization (Phase 7)"
    echo "  subscription_paywall        Monetization and payments (Phase 8)"
    echo "  adaptive_pacing             Chronic illness features (Phase 9)"
    echo "  testing_qa                  Parallel testing environment"
    echo ""
    echo "Development Commands:"
    echo "  flutter-run <name>          Run Flutter app in worktree"
    echo "  flutter-build <name>        Build Flutter app in worktree"
    echo "  flutter-test <name>         Run tests in worktree"
    echo ""
    echo "Examples:"
    echo "  $0 setup-worktree ble_integration"
    echo "  $0 start-worktree ble_integration"
    echo "  $0 flutter-run ble_integration"
    echo "  $0 sync-worktrees"
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a git repository"
        exit 1
    fi
}

get_worktree_config() {
    local worktree_name=$1
    local branch=$(get_worktree_branch "$worktree_name")
    local ports=$(get_worktree_ports "$worktree_name")
    
    if [[ -z "$branch" ]] || [[ -z "$ports" ]]; then
        print_error "Unknown worktree: $worktree_name"
        print_info "Available worktrees: $(get_all_worktrees)"
        exit 1
    fi
    echo "$branch $ports"
}

list_worktrees() {
    print_info "Git Worktrees Status:"
    git worktree list || print_warning "No worktrees found"
    
    echo ""
    print_info "Available Worktree Configurations:"
    for name in $(get_all_worktrees); do
        config=($(get_worktree_config "$name"))
        branch=${config[0]}
        flutter_port=${config[1]}
        backend_port=${config[2]}
        
        if [[ -d "$WORKTREE_DIR/$name" ]]; then
            status="${GREEN}✓ EXISTS${NC}"
        else
            status="${YELLOW}✗ NOT SETUP${NC}"
        fi
        
        echo -e "  $name: $status (branch: $branch, ports: $flutter_port/$backend_port)"
    done
}

setup_worktree() {
    local worktree_name=$1
    if [[ -z "$worktree_name" ]]; then
        print_error "Worktree name required"
        print_usage
        exit 1
    fi
    
    local config=($(get_worktree_config "$worktree_name"))
    local branch=${config[0]}
    local flutter_port=${config[1]}
    local backend_port=${config[2]}
    
    local worktree_path="$WORKTREE_DIR/$worktree_name"
    
    print_info "Setting up worktree: $worktree_name"
    print_info "Branch: $branch"
    print_info "Path: $worktree_path"
    print_info "Flutter port: $flutter_port"
    print_info "Backend port: $backend_port"
    
    # Create worktrees directory if it doesn't exist
    mkdir -p "$WORKTREE_DIR"
    
    # Check if worktree already exists
    if [[ -d "$worktree_path" ]]; then
        print_warning "Worktree already exists at $worktree_path"
        return 0
    fi
    
    # Create branch if it doesn't exist
    if ! git show-ref --verify --quiet refs/heads/$branch; then
        print_info "Creating branch: $branch"
        git branch "$branch"
    fi
    
    # Add worktree
    print_info "Adding worktree..."
    git worktree add "$worktree_path" "$branch"
    
    # Copy essential files to worktree
    print_info "Copying shared files..."
    for file in "${SHARED_FILES[@]}"; do
        if [[ -e "$PROJECT_ROOT/$file" ]]; then
            if [[ -d "$PROJECT_ROOT/$file" ]]; then
                cp -r "$PROJECT_ROOT/$file" "$worktree_path/"
            else
                cp "$PROJECT_ROOT/$file" "$worktree_path/"
            fi
        fi
    done
    
    # Initialize Flutter dependencies in worktree
    print_info "Initializing Flutter dependencies..."
    cd "$worktree_path"
    flutter pub get || print_warning "Failed to run flutter pub get"
    
    # Create worktree-specific configuration
    cat > "$worktree_path/.env.worktree" <<EOF
WORKTREE_NAME=$worktree_name
WORKTREE_BRANCH=$branch
FLUTTER_PORT=$flutter_port
BACKEND_PORT=$backend_port
EOF
    
    cd "$PROJECT_ROOT"
    print_success "Worktree '$worktree_name' set up successfully!"
    print_info "Path: $worktree_path"
    print_info "To start working: cd $worktree_path"
}

start_worktree() {
    local worktree_name=$1
    if [[ -z "$worktree_name" ]]; then
        print_error "Worktree name required"
        exit 1
    fi
    
    local worktree_path="$WORKTREE_DIR/$worktree_name"
    if [[ ! -d "$worktree_path" ]]; then
        print_error "Worktree not found: $worktree_path"
        print_info "Run: $0 setup-worktree $worktree_name"
        exit 1
    fi
    
    local config=($(get_worktree_config "$worktree_name"))
    local flutter_port=${config[1]}
    
    print_info "Starting Flutter for worktree: $worktree_name"
    print_info "Port: $flutter_port"
    
    cd "$worktree_path"
    
    # Check if port is already in use
    if lsof -Pi ":$flutter_port" -sTCP:LISTEN -t >/dev/null 2>&1; then
        print_warning "Port $flutter_port is already in use"
        print_info "To see what's using the port: lsof -i :$flutter_port"
    fi
    
    # Start Flutter on specified port
    print_info "Starting Flutter development server..."
    flutter run -d chrome --web-port="$flutter_port" --web-hostname=localhost
}

stop_worktree() {
    local worktree_name=$1
    if [[ -z "$worktree_name" ]]; then
        print_error "Worktree name required"
        exit 1
    fi
    
    local config=($(get_worktree_config "$worktree_name"))
    local flutter_port=${config[1]}
    local backend_port=${config[2]}
    
    print_info "Stopping services for worktree: $worktree_name"
    
    # Kill processes on Flutter port
    local flutter_pid=$(lsof -ti :$flutter_port)
    if [[ -n "$flutter_pid" ]]; then
        print_info "Stopping Flutter server on port $flutter_port (PID: $flutter_pid)"
        kill -TERM $flutter_pid 2>/dev/null || true
    fi
    
    # Kill processes on backend port
    local backend_pid=$(lsof -ti :$backend_port)
    if [[ -n "$backend_pid" ]]; then
        print_info "Stopping backend server on port $backend_port (PID: $backend_pid)"
        kill -TERM $backend_pid 2>/dev/null || true
    fi
    
    print_success "Services stopped for worktree: $worktree_name"
}

sync_worktrees() {
    print_info "Syncing shared files across all worktrees..."
    
    for worktree_name in $(get_all_worktrees); do
        local worktree_path="$WORKTREE_DIR/$worktree_name"
        if [[ -d "$worktree_path" ]]; then
            print_info "Syncing to: $worktree_name"
            
            for file in "${SHARED_FILES[@]}"; do
                if [[ -e "$PROJECT_ROOT/$file" ]]; then
                    if [[ -d "$PROJECT_ROOT/$file" ]]; then
                        cp -r "$PROJECT_ROOT/$file" "$worktree_path/"
                    else
                        cp "$PROJECT_ROOT/$file" "$worktree_path/"
                    fi
                fi
            done
            
            # Run flutter pub get in each worktree
            cd "$worktree_path"
            flutter pub get > /dev/null 2>&1 || print_warning "Failed to run flutter pub get in $worktree_name"
        fi
    done
    
    cd "$PROJECT_ROOT"
    print_success "Sync completed!"
}

clean_worktrees() {
    print_info "Cleaning all worktree environments..."
    
    # Stop all services first
    for worktree_name in $(get_all_worktrees); do
        if [[ -d "$WORKTREE_DIR/$worktree_name" ]]; then
            stop_worktree "$worktree_name" 2>/dev/null || true
        fi
    done
    
    # Clean build artifacts
    for worktree_name in $(get_all_worktrees); do
        local worktree_path="$WORKTREE_DIR/$worktree_name"
        if [[ -d "$worktree_path" ]]; then
            print_info "Cleaning: $worktree_name"
            cd "$worktree_path"
            flutter clean > /dev/null 2>&1 || true
            rm -rf build/ .dart_tool/ || true
        fi
    done
    
    cd "$PROJECT_ROOT"
    print_success "All worktrees cleaned!"
}

remove_worktree() {
    local worktree_name=$1
    if [[ -z "$worktree_name" ]]; then
        print_error "Worktree name required"
        exit 1
    fi
    
    local worktree_path="$WORKTREE_DIR/$worktree_name"
    
    if [[ ! -d "$worktree_path" ]]; then
        print_warning "Worktree not found: $worktree_path"
        return 0
    fi
    
    print_warning "This will remove the worktree: $worktree_name"
    read -p "Are you sure? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Cancelled"
        return 0
    fi
    
    # Stop services first
    stop_worktree "$worktree_name" 2>/dev/null || true
    
    # Remove worktree
    print_info "Removing worktree: $worktree_name"
    git worktree remove "$worktree_path" --force
    
    print_success "Worktree '$worktree_name' removed successfully!"
}

flutter_run() {
    local worktree_name=$1
    if [[ -z "$worktree_name" ]]; then
        print_error "Worktree name required"
        exit 1
    fi
    
    local worktree_path="$WORKTREE_DIR/$worktree_name"
    if [[ ! -d "$worktree_path" ]]; then
        print_error "Worktree not found: $worktree_path"
        exit 1
    fi
    
    cd "$worktree_path"
    print_info "Running Flutter in worktree: $worktree_name"
    flutter run "${@:2}"
}

flutter_build() {
    local worktree_name=$1
    if [[ -z "$worktree_name" ]]; then
        print_error "Worktree name required"
        exit 1
    fi
    
    local worktree_path="$WORKTREE_DIR/$worktree_name"
    if [[ ! -d "$worktree_path" ]]; then
        print_error "Worktree not found: $worktree_path"
        exit 1
    fi
    
    cd "$worktree_path"
    print_info "Building Flutter in worktree: $worktree_name"
    flutter build "${@:2}"
}

flutter_test() {
    local worktree_name=$1
    if [[ -z "$worktree_name" ]]; then
        print_error "Worktree name required"
        exit 1
    fi
    
    local worktree_path="$WORKTREE_DIR/$worktree_name"
    if [[ ! -d "$worktree_path" ]]; then
        print_error "Worktree not found: $worktree_path"
        exit 1
    fi
    
    cd "$worktree_path"
    print_info "Running tests in worktree: $worktree_name"
    flutter test "${@:2}"
}

# Main command dispatcher
main() {
    check_git_repo
    
    case "${1:-}" in
        "list-worktrees")
            list_worktrees
            ;;
        "setup-worktree")
            setup_worktree "$2"
            ;;
        "start-worktree")
            start_worktree "$2"
            ;;
        "stop-worktree")
            stop_worktree "$2"
            ;;
        "sync-worktrees")
            sync_worktrees
            ;;
        "clean-worktrees")
            clean_worktrees
            ;;
        "remove-worktree")
            remove_worktree "$2"
            ;;
        "flutter-run")
            flutter_run "$2" "${@:3}"
            ;;
        "flutter-build")
            flutter_build "$2" "${@:3}"
            ;;
        "flutter-test")
            flutter_test "$2" "${@:3}"
            ;;
        "help"|"-h"|"--help"|"")
            print_usage
            ;;
        *)
            print_error "Unknown command: $1"
            print_usage
            exit 1
            ;;
    esac
}

main "$@"