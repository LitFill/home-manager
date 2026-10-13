{ ... }:
{
  home.username = "litfill";
  home.homeDirectory = "/home/litfill";
  accounts.email.accounts."litfill" = {
    primary = true;
    realName = "LitFill";
    address = "marrazzy54@gmail.com";
  };

  imports = [
    ./config/git.nix
    ./config/shell.nix
    ./config/nixvim.nix
    ./config/packages.nix
    ./config/tmux.nix
    ./config/security.nix
    ./config/omp.nix
  ];

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.shell.enableNushellIntegration = true;
  home.sessionPath = [
    "/home/litfill/.apps"
    "/home/litfill/.cabal/bin"
    "/home/litfill/.cargo/bin"
    "/home/litfill/.ghcup/bin"
    "/home/litfill/.local/bin"
    "/home/litfill/.local/share/pnpm"
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    "stylua.toml".source = ./files/stylua.toml;
    "fourmolu.yaml".source = ./files/fourmolu.yaml;
    ".bash_functions".source = ./files/functions.bash;
    ".ocamlinit".text = ''
      #require "core.top";;
      #require "ppx_jane";;
      open Base;;
    '';
  };

  xdg.configFile = {
    "nushell/functions.nu".source = ./files/functions.nu;
    "nvim/lua/get_short_path.lua".source = ./files/nvim/get_short_path.lua;
    "nvim/lua/setup_haskell.lua".source = ./files/nvim/setup_haskell.lua;

    # "nvim/lua/matugen-template.lua".source =  # matugen theming disabled for now
    #   ./files/matugen-template.lua;

    # Io programming language syntax (vimscript); ~/.config/nvim is the
    # first entry of nvim's default runtimepath, so syntax/io.vim is found.
    "nvim/syntax/io.vim".source = ./files/nvim/syntax/io.vim;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
}
