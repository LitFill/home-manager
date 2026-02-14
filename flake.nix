{
  description = "Home Manager configuration of litfill";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
    smos.url = "github:NorfairKing/smos";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      smos,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."litfill" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # SANGAT PENTING: Gunakan extraSpecialArgs untuk mengirimkan
        # variabel 'smos' dan 'system' ke dalam modul-modul .nix lainnya
        extraSpecialArgs = {
          inherit
            inputs
            system
            smos
            ;
          neovim-profile = "default";
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          nixvim.homeModules.nixvim
        ];
      };
    };
}
