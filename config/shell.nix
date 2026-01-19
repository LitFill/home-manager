{
  imports = [
    ./shell/nushell.nix
    ./shell/starship.nix
  ];

  programs.broot = {
    enable = true;
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
}
