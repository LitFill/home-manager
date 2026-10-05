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
    filetype.extension.kk = "koka";

    # Neovim already maps .lisp, .lsp, .asd and .cl to the `lisp` filetype;
    # these two Common Lisp extensions it leaves alone.
    filetype.extension.sbcl = "lisp";
    filetype.extension.ros = "lisp";
  };
}
