{
  programs.nushell = {
    enable = true;
    extraConfig = builtins.readFile ./config.nu;
    shellAliases = {
      hms = "home-manager switch";
    };
  };
}
