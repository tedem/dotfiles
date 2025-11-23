# ⚙️ Dotfiles (Work in Progress)

This repository contains preferred configuration files (dotfiles) used to create a standardized and portable development environment.

## 💾 Configuration Backup Instructions

Use the commands below to copy your current local configuration files into this dotfiles directory (backup).

### 1. Git Configuration

Run the following command to back up your global Git settings.

**Global Git Config:**

```bash
cp ~/.gitconfig ~/Code/dotfiles/git/.gitconfig
```

## 2. VS Code Configuration

Execute the following commands sequentially to back up your VS Code user settings, keyboard shortcuts, and the list of installed extensions.

**User Settings:**

```bash
cp "$HOME/Library/Application Support/Code/User/settings.json" ~/Code/dotfiles/vscode/settings.json
```

**Keyboard Shortcuts:**

```bash
cp "$HOME/Library/Application Support/Code/User/keybindings.json" ~/Code/dotfiles/vscode/keybindings.json
```

**Extensions List:**

This command saves the identifiers of all installed extensions to a text file:

```bash
code --list-extensions > ~/Code/dotfiles/vscode/extensions.txt
```
