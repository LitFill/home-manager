{ ... }:
{
    programs.nixvim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        imports = [
            ({ config, lib, ... }: import ./nixvim/options.nix { inherit config lib; })
            ./nixvim/lsp.nix
            ./nixvim/plugins.nix
            ./nixvim/keymaps.nix
            ./nixvim/autocmds.nix
            ./nixvim/extra.nix
        ];
    };
}
