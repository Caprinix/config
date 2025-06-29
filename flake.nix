{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;

      src = builtins.path { path = ./.; name = "caprinix-config"; };

      snowfall = rec {
        namespace = "caprinix";

        meta = {    
          name = namespace;
          title = namespace;
        };
      };

      systems.modules.nixos = with inputs; [home-manager.nixosModules.home-manager];
    };
}