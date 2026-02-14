{
  lib,
  neovim-profile ? "default",
  ...
}:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    imports = [
      ./nixvim/base.nix
      (
        let
          profilePath = ./nixvim/profiles + "/${neovim-profile}.nix";
        in
        if lib.pathExists profilePath then profilePath else ./nixvim/profiles/default.nix
      )
    ];

    filetype.extension.ua = "uiua";
  };
}
