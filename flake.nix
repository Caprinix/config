{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # region nix-community
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;

      src = ./.;

      systems.modules.nixos = with inputs; [ home-manager.nixosModules.home-manager ];

      snowfall = rec {
        namespace = "caprinix";

        meta = {
          name = namespace;
          title = namespace;
        };
      };
    };
}
