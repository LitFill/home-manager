{ config, pkgs, ... }:
{
    home.username = "litfill";
    home.homeDirectory = "/home/litfill";

    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.11"; # Please read the comment before changing.

    home.packages = with pkgs; [
        htop
        fortune
        nixfmt
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
    };

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "LitFill";
                email = "marrazzy54@gmail.com";
            };
            init = {
                defaultBranch = "main";
            };
            "credential \"https://github.com\"" = {
                helper = "!/usr/bin/gh auth git-credential";
            };
            "credential \"https://gist.github.com\"" = {
                helper = "!/usr/bin/gh auth git-credential";
            };
            difftool = {
                prompt = false;
            };
            pager = {
                difftool = true;
            };
            diff = {
                tool = "difftastic";
                external = "difft";
            };
            pull = {
                ff = "only";
            };
            alias = {
                cv = "commit -v";
            };
        };
    };
}
