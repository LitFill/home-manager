{ config, pkgs, ... }: {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "litfill";
    home.homeDirectory = "/home/litfill";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "25.11";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    programs.git = {
        enable = true;
        includes = [
            { path = "~/.gitconfig"; }
        ];
        settings = {
            pull.ff = "only";
            alias = {
                cv = "commit -v";
            };
        };
    };
}
