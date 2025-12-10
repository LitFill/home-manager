{ pkgs, ... }:
{
    extraPlugins = [
        pkgs.vimPlugins.stay-centered-nvim
        pkgs.vimPlugins.focus-nvim
    ];

    extraConfigLua = ''
        require "stay-centered" .setup {
            skip_filetypes = {""},
        }

        require "focus" .setup {
            ui = { colorcolumn = { enable = true } }
        }

        local trans = require "transparent"

        if vim.g.neovide then
            trans.toggle(false)
        else
            trans.toggle(true)
        end

        vim.api.nvim_set_hl(0, "MatchParen", { bg = "darkblue" })
    '';

    userCommands.Cd = {
        command = "cd %:h";
        nargs = 0;
        desc = "cd to current opened file";
    };
}
