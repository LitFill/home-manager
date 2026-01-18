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
  ];
}
