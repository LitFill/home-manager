{
    programs = {
        nushell = { enable = true;
            # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
            # configFile.source = ./.../config.nu;
            # for editing directly to config.nu
            extraConfig = ''
                let carapace_completer = {|spans|
                    carapace $spans.0 nushell ...$spans | from json
                }
                $env.PATH = ( $env.PATH
                            | split row (char esep)
                            | prepend /home/litfill/.apps
                            | append /usr/bin/env
                            )
                use std/clip
                use std null_device

                def --env newdir [path : string] {
                    mkdir $path
                    cd $path
                }

                $env.config.history.file_format   = "sqlite"
                $env.config.history.isolation     = false
                $env.config.history.max_size      = 10_000_000
                $env.config.history.sync_on_enter = true

                $env.config.show_banner = false

                $env.config.recursion_limit = 100

                $env.config.edit_mode = "vi"

                $env.config.cursor_shape.emacs     = "line"
                $env.config.cursor_shape.vi_insert = "line"
                $env.config.cursor_shape.vi_normal = "block"

                source ~/.zoxide.nu

                use '/home/litfill/.config/broot/launcher/nushell/br' *

                # Added by Gemini to run fastfetch on Nushell startup
                fastfetch --iterm /home/litfill/Gambar/ojou-red-flowers-katana.jpg --logo-width 36

                $env.config.completions.algorithm      = "substring"
                $env.config.completions.sort           = "smart"
                $env.config.completions.case_sensitive = false
                $env.config.completions.quick          = true
                $env.config.completions.partial        = true

                $env.EDITOR = "nvim"

                zoxide init nushell | save -f ~/.zoxide.nu

                # hledger journal
                $env.LEDGER_FILE = "/home/litfill/finance/2025.journal"

                let local_bin = "/home/litfill/.local/bin"
                $env.PATH     = ($env.PATH | split row (char esep) | prepend $local_bin )

                let rust_bin = "/home/litfill/.cargo/bin"
                $env.PATH    = ($env.PATH | split row (char esep) | prepend $rust_bin )

                # pnpm
                $env.PNPM_HOME = "/home/litfill/.local/share/pnpm"
                $env.PATH = ($env.PATH | split row (char esep) | prepend $env.PNPM_HOME )
                # pnpm end
            '';
            shellAliases = {
                hms = "home-manager switch";
            };
        };
        carapace.enable = true;
        carapace.enableNushellIntegration = true;

        starship = { enable = true;
            settings = {
                add_newline = true;

                character = {
                    success_symbol = "[λ](bold green)";
                    error_symbol   = "[λ](bold red)";
                };

                format = "$custom $all";
                directory.disabled = true;

                custom = {
                    haskell_dir = {
                        command = ''
                            echo $env.PWD | sed $"s:($env.HOME)::g; s:/: -> :g; s:^ -> ::"
                            '';
                        # Always run this command
                        when   = "true";
                        format = "[LitFill :: $output]($style)";
                        style  = "purple"; # You can choose any color/style here
                    };

                    haskell_tilde = {
                        command = "'~'";
                        when    = "test $env.PWD == $env.HOME";
                        format  = "[$output]($style)";
                        style   = "bold purple";
                    };
                };
            };
        };
    };
}
