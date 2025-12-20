{
    # config,
    pkgs,
    ...
}:
{
    home.username = "litfill";
    home.homeDirectory = "/home/litfill";
    accounts.email.accounts."litfill" = {
        primary = true;
        realName = "LitFill";
        address = "marrazzy54@gmail.com";
    };

    imports = [
        ./config/git.nix
        ./config/shell.nix
        ./config/nixvim.nix
    ];

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.11"; # Please read the comment before changing.

    home.packages = with pkgs; [
        bash-language-server
        btop
        fastfetch
        gum
        haskell-language-server
        helix
        hledger
        hledger-iadd
        hledger-ui
        hledger-utils
        hledger-web
        hlint
        idris2
        lua-language-server
        nixfmt
        pandoc
        puffin
        rustup
        shellcheck
        typescript-language-server
        typst
        yaml-language-server
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
        "stylua.toml".text = ''
            # Konfigurasi untuk StyLua
            column_width     = 80
            indent_type      = "Spaces"
            indent_width     = 4
            call_parentheses = "None"
        '';
    };

    home.sessionVariables = {
        EDITOR = "nvim";
        RUST_BACKTRACE = 1;
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
