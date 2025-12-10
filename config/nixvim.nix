{ ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    imports = [
      ./nixvim/options.nix
      ./nixvim/lsp.nix
      ./nixvim/plugins.nix
      ./nixvim/keymaps.nix
      ./nixvim/autocmds.nix
      ./nixvim/extra.nix
    ];
  };
}
