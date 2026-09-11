{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    bash-language-server
    btop
    chez
    fastfetch
    fd
    fourmolu
    glow
    haskell-language-server
    helix
    hledger
    hledger-iadd
    hledger-ui
    hledger-utils
    hledger-web
    hlint
    idris2Packages.pack
    lua-language-server
    nerd-fonts.monaspace
    nh
    nil
    nixfmt
    nix-output-monitor
    puffin
    ripgrep
    rsync
    rustup
    shellcheck
    taplo
    tmux
    tree-sitter
    typescript
    typescript-language-server
    astro-language-server
    typst
    uiua
    uiua386
    yaml-language-server

    # Web Development LSP Servers
    html-tidy
    vscode-langservers-extracted
    emmet-ls

    # Web Development Formatters
    prettier
    stylelint
    js-beautify

    # Linting & Code Quality
    eslint
    stylelint-lsp

    # Productivity & File Management
    yazi
    fzf
    bat
    eza
    delta
    sd

    # System & Information Tools
    ncdu
    iotop
    nethogs
    lm_sensors

    # Communication & Reference
    tealdeer

    # Security & Privacy
    pass
    passExtensions.pass-otp
    gnupg

    # Media & Entertainment
    imv
    mpv

    # LISP
    sbcl
    asdf

    rlwrap
  ];
}
