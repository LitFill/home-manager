{
    description = "LitFill's Home Manager flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... }: {
        defaultPackage.x86_64-linux = home-manager.packages.x86_64-linux.default;

        homeConfigurations = {
            "litfill" = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux;
                modules = [ ./home.nix ];
            };
        };
    };
}
