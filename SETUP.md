# Home Manager Setup Guide

This comprehensive guide will help you set up this Home Manager configuration
on a new machine from scratch.

## Prerequisites

### Required
- **Linux system**
- **Git** for cloning the repository
- **User account** with sudo access (for shell setup)
- **Internet connection** for downloading packages

### Recommended
- **SSD storage** for better performance with Nix store
- **8GB+ RAM** for comfortable development
- **Modern terminal** with good Unicode support (Wezterm or Ghostty)

## Installation Steps

## Installation Steps

### Step 1: Install Nix with Flakes

If you don't have Nix installed, the recommended method is using Determinate
Systems' installer which includes flakes support:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

**Alternative methods:**
- **NixOS**: Nix is already installed, just ensure flakes are enabled
- **Package managers**: Some distributions have Nix packages (less recommended)

After installation, **restart your terminal** or run:
```bash
source ~/.nix-profile/etc/profile.d/nix-daemon.sh
```

Verify installation:
```bash
nix --version
nix flake --version
```

### Step 2: Clone the Configuration

Clone this repository to the standard Home Manager location:

```bash
git clone https://github.com/LitFill/home-manager.git ~/.config/home-manager
cd ~/.config/home-manager
```

**Optional:** If you want to create your own fork first:
```bash
# Fork on GitHub, then clone your fork
git clone https://github.com/YOUR_USERNAME/home-manager.git ~/.config/home-manager
cd ~/.config/home-manager
git remote add upstream https://github.com/LitFill/home-manager.git
```

### Step 3: Customize for Your User

This configuration is currently set up for user `litfill`. You need to update
it for your username.

#### Method A: Using sed (quick)
```bash
# Replace litfill with your username everywhere
sed -i 's/litfill/your-username/g' home.nix flake.nix
```

#### Method B: Manual editing (recommended)
Edit `home.nix` and update:
```nix
home.username = "your-username";
home.homeDirectory = "/home/your-username";
```

Edit `flake.nix` and update:
```nix
homeConfigurations."your-username" = home-manager.lib.homeManagerConfiguration {
```

Also update the email configuration in `home.nix`:
```nix
accounts.email.accounts."your-username" = {
  primary = true;
  realName = "Your Name";
  address = "your.email@example.com";
};
```

#### Method C: Using environment variables (advanced)
```bash
export YOUR_USERNAME="your-username"
sed -i "s/litfill/$YOUR_USERNAME/g" home.nix flake.nix
```

### Step 4: Build and Activate Configuration

Choose one of these methods to activate your configuration:

#### Method A: Home Manager (recommended)
```bash
home-manager switch --flake .#your-username
```

#### Method B: Nix build (manual)
```bash
# Build the configuration
nix build .#homeConfigurations."your-username".activationPackage

# Activate the configuration
./result/activate
```

#### Method C: nh helper (if installed)
```bash
nh home switch ~/.config/home-manager/
```

**What happens during activation:**
- Downloads and builds all packages
- Creates configuration files in your home directory
- Sets up shell integration
- Installs fonts and system configurations

**First activation may take 10-30 minutes** depending on your internet speed
and system performance.

### Step 5: Set Up Shell Integration

This configuration uses Nushell as the primary shell. To make it your default
shell:

```bash
# Add nushell to system shells (requires sudo)
echo "$(which nushell)" | sudo tee -a /etc/shells

# Change your default shell to nushell
chsh -s $(which nushell)
```

**Important:** After changing your shell, **log out and log back in** or
restart your terminal for changes to take effect.

**Alternative:** If you prefer to keep bash as default, you can still use
nushell by running `nu` in your terminal.

**Verify setup:**
```bash
# Check your shell
echo $SHELL

# Test nushell
nu --version
```

## Maintenance & Updates

### Updating Your Configuration

```bash
# Update all flake inputs (packages, home-manager, etc.)
nix flake update

# Rebuild and switch to updated configuration
home-manager switch --flake .#your-username
```

### Adding New Packages

1. Edit `config/packages.nix`
2. Add packages to the list: `your-package`
3. Rebuild: `home-manager switch --flake .#your-username`

### Customizing Components

| Component | File to Edit | What to Change |
|-----------|-------------|----------------|
| **Shell** | `config/shell/nushell.nix` | Nushell settings, aliases |
| **Prompt** | `config/shell/starship.nix` | Starship prompt configuration |
| **Editor** | `config/nixvim/` | Neovim plugins, settings |
| **Git** | `config/git.nix` | Git configuration, aliases |
| **Terminal** | `config/tmux.nix` | Tmux settings, keybindings |

### Checking Configuration Health

```bash
# Check flake for errors
nix flake check

# See what would be built (dry run)
home-manager build --flake .#your-username

# Check for outdated packages
nix flake update --recreate-lock-file
```

## Troubleshooting

### Common Issues & Solutions

#### Build Fails
```bash
# Check for syntax errors
nix flake check

# Verify username matches
grep "your-username" home.nix flake.nix

# Clear Nix cache and retry
nix store --gc
home-manager switch --flake .#your-username
```

#### Shell Issues
```bash
# Restart terminal after activation
# Verify shell is set correctly
echo $SHELL

# Test nushell manually
nu

# Check shell integration
home-manager switch --flake .#your-username
```

#### Language Server Problems
- **Haskell**: Ensure GHC and cabal are in your PATH
- **Rust**: Run `rustup update` after first activation
- **TypeScript**: Node.js should be available via nix

#### Permission Issues
```bash
# Fix file permissions
chmod -R u+w ~/.config/home-manager

# If shell change fails
sudo chsh -s $(which nushell) $USER
```

#### Performance Issues
- First build is always slow (caching)
- Subsequent builds are much faster
- Consider using `nix-direnv` for per-project environments

### Getting Help

1. **Check logs**: `home-manager switch --flake .#your-username -v`
2. **Search issues**: [GitHub Issues](https://github.com/LitFill/home-manager/issues)
3. **Documentation**:
   - [Home Manager](https://nix-community.github.io/home-manager/)
   - [NixVim](https://github.com/nix-community/nixvim)
   - [Nix Flakes](https://nixos.wiki/wiki/Flakes)

## Migration from Existing Setup

If you're migrating from an existing dotfiles setup:

### Backup Strategy
```bash
# Backup current configurations
cp -r ~/.config ~/.config.backup
cp -r ~/.local/share ~/.local.backup
cp ~/.bashrc ~/.bashrc.backup
cp ~/.profile ~/.profile.backup
```

### Migration Process
1. **Install this configuration** (follow steps above)
2. **Test thoroughly** before removing old configs
3. **Migrate custom settings** manually:
   - SSH keys: `~/.ssh/`
   - GPG keys: `~/.gnupg/`
   - Custom scripts: `~/.local/bin/`
4. **Remove old configs** only after confirming everything works

### Selective Migration
You can use this configuration alongside existing tools:
- Keep your old shell as default
- Use `nu` to try nushell
- Gradually migrate components you like
