{ ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    imports = [ ./nixvim/base.nix ];

    filetype.extension.ua = "uiua";
  };
}
