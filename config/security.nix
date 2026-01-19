{ config, pkgs, ... }:
{
  # Password manager with pass
  programs.password-store.enable = true;

  # Password management tools included in main packages

  # GPG configuration
  programs.gpg = {
    enable = true;
    homedir = "${config.home.homeDirectory}/.gnupg";
  };

  # Shell integration for pass
  programs.bash.initExtra = ''
    # Pass completion for bash
    source ${pkgs.pass}/etc/bash-completion.d/pass
  '';

  # Git integration for pass
  programs.git.settings = {
    gpg = {
      program = "${pkgs.gnupg}/bin/gpg";
    };
  };
}
