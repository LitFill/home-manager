{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # cabal-install
    # ghc
    # stack
    bash-language-server
    btop
    # caddy
    chez
    # direnv
    fastfetch
    fd
    fourmolu
    glow
    # gum
    haskell-language-server
    helix
    hledger
    hledger-iadd
    hledger-ui
    hledger-utils
    hledger-web
    hlint
    # idris2
    # idris2Packages.idris2Lsp
    idris2Packages.pack
    koka
    lua-language-server
    nerd-fonts.monaspace
    nh
    nil
    nixfmt
    nix-output-monitor
    # odin
    # pandoc
    puffin
    ripgrep
    rsync
    rustup
    shellcheck
    taplo
    tmux
    tree-sitter
    typescript-language-server
    typst
    uiua
    uiua386
    yaml-language-server
    # yaziPlugins.git

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
    # choose

    # System & Information Tools
    ncdu
    iotop
    nethogs
    lm_sensors

    # Task Management & Automation
    # taskwarrior2
    # timewarrior
    # cheat

    # Communication & Reference
    tealdeer

    # Security & Privacy
    pass
    gnupg

    # Media & Entertainment
    imv
    mpv

    # LISP
    sbcl
    asdf
    # roswell

    rlwrap
  ];
}
