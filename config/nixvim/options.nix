{ lib, config, ... }:
{
  globals = {
    mapleader = " ";
    maplocalleader = " ";

    neovide_opacity = 0.75;
    neovide_normal_opacity = 0.80;
    guifont = "JetBrainsMono NF:h14";

    GetShortPath = lib.nixvim.utils.mkRaw ''
      function()
          local buf_path = vim.api.nvim_buf_get_name(0)
          if buf_path == "" then
              return "" -- Jika buffer kosong, tidak tampilkan apa-apa
          end

          local home = vim.fn.expand "$HOME"
          local project_home = home .. "/proyek"

          if buf_path:find("^" .. vim.pesc(project_home)) then
              buf_path = buf_path:gsub("^" .. vim.pesc(project_home) .. "/", "")
          elseif buf_path:find("^" .. vim.pesc(home)) then
              buf_path = buf_path:gsub("^" .. vim.pesc(home) .. "/", "")
          end

          local display_path1 = buf_path:gsub("//", "/")
          local display_path = display_path1:gsub("/", " -> ")

          return "%#MiniIconsPurple#  LitFill :: " .. display_path
      end'';
  };

  diagnostic.settings = {
    virtual_lines = {
      current_line = true;
    };
    float = {
      border = "rounded";
      header = "";
      source = true;
    };
    severity_sort = true;
    underline = true;
    update_in_insert = false;
  };

  opts = {
    breakindent = true;
    clipboard = "unnamedplus";
    colorcolumn = "80,120,200";
    cursorline = true;
    expandtab = true;
    ignorecase = true;
    mouse = "a";
    shiftwidth = 4;
    signcolumn = "yes:2";
    smartcase = true;
    smartindent = true;
    splitbelow = true;
    splitright = true;
    tabstop = 4;
    termguicolors = true;
    undofile = true;
    updatetime = 300;
    winborder = "rounded";
    wrap = false;
  };

  colorschemes.bamboo.enable = true;

  # Auto-commands untuk LSP optimization
  autoCmd = [
    {
      event = "FileType";
      pattern = [
        "javascript"
        "typescript"
        "javascriptreact"
        "typescriptreact"
      ];
      callback = lib.nixvim.utils.mkRaw ''
        function()
            vim.opt_local.tabstop = 2
            vim.opt_local.shiftwidth = 2
            vim.opt_local.expandtab = true
        end
      '';
    }
    {
      event = "FileType";
      pattern = [
        "html"
        "css"
        "scss"
        "json"
        "yaml"
        "markdown"
      ];
      callback = lib.nixvim.utils.mkRaw ''
        function()
            vim.opt_local.tabstop = 2
            vim.opt_local.shiftwidth = 2
            vim.opt_local.expandtab = true
        end
      '';
    }
  ];
}
