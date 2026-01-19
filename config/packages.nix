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
    caddy
    chez
    direnv
    fastfetch
    fd
    fourmolu
    glow
    gum
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
    lua-language-server
    nerd-fonts.monaspace
    nh
    nil
    nixfmt
    pandoc
    puffin
    ripgrep
    rsync
    rustup
    shellcheck
    tmux
    typescript-language-server
    typst
    yaml-language-server
    yaziPlugins.git

    # Web Development LSP Servers
    html-tidy
    nodePackages_latest.vscode-langservers-extracted
    emmet-ls

    # Web Development Formatters
    nodePackages_latest.prettier
    nodePackages_latest.stylelint
    nodePackages_latest.js-beautify

    # Linting & Code Quality
    nodePackages_latest.eslint
    stylelint-lsp

    # Productivity & File Management
    yazi
    fzf
    bat
    eza
    delta
    sd
    choose

    # System & Information Tools
    ncdu
    iotop
    nethogs
    lm_sensors

    # Task Management & Automation
    taskwarrior2
    timewarrior
    cheat

    # Communication & Reference
    tldr

    # Security & Privacy
    pass
    gnupg

    # Media & Entertainment
    imv
    mpv
  ];
}
