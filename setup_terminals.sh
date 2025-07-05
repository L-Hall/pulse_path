#!/bin/bash

# PulsePath Terminal Setup for 4x Parallel Development
# Automatically configures 4 terminal windows for simultaneous development

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Project configuration
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKTREE_DIR="$PROJECT_ROOT/worktrees"

# Terminal setup configuration
TERMINALS_CONFIG=(
    "main|$PROJECT_ROOT|Main Repository - Coordination & Git Management"
    "ble_integration|$WORKTREE_DIR/ble_integration|BLE Integration Development (Phase 6)"
    "testing_qa|$WORKTREE_DIR/testing_qa|Continuous Testing & QA"
    "cloud_sync|$WORKTREE_DIR/cloud_sync|Cloud Sync Development (Phase 7)"
)

print_usage() {
    echo -e "${BLUE}PulsePath Terminal Setup${NC}"
    echo ""
    echo "Usage: $0 [command] [options]"
    echo ""
    echo "Commands:"
    echo "  setup              Set up 4 terminals for parallel development"
    echo "  iterm              Set up using iTerm2 (macOS)"
    echo "  terminal           Set up using Terminal.app (macOS)"
    echo "  tmux               Set up using tmux (cross-platform)"
    echo "  list               List terminal configurations"
    echo "  help               Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 setup           # Auto-detect and set up terminals"
    echo "  $0 iterm           # Force iTerm2 setup"
    echo "  $0 tmux            # Force tmux setup"
}

detect_terminal() {
    if command -v osascript >/dev/null 2>&1; then
        if pgrep -f "iTerm" >/dev/null 2>&1; then
            echo "iterm"
        else
            echo "terminal"
        fi
    elif command -v tmux >/dev/null 2>&1; then
        echo "tmux"
    else
        echo "basic"
    fi
}

setup_iterm() {
    print_info "Setting up iTerm2 terminals for parallel development..."
    
    # Check if iTerm2 is running
    if ! pgrep -f "iTerm" >/dev/null 2>&1; then
        print_info "Starting iTerm2..."
        open -a iTerm
        sleep 2
    fi
    
    # Create iTerm2 script
    cat > /tmp/iterm_setup.scpt << 'EOF'
tell application "iTerm"
    -- Create new window
    create window with default profile
    
    -- Configure first pane (main repository)
    tell current session of current window
        write text "cd PROJECT_ROOT"
        write text "echo 'Terminal 1: Main Repository - Coordination & Git Management'"
        write text "echo 'Commands: ./dev.sh list-worktrees, git status, ./dev.sh sync-worktrees'"
        write text "clear"
    end tell
    
    -- Split horizontally for second pane (BLE integration)
    tell current session of current window
        split horizontally with default profile
    end tell
    
    tell last session of current window
        write text "cd PROJECT_ROOT/worktrees/ble_integration"
        write text "echo 'Terminal 2: BLE Integration Development (Phase 6)'"
        write text "echo 'Commands: flutter run, flutter test, flutter build'"
        write text "clear"
    end tell
    
    -- Split first pane vertically for third pane (testing)
    tell first session of current window
        split vertically with default profile
    end tell
    
    tell session 2 of current window
        write text "cd PROJECT_ROOT/worktrees/testing_qa"
        write text "echo 'Terminal 3: Continuous Testing & QA'"
        write text "echo 'Commands: flutter test --watch, flutter analyze'"
        write text "clear"
    end tell
    
    -- Split second pane vertically for fourth pane (cloud sync)
    tell last session of current window
        split vertically with default profile
    end tell
    
    tell last session of current window
        write text "cd PROJECT_ROOT/worktrees/cloud_sync"
        write text "echo 'Terminal 4: Cloud Sync Development (Phase 7)'"
        write text "echo 'Commands: flutter run, flutter build web'"
        write text "clear"
    end tell
    
    -- Return focus to first terminal
    select first session of current window
end tell
EOF
    
    # Replace PROJECT_ROOT in the script
    sed -i '' "s|PROJECT_ROOT|$PROJECT_ROOT|g" /tmp/iterm_setup.scpt
    
    # Execute the script
    osascript /tmp/iterm_setup.scpt
    
    # Clean up
    rm /tmp/iterm_setup.scpt
    
    print_success "iTerm2 terminals configured successfully!"
}

setup_terminal_app() {
    print_info "Setting up Terminal.app tabs for parallel development..."
    
    # Create Terminal.app script
    cat > /tmp/terminal_setup.scpt << 'EOF'
tell application "Terminal"
    activate
    
    -- Create new window for main repository
    set mainWindow to do script "cd PROJECT_ROOT; echo 'Terminal 1: Main Repository - Coordination & Git Management'; echo 'Commands: ./dev.sh list-worktrees, git status, ./dev.sh sync-worktrees'; clear"
    
    -- Create tab for BLE integration
    tell mainWindow
        do script "cd PROJECT_ROOT/worktrees/ble_integration; echo 'Terminal 2: BLE Integration Development (Phase 6)'; echo 'Commands: flutter run, flutter test, flutter build'; clear" in (do script "")
    end tell
    
    -- Create tab for testing
    tell mainWindow
        do script "cd PROJECT_ROOT/worktrees/testing_qa; echo 'Terminal 3: Continuous Testing & QA'; echo 'Commands: flutter test --watch, flutter analyze'; clear" in (do script "")
    end tell
    
    -- Create tab for cloud sync
    tell mainWindow
        do script "cd PROJECT_ROOT/worktrees/cloud_sync; echo 'Terminal 4: Cloud Sync Development (Phase 7)'; echo 'Commands: flutter run, flutter build web'; clear" in (do script "")
    end tell
    
    -- Select first tab
    set selected tab of mainWindow to tab 1 of mainWindow
end tell
EOF
    
    # Replace PROJECT_ROOT in the script
    sed -i '' "s|PROJECT_ROOT|$PROJECT_ROOT|g" /tmp/terminal_setup.scpt
    
    # Execute the script
    osascript /tmp/terminal_setup.scpt
    
    # Clean up
    rm /tmp/terminal_setup.scpt
    
    print_success "Terminal.app tabs configured successfully!"
}

setup_tmux() {
    print_info "Setting up tmux session for parallel development..."
    
    local session_name="pulsepath-dev"
    
    # Check if session already exists
    if tmux has-session -t "$session_name" 2>/dev/null; then
        print_warning "Tmux session '$session_name' already exists. Attaching..."
        tmux attach-session -t "$session_name"
        return 0
    fi
    
    # Create new tmux session
    tmux new-session -d -s "$session_name" -c "$PROJECT_ROOT"
    
    # Set up first window (main repository)
    tmux send-keys -t "$session_name:0" "echo 'Terminal 1: Main Repository - Coordination & Git Management'" Enter
    tmux send-keys -t "$session_name:0" "echo 'Commands: ./dev.sh list-worktrees, git status, ./dev.sh sync-worktrees'" Enter
    tmux send-keys -t "$session_name:0" "clear" Enter
    tmux rename-window -t "$session_name:0" "main"
    
    # Create second window (BLE integration)
    tmux new-window -t "$session_name" -c "$WORKTREE_DIR/ble_integration" -n "ble"
    tmux send-keys -t "$session_name:ble" "echo 'Terminal 2: BLE Integration Development (Phase 6)'" Enter
    tmux send-keys -t "$session_name:ble" "echo 'Commands: flutter run, flutter test, flutter build'" Enter
    tmux send-keys -t "$session_name:ble" "clear" Enter
    
    # Create third window (testing)
    tmux new-window -t "$session_name" -c "$WORKTREE_DIR/testing_qa" -n "testing"
    tmux send-keys -t "$session_name:testing" "echo 'Terminal 3: Continuous Testing & QA'" Enter
    tmux send-keys -t "$session_name:testing" "echo 'Commands: flutter test --watch, flutter analyze'" Enter
    tmux send-keys -t "$session_name:testing" "clear" Enter
    
    # Create fourth window (cloud sync)
    tmux new-window -t "$session_name" -c "$WORKTREE_DIR/cloud_sync" -n "cloud"
    tmux send-keys -t "$session_name:cloud" "echo 'Terminal 4: Cloud Sync Development (Phase 7)'" Enter
    tmux send-keys -t "$session_name:cloud" "echo 'Commands: flutter run, flutter build web'" Enter
    tmux send-keys -t "$session_name:cloud" "clear" Enter
    
    # Select first window
    tmux select-window -t "$session_name:main"
    
    print_success "Tmux session '$session_name' created successfully!"
    print_info "To attach: tmux attach-session -t $session_name"
    print_info "To detach: Ctrl-b d"
    print_info "To switch windows: Ctrl-b 0/1/2/3"
    
    # Attach to session
    tmux attach-session -t "$session_name"
}

setup_basic() {
    print_info "Setting up basic terminal commands for parallel development..."
    print_info ""
    print_info "Manual Terminal Setup Instructions:"
    print_info "==================================="
    
    local i=1
    for config in "${TERMINALS_CONFIG[@]}"; do
        IFS='|' read -r name path description <<< "$config"
        echo -e "${YELLOW}Terminal $i:${NC} $description"
        echo -e "  ${BLUE}Command:${NC} cd $path"
        echo ""
        ((i++))
    done
    
    print_info "Recommended workflow:"
    print_info "1. Open 4 terminal windows/tabs"
    print_info "2. Run the commands above in each terminal"
    print_info "3. Use Terminal 1 for git coordination"
    print_info "4. Use Terminals 2-4 for parallel development"
}

list_config() {
    print_info "Terminal Configuration for Parallel Development:"
    print_info "=============================================="
    
    local i=1
    for config in "${TERMINALS_CONFIG[@]}"; do
        IFS='|' read -r name path description <<< "$config"
        echo -e "${YELLOW}Terminal $i:${NC} $description"
        echo -e "  ${BLUE}Name:${NC} $name"
        echo -e "  ${BLUE}Path:${NC} $path"
        if [[ -d "$path" ]]; then
            echo -e "  ${GREEN}Status:${NC} Directory exists"
        else
            echo -e "  ${RED}Status:${NC} Directory missing - run ./dev.sh setup-worktree $name"
        fi
        echo ""
        ((i++))
    done
}

verify_worktrees() {
    print_info "Verifying worktree setup..."
    
    local missing_worktrees=()
    
    for config in "${TERMINALS_CONFIG[@]}"; do
        IFS='|' read -r name path description <<< "$config"
        if [[ "$name" != "main" ]] && [[ ! -d "$path" ]]; then
            missing_worktrees+=("$name")
        fi
    done
    
    if [[ ${#missing_worktrees[@]} -gt 0 ]]; then
        print_warning "Missing worktrees detected: ${missing_worktrees[*]}"
        print_info "Setting up missing worktrees..."
        
        for worktree in "${missing_worktrees[@]}"; do
            if [[ -f "$PROJECT_ROOT/dev.sh" ]]; then
                print_info "Setting up worktree: $worktree"
                "$PROJECT_ROOT/dev.sh" setup-worktree "$worktree" || print_warning "Failed to set up $worktree"
            else
                print_error "dev.sh script not found. Cannot set up worktrees automatically."
                return 1
            fi
        done
    else
        print_success "All worktrees are properly set up!"
    fi
}

main() {
    local command="${1:-setup}"
    
    case "$command" in
        "setup")
            verify_worktrees
            local terminal_type=$(detect_terminal)
            print_info "Detected terminal: $terminal_type"
            
            case "$terminal_type" in
                "iterm")
                    setup_iterm
                    ;;
                "terminal")
                    setup_terminal_app
                    ;;
                "tmux")
                    setup_tmux
                    ;;
                *)
                    setup_basic
                    ;;
            esac
            ;;
        "iterm")
            verify_worktrees
            setup_iterm
            ;;
        "terminal")
            verify_worktrees
            setup_terminal_app
            ;;
        "tmux")
            verify_worktrees
            setup_tmux
            ;;
        "list")
            list_config
            ;;
        "help"|"-h"|"--help")
            print_usage
            ;;
        *)
            print_error "Unknown command: $command"
            print_usage
            exit 1
            ;;
    esac
}

main "$@"