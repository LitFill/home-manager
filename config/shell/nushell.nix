{ config, ... }:
{
    programs.nushell = {
        enable = true;
        environmentVariables = {
            EDITOR = "nvim";
            RUST_BACKTRACE = "1";
            LEDGER_FILE = "/home/litfill/finance/2025.journal";
            PNPM_HOME = "/home/litfill/.local/share/pnpm";
        };
        extraConfig =
            let
                sessionPaths = builtins.map (p: ''"${p}"'') config.home.sessionPath;
                pathList     = builtins.concatStringsSep " " sessionPaths;
            in
            ''
                $env.PATH = ($env.PATH | prepend [ ${pathList} ])

                # Custom functions, aliases, and other imperative commands can be placed here.
                # Home-manager now manages most of the shell configuration declaratively.

                use std/clip
                use std null_device

                def --env newdir [path : string] {
                    mkdir $path
                    cd $path
                }

                fastfetch --iterm /home/litfill/Gambar/ojou-red-flowers-katana.jpg --logo-width 36
            '';
        shellAliases = {
            hms = "home-manager switch";
        };
        settings = {
            history = {
                file_format = "sqlite";
                isolation = false;
                max_size = 10000000;
                sync_on_enter = true;
            };
            show_banner = false;
            recursion_limit = 100;
            edit_mode = "vi";
            cursor_shape = {
                emacs = "line";
                vi_insert = "line";
                vi_normal = "block";
            };
            completions = {
                algorithm = "substring";
                sort = "smart";
                case_sensitive = false;
                quick = true;
                partial = true;
            };
        };
    };
}
