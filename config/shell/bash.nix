{ ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    historyControl = [
      "ignoredups"
      "ignorespace"
    ];
    historySize = 10000;
    historyFileSize = 100000;

    # Same environment nushell gets from shell/nushell.nix.
    sessionVariables = {
      EDITOR = "nvim";
      RUST_BACKTRACE = "1";
      LEDGER_FILE = "/home/litfill/finance/2026.journal";
      PNPM_HOME = "/home/litfill/.local/share/pnpm";
    };

    # Mirrors the nushell shellAliases, minus nushell-only syntax
    # (nu's `^pass` external calls run directly in bash).
    shellAliases = {
      hms = "home-manager switch";

      g = "git";
      v = "nvim";
      la = "ls -a";
      ls = "ls --color=auto";

      # File Management aliases
      cat = "bat --paging=never --style=header,grid";
      ll = "eza -la --git --icons=auto";
      lt = "eza --tree --git --icons=auto";

      # System information aliases
      top = "btop";
      df = "ncdu";
      du = "ncdu";

      # Quick access tools
      yz = "yazi";
      fm = "yazi";

      # Fuzzy finding
      fz = "fzf";

      # On-demand banner. Nushell prints this at startup; bash does not,
      # because every subshell and tmux pane would pay for it.
      ff = "fastfetch --iterm /home/litfill/Gambar/ojou-red-flowers-katana.jpg --logo-width 36";

      # Pass aliases
      passgen = "pass generate";
      passotp = "pass otp";
      passls = "pass ls";
      passshow = "pass show";
      passedit = "pass edit";
      passinsert = "pass insert";
      passgrep = "pass grep";
    };

    initExtra = ''
      # vi editing mode, matching nushell's edit_mode = "vi"
      set -o vi

      # Append to the history file instead of clobbering it
      shopt -s histappend

      # GHCup environment (PATH entries already come from home.sessionPath)
      [ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

      # broot launcher
      [ -f "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"

      # Utility functions, the bash counterparts of files/functions.nu
      [ -f "$HOME/.bash_functions" ] && source "$HOME/.bash_functions"
    '';
  };
}
