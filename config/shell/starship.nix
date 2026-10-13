{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 20000;

      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };

      format = "$custom $all";
      directory.disabled = true;

      custom = {
        haskell_dir = {
          command = "echo $env.PWD | sed \"s:$HOME::g; s:/: -> :g; s:^ -> ::\"";
          when = "true";
          format = "[LitFill :: $output]($style)";
          style = "purple";
        };

        haskell_tilde = {
          command = "'~'";
          when = "test $env.PWD == $env.HOME";
          format = "[$output]($style)";
          style = "bold purple";
        };
      };
    };
  };
}
