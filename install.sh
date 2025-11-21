#!/bin/bash

# -----------------------------------------------------------------------------
# Project : tedem/dotfiles
# Author  : tedem
# Repo    : https://github.com/tedem/dotfiles
# Purpose : Rapid setup of macOS environment with personal preferred settings.
# License : MIT (see repository for details)
# Usage   : ./install.sh
# Note    : Designed for macOS only.
# -----------------------------------------------------------------------------

# Bash strict mode
set -euo pipefail

# Defines
HEADER=$'\033[1;36m[ tedem/dotfiles ]\033[0m'
HOSTNAME="Medet-Mac-mini"

# Underline text function
underline() {
    printf "\e[4m$1\e[0m"
}

# Clear
clear

# macOS check
if [[ "$OSTYPE" != darwin* ]]; then
    printf "%s\n" "$HEADER"
    echo ""
    printf "\033[1;31mThis script can only be run on macOS.\033[0m\n"
    printf "\033[1;33mAborting installation.\033[0m\n"
    echo ""
    exit 1
fi

# Visual Studio Code check (for configurations)
# Detect Visual Studio Code installation path
VS_CODE_PATH=""
for p in "/Applications/Visual Studio Code.app" \
         "$HOME/Applications/Visual Studio Code.app" \
         "/Applications/Visual Studio Code - Insiders.app" \
         "$HOME/Applications/Visual Studio Code - Insiders.app"
do
    if [ -d "$p" ]; then
        VS_CODE_PATH="$p"
        break
    fi
done

if [ ! -d "$VS_CODE_PATH" ]; then
    printf "%s\n" "$HEADER"
    echo ""
    printf "\033[1;31mPlease install Visual Studio Code before proceeding.\033[0m\n"
    echo ""
    echo "Install Visual Studio Code and re-run this script."
    echo "-> $(underline 'https://code.visualstudio.com/download')"
    echo ""
    printf "\033[1;33mAborting installation.\033[0m\n"
    echo ""
    exit 1
fi

# Welcome message
printf "%s\n" "$HEADER"
echo ""
printf "\033[33mConfiguring macOS with tedem/dotfiles.\033[0m\n"
echo ""
printf "• Please ensure you have read the README.md before proceeding.\n"
printf "• This script will make changes to your system.\n"
printf "• Proceed with caution and at your own risk.\033[0m\n"
echo ""

# Prompt for confirmation
printf "\033[1;32mPress 'Enter' to start the installation.\033[0m\n"
printf "\033[1;31mPress 'Backspace' to abort.\033[0m\n"
printf "\n\033[2m[ Waiting for key press... ]\033[0m\n"
read -rsn1 key

# Key is not recognized
if [ "$key" != "" ] && [ "$key" != $'\x7f' ]; then
    clear
    printf "%s\n" "$HEADER"
    echo ""
    printf "\033[1;31mUnrecognized key pressed. Installation aborted.\033[0m\n"
    echo ""
    exit 1
fi

# Abort installation
if [ "$key" = $'\x7f' ]; then
    clear
    printf "%s\n" "$HEADER"
    echo ""
    printf "\033[1;31mInstallation aborted by user.\033[0m\n"
    echo ""
    exit 1
fi

# Start installation
if [ "$key" = "" ]; then
    clear
    printf "%s\n" "$HEADER"
    echo ""
    printf "\033[1;32m🧨 Starting installation...\033[0m\n"
    echo ""
    sleep 1
fi

# Set HostName
printf "\033[1;34mHostName updating...\033[0m\n"

if [ "$(scutil --get HostName)" != "$HOSTNAME" ]; then
    sudo scutil --set HostName "$HOSTNAME"
    printf "\033[1;32mHostName set to '%s' successfully.\033[0m\n" "$HOSTNAME"
else
    printf "\033[1;32mHostName is already set to '%s'.\033[0m\n" "$HOSTNAME"
fi

# Show LocalHostName
LOCAL_HOSTNAME=$(scutil --get LocalHostName)
printf "\033[2mLocalHostName is '%s'.\033[0m\n" "$LOCAL_HOSTNAME"

# Show ComputerName
COMPUTER_NAME=$(scutil --get ComputerName)
printf "\033[2mComputerName is '%s'.\033[0m\n" "$COMPUTER_NAME"

echo ""

# Suppress login messages
printf "\033[1;34mSuppressing login messages...\033[0m\n"

if [ ! -f "$HOME/.hushlogin" ]; then
    touch "$HOME/.hushlogin"
    printf "\033[1;32mLogin messages suppressed successfully.\033[0m\n"
else
    printf "\033[1;32mLogin messages are already suppressed.\033[0m\n"
fi

echo ""

# Install Xcode Command Line Tools if not installed
printf "\033[1;34mChecking for Xcode Command Line Tools...\033[0m\n"

if ! xcode-select -p &>/dev/null; then
    printf "\033[1;34mInstalling Xcode Command Line Tools...\033[0m\n"
    xcode-select --install

    # Wait until the Xcode Command Line Tools are installed
    until xcode-select -p &>/dev/null; do
        sleep 5
    done

    printf "\033[1;32mXcode Command Line Tools installed successfully.\033[0m\n"
else
    printf "\033[1;32mXcode Command Line Tools already installed.\033[0m\n"
fi

echo ""

# Install Homebrew if not installed
printf "\033[1;34mChecking for Homebrew...\033[0m\n"

if ! command -v brew &>/dev/null; then
    printf "\033[1;34mInstalling Homebrew...\033[0m\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"

    printf "\033[1;32mHomebrew installed successfully.\033[0m\n"
else
    printf "\033[1;32mHomebrew already installed.\033[0m\n"
fi

echo ""

# Install partitions from Brewfile
printf "\033[1;34mInstalling partitions from Brewfile...\033[0m\n"
BREWFILE_URL="https://raw.githubusercontent.com/tedem/dotfiles/main/Brewfile"

if ! curl -fsI "$BREWFILE_URL" >/dev/null; then
    printf "\033[1;31mBrewfile URL unreachable. Aborting...\033[0m\n"
    exit 1
fi

TMP_BREWFILE="$(mktemp)"
curl -fsSL "$BREWFILE_URL" -o "$TMP_BREWFILE"
brew bundle --file="$TMP_BREWFILE"
rm -f "$TMP_BREWFILE"
brew cleanup
printf "\033[1;32mPartitions installed successfully from Brewfile.\033[0m\n"
echo ""
