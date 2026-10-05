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
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."litfill" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Make the profile selector available to nixvim.nix
        extraSpecialArgs = {
          neovim-profile = "default";
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          nixvim.homeModules.nixvim
        ];
      };

      # Project-scoped tooling: `nix develop` gives you the toolchains the
      # editor expects without putting them in the home profile.
      devShells.${system}.default = pkgs.mkShell (
        import ./devshell.nix {
          inherit pkgs;
        }
      );
    };
}
