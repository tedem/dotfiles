#!/bin/bash

# -----------------------------------------------------------------------------
# Project: tedem/dotfiles
# Repository: https://github.com/tedem/dotfiles
# Author: tedem
# License: MIT
# -----------------------------------------------------------------------------
#
# DESCRIPTION
#
# This script automates the setup and configuration of a macOS environment.
# It performs prerequisite checks, system configurations, and installs necessary tools.
#
# USAGE
#
# Execute the script directly from the terminal using:
# $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tedem/dotfiles/main/install.sh)"
#
# WARNING
#
# This script will make changes to your system. Review it carefully before proceeding.
# It may require administrative privileges (sudo) and could potentially alter system settings.
#
# -----------------------------------------------------------------------------

# --- BASH STRICT MODE & ERROR HANDLING ---
# e: exit immediately if a command exits with a non-zero status.
# u: treat unset variables as an error.
# o pipefail: sets the exit code of a pipeline to that of the rightmost command
#             to exit with a non-zero status.
set -euo pipefail

# --- STYLING FOR TERMINAL OUTPUT ---

# Define color and style variables if output is a terminal
if [[ -t 1 ]]; then
    BOLD=$(printf "\033[1m")
    AQUA=$(printf "\033[96m")
    BLUE=$(printf "\033[34m")
    GREEN=$(printf "\033[32m")
    RED=$(printf "\033[31m")
    RESET=$(printf "\033[0m")
    DIM=$(printf "\033[2m")
else
    BOLD=""; AQUA=""; BLUE=""; GREEN=""; RED=""; RESET=""; DIM=""
fi

# --- GLOBAL VARIABLES ---
readonly HOSTNAME_TARGET="Medet-Mac-mini"
readonly VERSION="0.1.0"

# --- HELPER FUNCTIONS ---

# Header print function
header() {
    echo "=== ${BOLD}${AQUA}tedem/dotfiles${RESET} — macOS Setup Script (v${VERSION}) ==="
}

# Print blank line for readability
blank() {
    echo ""
}

# Log message functions
log() {
    echo "${BLUE}==>${RESET} $1"
}

# Indented message function
indent() {
    echo "    $1"
}

# Message function
message() {
    echo "$1"
}

# Success message function
success() {
    echo "${GREEN}✓${RESET} $1"
}

# --- PREREQUISITE CHECKS ---

# Check if the OS is macOS (Darwin)
check_os_darwin() {
    if [[ "$OSTYPE" != darwin* ]]; then
        clear
        header
        blank
        log "ERROR: This script is intended to run on macOS only."
        blank
        cat <<'MSG'
This operating system is not supported by this installation script.
Please run this script on a macOS system.
MSG
        blank
        exit 1
    fi
}

# --- USER INTERACTION FUNCTIONS ---

# Display important notice to the user
important_notice() {
    log "IMPORTANT NOTICE:"
    blank
    indent "* This script will make changes to your system."
    indent "* It may require administrative privileges (sudo)."
    indent "* Please review the script before proceeding."
    indent "* Backup important data to avoid potential loss."
    blank
}

# Handle user confirmation to proceed
handle_confirmation() {
    read -r -p "This script will make changes to your system. Do you want to proceed? (y/n): " response
    blank
    case "$response" in
        [yY][eE][sS]|[yY])
            clear
            header
            blank
            log "Installation starting..."
            blank
            message "You have confirmed to proceed with the installation."
            message "Please wait while the setup is in progress..."
            blank
            ;;
        *)
            log "Installation aborted by the user."
            blank
            exit 1
            ;;
    esac
}

# --- STEP 1: HOSTNAME CONFIGURATION ---
hostname_configuration() {
    log "STEP 1: Configuring Hostname..."
    blank

    local current_hostname
    local current_localhostname

    current_hostname=$(scutil --get HostName)
    current_localhostname=$(scutil --get LocalHostName)

    if [ "$current_hostname" != "$current_localhostname" ]; then
        sudo scutil --set HostName "$current_localhostname"
        success "Hostname updated to match LocalHostName: '$current_localhostname'."
    else
        success "Hostname is already set to '$current_localhostname'. No changes needed."
    fi

    blank

    # Display current names
    indent "${DIM}ComputerName:    $(scutil --get ComputerName)${RESET}"
    indent "${DIM}Hostname:        $current_hostname${RESET}"
    indent "${DIM}LocalHostName:   $current_localhostname${RESET}"
    indent "${DIM}NetBIOSName:     $(defaults read /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName)${RESET}"

    blank
}

# --- STEP 2: SUPPRESS LOGIN MESSAGE ---
suppress_login_message() {
    log "STEP 2: Suppressing Login Message..."
    blank

    if [ -f "$HOME/.hushlogin" ]; then
        success "Login message is already suppressed."
        blank
        indent "${DIM}~/.hushlogin${RESET}"
    else
        touch "$HOME/.hushlogin"
        success "Created ~/.hushlogin to suppress login message."
    fi

    blank
}

# --- STEP 3: INSTALLING XCODE COMMAND LINE TOOLS ---
install_xcode() {
    log "STEP 3: Installing Xcode Command Line Tools..."
    blank

    # Check if Xcode Command Line Tools are already installed
    if xcode-select -p &>/dev/null; then
        success "Xcode Command Line Tools are already installed."
        blank
        indent "${DIM}$(pkgutil --pkg-info=com.apple.pkg.CLTools_Executables | grep version)${RESET}"
    else
        message "Installing Xcode Command Line Tools. A graphical prompt will appear."
        xcode-select --install
        until xcode-select -p &>/dev/null; do
            sleep 5
        done
        blank
        success "Xcode Command Line Tools installed successfully."
    fi

    blank
}

# --- MAIN EXECUTION FLOW ---

# Main function
main() {
    # Clear terminal for better readability
    clear

    # Perform OS check
    check_os_darwin

    # Display header
    header
    blank

    # Description of the script
    cat <<'MSG'
This script automates the setup and configuration of a macOS environment.
It performs prerequisite checks, system configurations, and installs necessary tools.
MSG
    blank

    # Display important notice
    important_notice

    # Handle user confirmation
    handle_confirmation

    # Step 1: Hostname Configuration
    hostname_configuration

    # Step 2: Suppress Login Message
    suppress_login_message

    # Step 3: Install Xcode Command Line Tools
    install_xcode
}

# Invoke
main
