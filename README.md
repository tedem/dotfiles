# Dotfiles

Opinionated personal development environment configuration.

## Git Configuration Backup

Run the following commands to back up your Git configuration files:

Global Git Config:

```bash
cp ~/.gitconfig ~/Code/dotfiles/git/.gitconfig
```

## VSCode Configuration Backup

Run the following commands to back up your configuration files:

Settings:

```bash
cp "$HOME/Library/Application Support/Code/User/settings.json" ~/Code/dotfiles/vscode/settings.json
```

Keybindings:

```bash
cp "$HOME/Library/Application Support/Code/User/keybindings.json" ~/Code/dotfiles/vscode/keybindings.json
```

Extensions:

```bash
code --list-extensions > ~/Code/dotfiles/vscode/extensions.txt
```
