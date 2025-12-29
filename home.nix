{
    # config,
    # pkgs,
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
        ./config/packages.nix
        ./config/tmux.nix
    ];

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.11"; # Please read the comment before changing.

    home.shell.enableNushellIntegration = true;
    home.sessionPath = [
        "/home/litfill/.apps"
        "/home/litfill/.cabal/bin"
        "/home/litfill/.cargo/bin"
        "/home/litfill/.ghcup/bin"
        "/home/litfill/.local/bin"
        "/home/litfill/.local/share/pnpm"
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
        "fourmolu.yaml".text = ''
            # Generated from web app, for more information, see: https://fourmolu.github.io/config/
            indentation:                4
            column-limit:               80
            function-arrows:            leading-args
            comma-style:                leading
            record-style:               aligned
            import-export-style:        leading
            import-grouping:            by-scope-then-qualified
            indent-wheres:              false
            record-brace-space:         true
            newlines-between-decls:     2
            haddock-style:              multi-line
            haddock-style-module:       multi-line
            haddock-location-signature: trailing
            let-style:                  auto
            in-style:                   right-align
            if-style:                   indented
            single-constraint-parens:   always
            single-deriving-parens:     always
            sort-constraints:           true
            sort-derived-classes:       true
            sort-deriving-clauses:      true
            trailing-section-operators: true
            unicode:                    never
            respectful:                 true
        '';
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
