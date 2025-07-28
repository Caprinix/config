{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    #region nix-community

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    #region caprinix

    caprinix-essentials.url = "github:caprinix/essentials";
    caprinix-essentials.inputs.nixpkgs.follows = "nixpkgs";
    caprinix-essentials.inputs.snowfall-lib.follows = "snowfall-lib";
    caprinix-essentials.inputs.treefmt-nix.follows = "treefmt-nix";

    caprinix-secrets.url = "github:caprinix/secrets";
    caprinix-secrets.inputs.nixpkgs.follows = "nixpkgs";
    caprinix-secrets.inputs.snowfall-lib.follows = "snowfall-lib";
    caprinix-secrets.inputs.treefmt-nix.follows = "treefmt-nix";
    caprinix-secrets.inputs.home-manager.follows = "home-manager";
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;

      src = builtins.path {
        path = ./.;
        name = "caprinix-snowfall-lib-starter";
      };

      snowfall = rec {
        namespace = "caprinix";

        meta = {
          name = namespace;
          title = namespace;
        };
      };
    };
  in
    lib.mkFlake {
      channels-config = lib.sharedNixpkgsConfig;

      systems.modules.nixos = with inputs; [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
        nix-index-database.nixosModules.nix-index
        caprinix-secrets.nixosModules.secrets
      ];

      homes.modules = with inputs; [
        impermanence.nixosModules.home-manager.impermanence
        nix-index-database.homeModules.nix-index
        caprinix-secrets.homeModules.secrets
      ];

      homes.users = lib.loadHomeSpecialArgs ./homes;

      deploy = lib.mkDeploy {};

      outputs-builder = channels: let
        treefmtEval = inputs.treefmt-nix.lib.evalModule channels.nixpkgs ./treefmt.nix;
      in {
        formatter = treefmtEval.config.build.wrapper;
      };
    };
}
