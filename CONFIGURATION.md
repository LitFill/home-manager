# Configuration Documentation

This document explains each module in this Home Manager configuration and how
to customize them.

## Module Overview

```
config/
├── nixvim/          # Neovim editor configuration
├── shell/           # Shell and prompt configuration
├── tmux.nix         # Terminal multiplexer setup
├── packages.nix     # System packages
├── git.nix          # Version control setup
├── shell.nix        # Shell tools and utilities
└── nixvim.nix       # NixVim entry point
```

## Core Modules

### home.nix
**Pose**: Main configuration entry point
**Key settings**:
- User information (username, home directory)
- Email accounts configuration
- Session PATH additions
- File templates (stylua.toml, fourmolu.yaml, etc.)

**Customization**:

```nix
# Update user info
home.username = "your-username";
home.homeDirectory = "/home/your-username";

# Add custom paths
home.sessionPath = [
  "/path/to/your/bin"
  # ... existing paths
];

# Add custom files
home.file."custom-config" = {
  text = "your configuration content";
};
```

### flake.nix

**Purpose**: Nix flake definition and dependencies
**Key settings**:
- Input sources (nixpkgs, home-manager, nixvim)
- System architecture
- Output configuration

**Customization**:

```nix
# Change system
system = "aarch64-linux";  # For ARM Linux

# Add additional inputs
inputs = {
  # ... existing inputs
  nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
};
```

## Package Management

### packages.nix

**Purpose**: System-wide package installation
**Categories**:
- **Languages**: Haskell, Rust, TypeScript, Idris2
- **Tools**: Git, tmux, fd, ripgrep
- **Formatters**: Fourmolu, StyLua, nixfmt
- **LSP Servers**: Language-specific servers
- **System**: btop, fastfetch, direnv

**Adding packages**:

```nix
home.packages = with pkgs; [
  # Existing packages...
  your-new-package
  another-package
];
```

**Package groups**:

```nix
# Organize by category
home.packages = with pkgs; [
  # Development
  haskell-language-server
  rustup
  typescript-language-server

  # System tools
  btop
  fastfetch
  fd

  # Documentation
  pandoc
  glow
];
```

## Shell Configuration

### shell.nix

**Purpose**: Shell tools and utilities configuration
**Components**:
- broot (file browser)
- carapace (completion system)
- zoxide (smart directory navigation)

**Customization**:

```nix
# Enable/disable tools
programs.broot.enable = true;
programs.carapace.enable = true;
programs.zoxide.enable = true;

# Add shell integrations
programs.zoxide.enableNushellIntegration = true;
```

### shell/nushell.nix

**Purpose**: Nushell shell configuration
**Features**:
- Custom environment variables
- Command aliases
- Shell functions

**Customization**:

```nix
programs.nushell = {
  enable = true;

  # Environment variables
  environmentVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  # Aliases
  shellAliases = {
    ll = "ls -la";
    gs = "git status";
  };
};
```

### shell/starship.nix

**Purpose**: Starship prompt configuration
**Features**:
- Custom prompt format
- Module configuration
- Color scheme

**Customization**:

```nix
programs.starship = {
  enable = true;

  settings = {
    # Custom prompt format
    format = "$all$directory$character";

    # Module settings
    git_branch.format = "on [$symbol$branch]($style) ";
  };
};
```

## Editor Configuration

### nixvim.nix

**Purpose**: NixVim entry point and basic settings
**Components**:
- Plugin management
- Basic editor options
- LSP configuration

### nixvim/plugins.nix

**Purpose**: Plugin definitions and management
**Categories**:
- **LSP**: Language server support
- **Editing**: Code enhancement tools
- **Navigation**: File and code navigation
- **UI**: Interface improvements

**Adding plugins**:

```nix
plugins = with pkgs.vimPlugins; [
  # Existing plugins...
  your-plugin
];

# Configure plugin
plugins.your-plugin = {
  enable = true;
  # Plugin-specific settings
};
```

### nixvim/keymaps.nix

**Purpose**: Keyboard shortcuts and mappings
**Categories**:
- **Normal mode**: Navigation and commands
- **Insert mode**: Text editing
- **Visual mode**: Selection and manipulation

**Adding keymaps**:

```nix
keymaps = [
  # Normal mode
  {
    mode = "n";
    key = "<leader>f";
    action = "<cmd>Telescope find_files<cr>";
    options = { desc = "Find files"; };
  }

  # Insert mode
  {
    mode = "i";
    key = "jk";
    action = "<Esc>";
    options = { desc = "Exit insert mode"; };
  }
];
```

### nixvim/lsp.nix

**Purpose**: Language server configuration
**Features**:
- Server definitions
- Keybindings for LSP
- Capabilities configuration

**Adding LSP servers**:

```nix
lsp = {
  enable = true;

  servers = {
    # Existing servers...
    your-language-server = {
      enable = true;
      # Server-specific settings
    };
  };
};
```

### nixvim/options.nix

**Purpose**: Basic Neovim options and settings
**Categories**:
- **Editor behavior**: Indentation, line numbers
- **Search**: Case sensitivity, highlighting
- **Interface**: Colors, signs

**Customization**:

```nix
opts = {
  # Editor settings
  number = true;
  relativenumber = true;
  tabstop = 4;
  shiftwidth = 4;

  # Search settings
  ignorecase = true;
  smartcase = true;

  # Interface
  signcolumn = "yes";
};
```

### nixvim/autocmds.nix

**Purpose**: Automatic commands and events
**Features**:
- File type detection
- Auto-save functionality
- Window management

**Adding autocmds**:

```nix
autoCmds = [
  # File type settings
  {
    event = "FileType";
    pattern = "nix";
    callback = { __raw = "function() setlocal tabstop=2 shiftwidth=2 end"; };
  }

  # Auto-save
  {
    event = "InsertLeave";
    pattern = "*";
    callback = { __raw = "function() vim.cmd('update') end"; };
  }
];
```

### nixvim/extra.nix

**Purpose**: Additional configurations and custom scripts
**Features**:
- Custom functions
- Advanced settings
- Integration scripts

## Utility Modules

### git.nix

**Purpose**: Git version control configuration
**Features**:
- User information
- Aliases and shortcuts
- Default settings

**Customization**:

```nix
programs.git = {
  enable = true;

  userName = "Your Name";
  userEmail = "your.email@example.com";

  aliases = {
    st = "status";
    co = "checkout";
    br = "branch";
  };

  extraConfig = {
    init.defaultBranch = "main";
    pull.rebase = true;
  };
};
```

### tmux.nix

**Purpose**: Terminal multiplexer configuration
**Features**:
- Custom keybindings
- Plugin management
- Session settings

**Customization**:

```nix
programs.tmux = {
  enable = true;

  # Keybindings
  keybindings = {
    "C-a" = "send-prefix";
    "C-h" = "select-pane -L";
  };

  # Settings
  extraConfig = ''
    set -g mouse on
    set -g base-index 1
  '';
};
```

## Customization Guide

### Quick Customizations

#### Change Default Editor

```nix
# In shell/nushell.nix
environmentVariables.EDITOR = "your-editor";
```

#### Add Custom Aliases

```nix
# In shell/nushell.nix
shellAliases = {
  # ... existing aliases
  mycommand = "your-custom-command";
};
```

#### Modify Starship Prompt

```nix
# In shell/starship.nix
settings = {
  # Change prompt character
  character.success_symbol = "[->](bold green)";

  # Disable modules
  nodejs.disabled = true;
};
```

#### Add Neovim Plugins

```nix
# In nixvim/plugins.nix
plugins = with pkgs.vimPlugins; [
  # ... existing plugins
  your-favorite-plugin
];
```

### Advanced Customizations

#### Create New Modules

1. Create file: `config/your-module.nix`
2. Add to imports in `home.nix`:

```nix
imports = [
  # ... existing imports
  ./config/your-module.nix
];
```

#### Conditional Configuration

```nix
# Based on system
config = lib.mkIf (pkgs.system == "x86_64-linux") {
  # Linux-specific configuration
};

# Based on user preference
config = lib.mkIf (your-preference) {
  # Conditional configuration
};
```

#### Override Package Settings

```nix
# Custom package configuration
nixpkgs.config = {
  allowUnfree = true;  # Allow unfree packages

  packageOverrides = pkgs: {
    your-package = pkgs.your-package.override {
      # Custom options
    };
  };
};
```

## Maintenance

### Updating Configuration

1. Edit relevant module files
2. Test changes: `home-manager switch --flake .#your-username`
3. Commit changes to git

### Adding New Languages

1. Add language server to `packages.nix`
2. Configure LSP in `nixvim/lsp.nix`
3. Add formatter if available
4. Test with sample project

### Performance Optimization

- Use `nix-direnv` for per-project environments
- Enable binary cache for faster builds
- Consider using `nh` for improved performance

## Further Reading

- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [NixVim Documentation](https://github.com/nix-community/nixvim)
- [Nix Flakes Guide](https://nixos.wiki/wiki/Flakes)
- [Nushell Book](https://www.nushell.sh/book/)
- [Starship Configuration](https://starship.rs/config/)
