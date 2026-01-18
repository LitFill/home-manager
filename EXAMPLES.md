# Examples and Screenshots

This document provides visual examples of the Home Manager configuration in
action, including terminal setup, editor configuration, and key workflows.

## Terminal Experience

### Nushell with Starship Prompt

```nu
❯ pwd
/home/litfill/.config/home-manager

❯ ls -la */** | where type == dir | where name !~ git | select name size modified
╭───┬───────────────┬────────┬─────────────╮
│ # │     name      │  size  │  modified   │
├───┼───────────────┼────────┼─────────────┤
│ 0 │ config/nixvim │ 4,0 kB │ 5 hours ago │
│ 1 │ config/shell  │ 4,0 kB │ 4 hours ago │
╰───┴───────────────┴────────┴─────────────╯
```

**Features shown:**
- Custom Starship prompt with git integration
- Nushell's structured data display
- Auto-completion with carapace
- Syntax highlighting

### Tmux Multiplexing

**Keybindings:**
- `Ctrl-a` - Prefix key
- `Ctrl-a h/j/k/l` - Navigate panes
- `Ctrl-a c` - Create new window
- `Ctrl-a ,` - Rename window

## Editor Configuration

### Neovim with NixVim

#### File Explorer (Mini.files)

#### LSP Integration

## Development Workflows

### Haskell Development

#### Project Structure
```
my-project/
├── package.yaml
├── src/
│   └── Main.hs
├── app/
│   └── Main.hs
├── test/
│   └── Spec.hs
└── stack.yaml
```

### Rust Development

#### Cargo Project
```bash
❯ cargo new rust-project
     Created binary (application) `rust-project` package
❯ cd rust-project
❯ nvim src/main.rs
```

## System Monitoring

### btop System Monitor

### fastfetch System Info

```
                  -`                     litfill@perihelion
                 .o+`                    ------------------
                `ooo/                    OS: Arch Linux x86_64
               `+oooo:                   Host: 81W6 (Lenovo IdeaPad S145-14IIL)
              `+oooooo:                  Kernel: Linux 6.12.63-1-lts
              -+oooooo+:                 Uptime: 5 hours, 53 mins
            `/:-:++oooo+:                Packages: 1551 (pacman), 1150 (nix-user), 60 (nix-default)
           `/++++/+++++++:               Shell: nushell 0.108.0
          `/++++++++++++++:              Display (CMN14D6): 1366x768 in 14", 60 Hz [Built-in]
         `/+++ooooooooooooo/`            WM: niri (Wayland)
        ./ooosssso++osssssso+`           Icons: breeze [GTK4]
       .oossssso-````/ossssss+`          Cursor: capitaine
      -osssssso.      :ssssssso.         Terminal: WezTerm 20240203-110809-5046fc22
     :osssssss/        osssso+++.        Terminal Font: MonaspiceKr Nerd Font Propo
    /ossssssss/        +ssssooo/-        CPU: Intel(R) Core(TM) i3-1005G1 (4) @ 3.40 GHz
  `/ossssso+/:-        -:/+osssso+-      GPU: Intel Iris Plus Graphics G1 (Ice Lake) @ 0.90 GHz [Integrated]
 `+sso+:-`                 `.-/+oso:     Memory: 2.29 GiB / 3.62 GiB (63%)
`++:.                           `-/+/    Swap: 3.42 GiB / 8.00 GiB (43%)
.`                                 `/    Disk (/): 118.49 GiB / 158.80 GiB (75%) - ext4
                                         Local IP (wlan0): 192.168.0.111/24
                                         Battery (L16L2PB3): 47% [Charging, AC Connected]
                                         Locale: id_ID.UTF-8
```

## File Management

### yazi File Manager

### fzf File Search

## Search and Navigation

### ripgrep Search Results

```nu
❯ rg "home\.packages" config/
config/packages.nix
6:home.packages = with pkgs; [
7:  # cabal-install
8:  # ghc
9:  # stack

config/shell.nix
1:{
2:    imports = [
3:        ./shell/nushell.nix
4:        ./shell/starship.nix
5:    ];
```

### fd File Discovery
```
❯ fd "\.nix$" config/
config/git.nix
config/packages.nix
config/shell.nix
config/tmux.nix
config/nixvim.nix
config/shell/nushell.nix
config/shell/starship.nix
config/nixvim/plugins.nix
config/nixvim/keymaps.nix
config/nixvim/lsp.nix
config/nixvim/options.nix
config/nixvim/autocmds.nix
config/nixvim/extra.nix
```

## Documentation Workflow

### pandoc Document Conversion
```bash
❯ pandoc README.md -o README.pdf
❯ pandoc README.md -o README.html --standalone
❯ pandoc README.md -o README.docx
```

### glow Markdown Rendering
```
❯ glow README.md
# LitFill's Home Manager Configuration

A comprehensive, reproducible Nix Home Manager configuration optimized for
functional programming and modern development workflows.

## Quick Start

```bash
# 1. Install Nix with flakes
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
```

## Finance Management

### hledger Accounting
```
❯ hledger -f finance.journal bal
                 Balance 2024-01-01

                    $  5,234.56  Assets
                    $  3,000.00    Checking
                    $  2,234.56    Savings
                   $ -1,500.00  Liabilities
                   $ -1,500.00    Credit Card
                    $  3,734.56  Net Worth
```

### hledger-ui Terminal Interface
```
┌─────────────────────────────────────────────────────────────────────────┐
│ hledger-ui 2024-01                                                       │
│                                                                          │
│ Assets                                                                   │
│   Checking                    $3,000.00                                  │
│   Savings                     $2,234.56                                  │
│ Liabilities                                                              │
│   Credit Card               -$1,500.00                                  │
│                                                                          │
│ Net Worth                    $3,734.56                                  │
│                                                                          │
│ [q]uit [a]dd [e]dit [d]elete [j]ournal [r]eports                       │
└─────────────────────────────────────────────────────────────────────────┘
```

## Customization Examples

### Custom Starship Prompt
```toml
# ~/.config/starship.toml
format = """
[┌───────────────────>](bold green)
[│](bold green)$directory$git_branch$git_status
[└─>](bold green)$character
"""

[character]
success_symbol = "[->](bold green)"
error_symbol = "[->](bold red)"
```

### Custom Nushell Aliases
```nushell
# ~/.config/nushell/env.nix
alias ll = ls -la
alias la = ls -a
alias lt = ls --tree
alias grep = rg
alias find = fd
alias cat = bat
```

### Custom Neovim Keymaps
```nix
# config/nixvim/keymaps.nix
keymaps = [
  {
    mode = "n";
    key = "<leader>f";
    action = "<cmd>Telescope find_files<cr>";
    options = { desc = "Find files"; };
  }
  {
    mode = "n";
    key = "<leader>g";
    action = "<cmd>Telescope live_grep<cr>";
    options = { desc = "Live grep"; };
  }
];
```

## Daily Workflow Examples

### Morning Setup
```bash
❯ tmux new -s work
❯ tmux split-window -h
❯ nvim .
# Left pane: nvim editor
# Right pane: terminal for commands
```

### Project Development
```bash
❯ cd projects/my-app
❯ nvim .
# Edit files with full LSP support
❯ :terminal
# Run tests in terminal
❯ cargo test  # or stack test, npm test, etc.
```

### Configuration Updates
```bash
❯ cd ~/.config/home-manager
❯ nvim config/packages.nix
# Add new package
❯ home-manager switch --flake .#litfill
# Apply changes
```

---

These examples showcase the power and flexibility of this Home Manager configuration. The modular design allows for easy customization while maintaining a consistent, productive development environment.
