{
  config,
  ...
}:
{
  programs.nushell = {
    enable = true;
    environmentVariables = {
      EDITOR = "nvim";
      RUST_BACKTRACE = "1";
      LEDGER_FILE = "/home/litfill/finance/2026.journal";
      PNPM_HOME = "/home/litfill/.local/share/pnpm";
    };
    extraConfig =
      let
        padding = "\n        ";
        intercalate = builtins.concatStringsSep;
        pathStr = map (p: ''"${p}"'') config.home.sessionPath;
        customPaths = intercalate padding pathStr;
      in
      /* nu */ ''
        $env.PATH = ($env.PATH | split row (char esep) | prepend [
                ${customPaths}
            ] | uniq)

        # Custom functions, aliases, and other imperative commands can be placed here.
        # Home-manager now manages most of the shell configuration declaratively.

        use std/clip
        use std null_device

        source ~/.config/nushell/functions.nu

        def --env newdir [path : string] {
            mkdir $path
            cd $path
        }

        # Initialize opam environment
        def --env load-opam [ --version : string = "" ] {
            let switch = if ($version | is-empty) { "default" } else { $version }
            let opam_env = (opam env --switch=($switch) --shell=powershell | parse "$env:{key} = '{val}'" | transpose -rd)
            load-env $opam_env
        }

        def unlines [] : list<string> -> string { str join "\n" }

        def show [fname: path] {
            let content = (
                open --raw $fname
                | lines
                | each { |line| $"    ($line)" }
                | unlines
            )
            $"($fname):\n\n($content)\n"
        }

        def glimpse [] {
            ls **/*
            | where type == file
            | get name
            | par-each { |file| show $file }
            | unlines
        }

        # Fuzzy find a directory and cd into it
        def --env lcd [path?: path] {
            let target: string = ($path | default ".")
            let dirs: table = (ls $target | where type == "dir" | sort-by name)

            if ($dirs | is-empty) {
                print $"(ansi yellow)No directories found in '(ansi green)($target)(ansi yellow)'.(ansi reset)"
                return
            }

            # fuzzy list returns the selected row from the table or null if cancelled
            let prompt: string = $"(ansi cyan)Select a directory in (ansi green)($target)(ansi cyan) to cd into:(ansi reset)"
            let selection: string = (
                $dirs | input list --fuzzy --display {
                    |it| $"(ansi yellow)($it.name)(ansi reset)"
                } $prompt
            )

            if $selection != null {
                cd $selection.name
            }
        }

        # List directories with indices and cd into the selected number
        def --env ncd [path?: path] {
            let target: string = ($path | default ".")
            let dirs: table = (ls $target | where type == "dir" | sort-by name)

            if ($dirs | is-empty) {
                print $"(ansi yellow)No directories found in '(ansi green)($target)(ansi yellow)'.(ansi reset)"
                return
            }

            # Display the directories with indices and colors
            let table_output: table = ($dirs | select name modified)

            print $table_output

            let choice: string = (input $"(ansi yellow)Enter the directory index: (ansi reset)")

            if ($choice | is-empty) {
                return
            }

            try {
                let idx: int = ($choice | into int)
                let selection: string = ($dirs | get $idx | get name)
                cd $selection
            } catch {
                print $"(ansi red_bold)Error:(ansi reset) Invalid index '($choice)'."
            }
        }

        # Direnv integration (Crucial for Nix)
        # NOTE: Requires 'direnv' in home.packages
        # programs.direnv = { enable = true; nix-direnv.enable = true; }; to config/shell.nix.
        #
        # source ("$\{pkgs.direnv}/share/direnv/direnv.nu") # Optional if manual

        # load-opam

        # FZF integration
        $env.FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git"
        $env.FZF_CTRL_T_COMMAND = "fd --type f --hidden --follow --exclude .git"

        fastfetch --iterm /home/litfill/Gambar/ojou-red-flowers-katana.jpg --logo-width 36
      '';
    shellAliases = {
      hms = "home-manager switch";

      g = "git";
      v = "nvim";
      la = "ls -a";

      # File Management aliases
      ll = "eza -la --git --icons";
      lt = "eza --tree --git --icons";
      cat = "bat --paging=never --style=header,grid";
      grep = "rg --pretty";
      find = "fd";

      # System information aliases
      top = "btop";
      df = "ncdu";
      du = "ncdu";

      # Task management aliases
      t = "task";
      tl = "timewarrior";

      # Quick access tools
      yz = "yazi";
      fm = "yazi";

      # Fuzzy finding
      fz = "fzf";

      # Pass aliases
      passgen = "^pass generate";
      passotp = "^pass otp";
      passls = "^pass ls";
      passshow = "^pass show";
      passedit = "^pass edit";
      passinsert = "^pass insert";
      passgrep = "^pass grep";
    };
    settings = {
      table = {
        mode = "light";
      };
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
