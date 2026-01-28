{
  # pkgs,
  # lib,
  smos,
  system,
  ...
}:
let
  smosModule = smos.homeManagerModules.${system}.default;
in
{
  imports = [ smosModule ];
  programs.smos = {
    enable = true;
  };
}
