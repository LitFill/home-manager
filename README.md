# LitFill's Home Manager Configuration

A comprehensive, reproducible Nix Home Manager configuration optimized for
functional programming and modern development workflows.

## Quick Start

```bash
# 1. Install Nix with flakes
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. Clone this configuration
git clone https://github.com/LitFill/home-manager.git ~/.config/home-manager
cd ~/.config/home-manager

# 3. Update username in home.nix and flake.nix
# 4. Activate the configuration
home-manager switch --flake .#your-username
```

For detailed setup instructions, see the [Setup Guide](SETUP.md).

## Documentation

- **[Setup Guide](SETUP.md)** - Installation and configuration
- **[Configuration Guide](CONFIGURATION.md)** - Module documentation and customization
- **[Examples](EXAMPLES.md)** - Visual examples and workflows
- **[Contributing](CONTRIBUTING.md)** - How to contribute to this configuration

## Configuration Structure

```
home-manager/
├── config/
│   ├── nixvim/           # Neovim configuration
│   │   ├── plugins.nix   # Plugin definitions
│   │   ├── keymaps.nix   # Keyboard shortcuts
│   │   ├── lsp.nix       # Language server setup
│   │   ├── autocmds.nix  # Auto commands
│   │   ├── options.nix   # Editor options
│   │   └── extra.nix     # Additional configurations
│   ├── shell/            # Shell configurations
│   │   ├── nushell.nix   # Nushell setup
│   │   └── starship.nix  # Starship prompt
│   ├── tmux.nix          # Terminal multiplexer
│   ├── packages.nix      # Package list
│   ├── git.nix           # Git configuration
│   ├── shell.nix         # Shell tools
│   └── nixvim.nix        # NixVim entry point
├── home.nix              # Main configuration
├── flake.nix             # Nix flake definition
├── SETUP.md              # Setup instructions
└── README.md             # This file
```

## Key Features

### Development Environment

- **Functional Programming**: Haskell (GHC, HLS, Fourmolu), Idris2, OCaml
- **Modern Languages**: Rust (rustup), TypeScript, Lua
- **Language Servers**: Comprehensive LSP support for all major languages
- **Code Quality**: Hlint, Shellcheck, StyLua, Fourmolu formatters

### Terminal Experience

- **Shell**: Nushell with Starship prompt and carapace completions
- **Navigation**: zoxide for smart directory jumping, broot for file browsing
- **Multiplexing**: tmux with sensible defaults
- **File Tools**: yazi (file manager), fd (find), ripgrep (search)

### Editor & Tools

- **Editor**: Neovim with NixVim configuration
- **System Monitoring**: btop, fastfetch
- **Documentation**: pandoc, glow for markdown rendering
- **Finance**: Complete hledger suite for accounting

### Design Philosophy

- **Reproducible**: Everything declared in Nix, no manual setup
- **Modular**: Clean separation of concerns with individual modules
- **Minimal**: Essential tools without bloat
- **Cross-platform**: Works on any Linux system with Nix

## Package Categories

| Category          | Packages                               |
| ----------------- | -------------------------------------- |
| **Languages**     | Haskell, Idris2, Rust, TypeScript, Lua |
| **Tools**         | Git, tmux, fd, ripgrep, rsync          |
| **Formatters**    | Fourmolu, StyLua, nixfmt               |
| **LSP Servers**   | HLS, rust-analyzer, tsserver, lua-ls   |
| **System**        | btop, fastfetch, direnv                |
| **Documentation** | pandoc, glow                           |
| **Finance**       | hledger suite                          |

## Customization

This configuration is designed to be easily customizable:

- **Add packages**: Edit `config/packages.nix`
- **Configure shell**: Modify `config/shell/` files
- **Customize editor**: Update `config/nixvim/` directory
- **Change tools**: Edit individual module files

For now I purposefully ignore `config/desktop.nix` for I am not on NixOS yet.

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
