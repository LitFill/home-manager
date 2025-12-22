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
    ];

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.11"; # Please read the comment before changing.

    home.sessionPath = [
        "/home/litfill/.apps"
        "/home/litfill/.local/bin"
        "/home/litfill/.cargo/bin"
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
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
