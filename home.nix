{
  # config,
  # pkgs,
  ...
}:
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
    ./config/smos.nix
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
    ".config/nvim/lua/matugen-template.lua".source = ./files/matugen-template.lua;
    "stylua.toml".source = ./files/stylua.toml;
    "fourmolu.yaml".source = ./files/fourmolu.yaml;
    ".ocamlinit".text = ''
      #require "core.top";;
      #require "ppx_jane";;
      open Base;;
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
}
