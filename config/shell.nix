{
  imports = [
    ./shell/nushell.nix
    ./shell/starship.nix
  ];

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
