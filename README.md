# ⚙️ Dotfiles

This repository contains my personal dotfiles for configuring various applications and tools on my system. These configurations help streamline my workflow and maintain consistency across different environments.

Work in progress... 🚧

## 📦 Backup Instructions

### 1. Git Configuration

Backup your Git configuration file with the following command:

```bash
cp ~/.gitconfig ~/Code/dotfiles/git/.gitconfig
```

### 2. VS Code Configuration

Backup your VS Code settings, keybindings, and extensions with these commands:

```bash
cp "$HOME/Library/Application Support/Code/User/settings.json" ~/Code/dotfiles/vscode/settings.json
cp "$HOME/Library/Application Support/Code/User/keybindings.json" ~/Code/dotfiles/vscode/keybindings.json
code --list-extensions > ~/Code/dotfiles/vscode/extensions.txt
```

### 3. Zsh Configuration

Backup your Zsh configuration file with the following command:

```bash
cp ~/.zprofile ~/Code/dotfiles/zsh/.zprofile
cp ~/.zshrc ~/Code/dotfiles/zsh/.zshrc
```

### 4. SSH Configuration

Backup your SSH configuration file with the following command:

```bash
cp ~/.ssh/config ~/Code/dotfiles/ssh/config
```

## 📥 Restore Instructions

### 1. Git Configuration

Restore your Git configuration file with the following command:

```bash
cp ~/Code/dotfiles/git/.gitconfig ~/.gitconfig
```

### 2. VS Code Configuration

Restore your VS Code settings, keybindings, and extensions with these commands:

```bash
cp ~/Code/dotfiles/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
cp ~/Code/dotfiles/vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
xargs -n 1 code --install-extension < ~/Code/dotfiles/vscode/extensions.txt
```

### 3. Zsh Configuration

Restore your Zsh configuration file with the following command:

```bash
cp ~/Code/dotfiles/zsh/.zprofile ~/.zprofile
cp ~/Code/dotfiles/zsh/.zshrc ~/.zshrc
```

### 4. SSH Configuration

Restore your SSH configuration file with the following command:

```bash
cp ~/Code/dotfiles/ssh/config ~/.ssh/config
```

## 📱 Social Media

Follow me on these social media platforms:

| Platform  | Handle |
|-----------|--------|
| Instagram | [@tedemedet](https://www.instagram.com/tedemedet/) |
| X         | [@tedemedet](https://x.com/tedemedet) |
| BlueSky   | [@tedem.dev](https://bsky.app/profile/tedem.dev) |
| Pinkary   | [@tedem](https://pinkary.com/@tedem) |

End of README.md!
