{ pkgs, ... }:
let
  nvimkoka = pkgs.vimUtils.buildVimPlugin {
    name = "koka-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "syaiful6";
      repo = "koka.nvim";
      rev = "c26bf5cf79cb12019b572ac7434e1d88ea561457";
      hash = "sha256-jyEf9q4tjm+mWAtaC0h/Nd0wSHg2EbZZNPl6RFd2U04=";
    };
  };
in
{
  extraPlugins = [
    pkgs.vimPlugins.stay-centered-nvim
    pkgs.vimPlugins.focus-nvim

    nvimkoka
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

    require "matugen" .setup()
  '';

  userCommands.Cd = {
    command = "cd %:h";
    nargs = 0;
    desc = "cd to current opened file";
  };
}
