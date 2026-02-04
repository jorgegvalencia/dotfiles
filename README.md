# Dotfiles

Personal configuration repository for macOS that automates the installation and setup of your development environment, including Homebrew, Zsh, VSCode, and code style guides.

> Most configurations are based on the [dotfiles](https://github.com/alexanderop/dotfiles) repository by [Alexander Opalic](https://github.com/alexanderop).

## 📋 Contents

- **Brewfile**: Definition of all required dependencies and tools (CLIs, fonts, VSCode extensions)
- **install.sh**: Main automated installation script
- **scripts/**: Helper scripts for different configurations
- **vscode/**: VSCode configurations (general and profiles)
- **home/**: Dotfiles for the home folder (`~/.zshrc`, etc.)
- **docs/**: Style guides (TypeScript, Vue)

## 🚀 Installation

### Quick Start

The simplest way to install everything:

```bash
git clone https://github.com/jorgegvalencia/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

This will run:
1. ✅ Homebrew installation (if not present)
2. ✅ Installation of all Brewfile packages
3. ✅ Oh My Zsh installation
4. ✅ Installation of Zsh plugins (autosuggestions, syntax-highlighting, completions)
5. ✅ Creation of symlinks for dotfiles
6. ✅ VSCode configuration
7. ✅ (Optional) macOS system preferences configuration

### Selective Installation

If you prefer to install individual components, use the `Makefile`:

```bash
make help              # View all available commands
make install          # Install everything
make brew             # Install Homebrew packages only
make link             # Create symlinks only
make vscode           # Setup VSCode only
make macos            # Configure macOS system preferences
make update           # Export current configurations to repo
```

## 📦 Installed Packages (Brewfile)

### Command-Line Tools

| Tool | Description |
|------|-------------|
| `fnm` | Node.js version manager (fast in Rust) |
| `pnpm` | Fast Node.js package manager |
| `git` | Version control |
| `gh` | GitHub CLI |
| `ripgrep` | Very fast text search |
| `fd` | Simpler alternative to `find` |
| `fzf` | Interactive fuzzy finder |
| `bat` | `cat` enhanced with syntax highlighting |
| `eza` | Modern `ls` with colors |
| `tldr` | Simplified man pages |
| `tree` | Visualize directory structure |

### Development Tools

| Tool | Description |
|------|-------------|
| `python@3.14` | Python 3.14 |
| `pre-commit` | Automatic git hooks |
| `pmd` | Static code analyzer |
| `ast-grep` | AST-based code search |
| `ffmpeg` | Audio/video processing |
| `yt-dlp` | Download videos |

### Fonts

- `font-fira-code` - Monospaced font
- `font-jetbrains-mono` - JetBrains Mono font
- `font-jetbrains-mono-nerd-font` - JetBrains Mono with Nerd Font icons

### Utilities

- `stats` - System monitor in menu bar

### VSCode Extensions

Over 50 extensions are automatically installed including:

- **Themes**: CodeSandbox Legacy, Tokyo Night, Vitesse, Gruvbox
- **Git**: Git Graph, GitHub Pull Request
- **Development**: Vim keybindings, ESLint, Markdown Lint, Live Server
- **Utilities**: Bookmarks, Notes, Color Highlight, DateTime, Sort Lines
- **Languages**: MDX, YAML, SVG, MJML

Check [Brewfile](Brewfile) for the complete list.

## ⚙️ Configuration Scripts

### brew.sh

```bash
./scripts/brew.sh
```

Installs all packages defined in `Brewfile` using `brew bundle`.

### link.sh

```bash
./scripts/link.sh
```

Creates automatic symlinks from the `dotfiles` repo to your home folder:

- Files from `home/` are linked to `~/`
- Automatically backs up existing files (`.backup`)

Example:
```
home/.zshrc → ~/.zshrc
```

### vscode.sh

```bash
./scripts/vscode.sh
```

Configures VSCode:
1. Links the general `vscode/settings.json` configuration
2. Sets up two profiles with specific settings:
   - **Frontend** (ID: 4a9f917b): `vscode/profiles/frontend/settings.json`
   - **Node** (ID: 1a6df7f5): `vscode/profiles/node/settings.json`

File locations after linking:
```
~/Library/Application Support/Code/User/
├── settings.json → dotfiles/vscode/settings.json
└── profiles/
    ├── 4a9f917b/settings.json → dotfiles/vscode/profiles/frontend/settings.json
    └── 1a6df7f5/settings.json → dotfiles/vscode/profiles/node/settings.json
```

### macos.sh

```bash
./scripts/macos.sh
```

Automatically configures macOS system preferences (prompted during `install.sh`). Includes configurations for:
- Dock and Finder
- Accessibility
- Keyboard and Mouse
- Other system adjustments

## 📝 VSCode Configuration

### General Settings

The general configuration includes:

**UI & Workbench**
- Theme: CodeSandbox Legacy (dark), One Dark Palenight (light)
- Icons: Symbols
- Sidebar on the right, Activity Bar on top

**Editor**
- Font: JetBrains Mono (with fallbacks)
- Size: 14px
- Tab size: 2 spaces
- Word wrap: 120 characters
- Minimap disabled
- Sticky scroll and bracket pair colorization enabled

**Terminal**
- Custom ANSI colors (inspired by CodeSandbox)

Check [vscode/settings.json](vscode/settings.json) for all details.

### Profiles

Two profiles are configured for different contexts:

1. **Frontend** - For web/Vue/React development
2. **Node** - For backend/Node.js development

Each profile can have specific settings in:
- [vscode/profiles/frontend/settings.json](vscode/profiles/frontend/settings.json)
- [vscode/profiles/node/settings.json](vscode/profiles/node/settings.json)

**Using a profile:**
- Command: `code --profile frontend` or `code --profile node`
- Or from VSCode: Click on user avatar → Select profile

## 📚 Style Guides

### TypeScript

Complete style guide and conventions for TypeScript v5 with `strict-type-checked`:
- Strict typing (no `any`, prefer `unknown`)
- Immutability with `Readonly`
- Discriminated unions
- Pure and stateless functions
- Naming conventions (camelCase, PascalCase, SCREAMING_SNAKE_CASE)
- Named imports (no default exports)

Check [docs/TYPESCRIPT_STYLE_GUIDE.md](docs/TYPESCRIPT_STYLE_GUIDE.md)

### Vue

Style guide and best practices for Vue development:

Check [docs/VUE_STYLE_GUIDE.md](docs/VUE_STYLE_GUIDE.md)

## 🔄 Updating the Repository

If you change configurations on your system and want to save them to the repo:

```bash
make update
```

This command:
1. Exports the current Brewfile
2. Exports installed VSCode extensions
3. Allows you to review changes: `git diff`

Then you can commit the changes:

```bash
git add .
git commit -m "Update configurations"
git push
```

## 📂 Repository Structure

```
dotfiles/
├── Brewfile                  # Package definition to install
├── install.sh              # Main installation script
├── Makefile                # Helper commands
├── README.md               # This file
├── scripts/
│   ├── brew.sh            # Install Homebrew packages
│   ├── link.sh            # Create dotfiles symlinks
│   ├── vscode.sh          # Setup VSCode
│   ├── macos.sh           # Configure macOS preferences
│   └── claude.sh          # (Optional) Configure Claude Code
├── vscode/
│   ├── settings.json      # General VSCode configuration
│   ├── keybindings.json   # Keyboard shortcuts
│   ├── extensions.txt     # List of installed extensions
│   ├── extensions_by_profile.txt
│   └── profiles/
│       ├── frontend/
│       │   └── settings.json
│       └── node/
│           └── settings.json
├── home/
│   └── .zshrc             # Zsh configuration
├── docs/
│   ├── TYPESCRIPT_STYLE_GUIDE.md
│   └── VUE_STYLE_GUIDE.md
└── gemini/                # (Excluded from this documentation)
```

## 🛠️ Requirements

- **macOS** 10.15 or higher
- **Bash** 3.2+ (included in macOS)
- **Curl** (included in macOS)
- **Git** (will be installed if necessary)

## ⚡ Helpful Tips

### After Installation

1. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

2. **Install Node.js LTS**:
   ```bash
   fnm install --lts
   ```

3. **Sync VSCode settings**:
   - Open VSCode
   - Sign in with GitHub to sync extensions and settings

4. **Check changes**:
   ```bash
   git status
   ```

### Restoring from Backups

If something fails, original files are saved with `.backup` extension:

```bash
# Restore .zshrc
mv ~/.zshrc.backup ~/.zshrc

# Restore VSCode settings
mv "~/Library/Application Support/Code/User/settings.json.backup" \
   "~/Library/Application Support/Code/User/settings.json"
```

### Symlinks on the System

The created symlinks are:
- **Local**: Only on your machine
- **Automatic**: Updated when files in `dotfiles/` change
- **Reversible**: You can delete them manually

To see existing symlinks:
```bash
ls -la ~/ | grep "^l"
```

## 📝 Customization

To personalize without affecting the repo:

1. **Local VSCode changes**: Edit directly in `~/Library/Application Support/Code/User/` (though it will be overwritten in future installations)

2. **Zsh changes**: Edit `~/dotfiles/home/.zshrc` and run `source ~/.zshrc`

3. **New Homebrew packages**: Add to [Brewfile](Brewfile) and run `make brew`

4. **New VSCode extensions**: Install them in VSCode and run `make update`

## 🤝 Contributing

To contribute improvements:

1. Fork the repository
2. Create a branch: `git checkout -b feature/improvement`
3. Commit: `git commit -m "Add feature"`
4. Push: `git push origin feature/improvement`
5. Open a Pull Request

## 📄 License

MIT - Feel free to use this for your own dotfiles!

## 💬 Support

If you encounter issues:

1. Check the logs of the failed script
2. Verify you have internet access
3. Try running `make clean` (if it exists) or delete symlinks manually
4. Open an issue in the repository

---

**Last updated**: February 2026
