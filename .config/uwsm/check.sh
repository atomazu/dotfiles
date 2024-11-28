#!/bin/bash

# Set strict error handling
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Logging functions
log_ok() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}!${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

log_section() {
    echo -e "\n${BOLD}$1${NC}"
    echo "----------------------------------------"
}

# Check if a command exists
check_command() {
    if command -v "$1" >/dev/null 2>&1; then
        log_ok "Found command: $1"
        return 0
    else
        log_error "Missing command: $1"
        return 1
    fi
}

# Check if a file exists
check_file() {
    if [ -f "$1" ]; then
        log_ok "Found file: $1"
        return 0
    else
        log_error "Missing file: $1"
        return 1
    fi
}

# Check if a directory exists
check_directory() {
    if [ -d "$1" ]; then
        log_ok "Found directory: $1"
        return 0
    else
        log_error "Missing directory: $1"
        return 1
    fi
}

# Check if systemd service is available
check_service() {
    if systemctl --user list-unit-files | grep -q "$1"; then
        log_ok "Found systemd service: $1"
        return 0
    else
        log_error "Missing systemd service: $1"
        return 1
    fi
}

# Detect GPU
detect_gpu() {
    log_section "GPU Detection"
    
    if ! command -v lspci >/dev/null 2>&1; then
        log_error "lspci not found. Please install pciutils"
        return 1
    fi

    local gpu_info
    gpu_info=$(lspci -k | grep -A 2 -E "(VGA|3D)")
    
    echo "Detected GPU(s):"
    echo "$gpu_info"
    echo

    if echo "$gpu_info" | grep -q NVIDIA; then
        log_ok "NVIDIA GPU detected"
        check_nvidia_setup
    fi
    
    if echo "$gpu_info" | grep -q AMD; then
        log_ok "AMD GPU detected"
        check_amd_setup
    fi
}

# Check NVIDIA-specific setup
check_nvidia_setup() {
    local required_vars=("GBM_BACKEND" "__GLX_VENDOR_LIBRARY_NAME" "LIBVA_DRIVER_NAME" "__GL_SYNC_ALLOWED" "NVD_BACKEND")
    
    echo "Checking NVIDIA environment variables:"
    for var in "${required_vars[@]}"; do
        if systemctl --user show-environment | grep -q "^$var="; then
            log_ok "$var is set: $(systemctl --user show-environment | grep "^$var=")"
        else
            log_error "$var is not set"
        fi
    done
}

# Check AMD-specific setup
check_amd_setup() {
    echo "Checking AMD environment variables:"
    if systemctl --user show-environment | grep -q "^LIBVA_DRIVER_NAME="; then
        log_ok "LIBVA_DRIVER_NAME is set: $(systemctl --user show-environment | grep "^LIBVA_DRIVER_NAME=")"
    else
        log_error "LIBVA_DRIVER_NAME is not set"
    fi
}

# Check UWSM configuration
check_uwsm_config() {
    log_section "UWSM Configuration Check"
    
    # Check XDG paths
    local config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
    local data_home="${XDG_DATA_HOME:-$HOME/.local/share}"
    
    # Check required directories and files
    check_directory "$config_home/uwsm"
    check_file "$config_home/uwsm/env"
    
    # Check if hyprland config exists
    if check_file "$config_home/uwsm/env-hyprland"; then
        # Check if variables are properly set in env-hyprland
        local required_vars=("XDG_SESSION_TYPE" "XDG_SESSION_DESKTOP" "XDG_CURRENT_DESKTOP")
        echo "Checking Hyprland environment variables:"
        for var in "${required_vars[@]}"; do
            if grep -q "^export $var=" "$config_home/uwsm/env-hyprland"; then
                log_ok "Found $var in env-hyprland"
            else
                log_warn "Missing $var in env-hyprland"
            fi
        done
    fi
}

# Check UWSM runtime status
check_uwsm_runtime() {
    log_section "UWSM Runtime Check"
    
    # Check if UWSM session can be started
    if uwsm check may-start; then
        log_ok "UWSM may-start check passed"
    else
        log_warn "UWSM may-start check failed"
    fi
    
    # Check active session
    if uwsm check is-active; then
        log_ok "UWSM session is active"
        
        # Check service status
        echo "Active UWSM services:"
        systemctl --user list-units 'wayland-*' --no-legend | while read -r unit _load _active _sub _description; do
            echo "  $unit ($_active/$_sub)"
        done
    else
        log_warn "No active UWSM session"
    fi
}

# Check runtime dependencies
check_dependencies() {
    log_section "Dependency Check"
    
    local required_commands=(
        "uwsm"
        "Hyprland"
        "systemctl"
        "dbus-update-activation-environment"
    )
    
    for cmd in "${required_commands[@]}"; do
        check_command "$cmd"
    done
}

# Check systemd environment
check_systemd_env() {
    log_section "Systemd Environment Check"
    
    local important_vars=(
        "WAYLAND_DISPLAY"
        "DISPLAY"
        "XDG_SESSION_TYPE"
        "XDG_SESSION_DESKTOP"
        "XDG_CURRENT_DESKTOP"
    )
    
    echo "Checking important environment variables:"
    for var in "${important_vars[@]}"; do
        if systemctl --user show-environment | grep -q "^$var="; then
            log_ok "$var is set: $(systemctl --user show-environment | grep "^$var=")"
        else
            log_warn "$var is not set"
        fi
    done
}

# Main function
main() {
    echo -e "${BOLD}UWSM & Hyprland Environment Check${NC}"
    echo "========================================="
    echo "Running comprehensive environment check..."
    echo
    
    check_dependencies
    check_uwsm_config
    check_uwsm_runtime
    check_systemd_env
    detect_gpu
    
    log_section "Check Complete"
}

main "$@"