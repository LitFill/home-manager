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

      setupHaskell = lib.nixvim.utils.mkRaw "require('setup_haskell')";
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
