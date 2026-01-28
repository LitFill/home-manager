{ lib, ... }:
{
  autoCmd =
    let
      mkAuCmd = desc: event: pattern: callback: {
        inherit
          desc
          event
          pattern
          callback
          ;
      };

      trimOnSafe = lib.nixvim.utils.mkRaw "require('mini.trailspace').trim";

      setupHaskell = lib.nixvim.utils.mkRaw ''
        function()
            local ht    = require "haskell-tools"
            local bufnr = vim.api.nvim_get_current_buf()
            local opt   = { buffer = bufnr }
            local set   = vim.keymap.set

            local nset = function(key, cmd, opts)
                set("n", key, cmd, opts)
            end

            ---@param desc string
            ---@return { buffer: number, desc: string}
            local desc = function(desc)
                opt.desc = desc
                return opt
            end

            vim.o.makeprg = "cabal $*"

            -- Leader-c mappings untuk Cabal
            nset("<Leader>cb", "<CMD>vs | term cabal build<CR>", desc "Cabal Build")
            nset("<Leader>cr", "<CMD>vs | term cabal run<CR>",   desc "Cabal Run")
            nset("<Leader>ct", "<CMD>vs | term cabal test<CR>",  desc "Cabal Test")
            nset("<Leader>cc", "<CMD>edit *.cabal<CR>",          desc "Open Cabal File")
            nset(
                "<leader>ci",
                "<CMD>vs | term cabal install --installdir=./bin --overwrite-policy=always<CR>",
                desc "Cabal Install in bin directory"
            )

            -- Leader-h mappings untuk Haskell Tools
            nset("<Leader>hh", ht.hoogle.hoogle_signature, desc "Hoogle Search")
            nset("<Leader>hr", ht.repl.toggle,             desc "Toggle REPL")
            nset("<Leader>ht", vim.lsp.buf.hover,          desc "Show Type Signature")
        end
      '';
      pathCrumb = lib.nixvim.utils.mkRaw ''
        function()
            vim.o.winbar = "%!g:GetShortPath()"
        end
      '';
      signColumn = lib.nixvim.utils.mkRaw ''
        function()
            if vim.bo.buftype == "" and vim.wo.signcolumn ~= "yes:2" then
                vim.opt.signcolumn = "yes:2"
            end
        end
      '';
      setupIdris2 = lib.nixvim.utils.mkRaw ''
        function()
            vim.o.makeprg = "idris2 $*"
        end
      '';
    in
    [
      (mkAuCmd "Trim on save" "BufWritePre" "*" trimOnSafe)
      (mkAuCmd "Setup Haskell" "FileType" [ "haskell" "cabal" "*.hs" "*.cabal" ] setupHaskell)
      (mkAuCmd "Setup Idris 2" "FileType" [ "idris" "idris2" "*.idr" "*.ipkg" ] setupIdris2)
      (mkAuCmd "Path Crumb on winbar" [ "BufEnter" "BufWinEnter" ] "*" pathCrumb)
      (mkAuCmd "Ensure signcolumn is always 'yes:2' in normal buffers" "BufEnter" "*" signColumn)
    ];
}
