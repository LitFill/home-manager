{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.stay-centered-nvim
    pkgs.vimPlugins.focus-nvim

    (pkgs.vimUtils.buildVimPlugin {
      name = "koka-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "syaiful6";
        repo = "koka.nvim";
        rev = "c26bf5cf79cb12019b572ac7434e1d88ea561457";
        hash = "sha256-jyEf9q4tjm+mWAtaC0h/Nd0wSHg2EbZZNPl6RFd2U04=";
      };
    })
  ];

  extraConfigLua = ''
    require "stay-centered" .setup {
        skip_filetypes = {""},
    }

    require "focus" .setup {
        ui = { colorcolumn = { enable = true } }
    }

    -- local trans = require "transparent"

    -- if vim.g.neovide then
    --     trans.toggle(false)
    -- else
    --     trans.toggle(true)
    -- end

    vim.api.nvim_set_hl(0, "MatchParen", { bg = "darkblue" })

    -- matugen theming disabled for now (no themes generated currently)
    -- require "matugen" .setup()

    -- conjure's Common Lisp client calls `conjure.log.append` with a bare string
    -- when no swank connection is up, but the log API expects a list of lines.
    -- The client connects on every FileType lisp, so without this every .lisp
    -- buffer opens with an `ipairs` error in the log flush.
    local conjure_log = require "conjure.log"
    local conjure_log_append = conjure_log.append
    conjure_log.append = function(lines, opts)
      return conjure_log_append(type(lines) == "string" and { lines } or lines, opts)
    end
  '';

  userCommands.Cd = {
    command = "cd %:h";
    nargs = 0;
    desc = "cd to current opened file";
  };
}
