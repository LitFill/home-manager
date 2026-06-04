{
  lib,
  # config,
  ...
}:
{
  globals = {
    mapleader = " ";
    maplocalleader = " ";

    neovide_opacity = 0.75;
    neovide_normal_opacity = 0.80;
    guifont = "JetBrainsMono NF:h14";

    GetShortPath = lib.nixvim.utils.mkRaw "require('get_short_path')";
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

  # colorschemes.bamboo.enable = true;
  colorschemes.base16.enable = true; # for noctalia matugen template
}
