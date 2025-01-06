{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # region nix-community
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    nur.url = "github:nix-community/nur";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    nur.inputs.treefmt-nix.follows = "treefmt-nix";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # region caprinix
    caprinix-secrets.url = "github:caprinix/secrets";
    caprinix-secrets.inputs.nixpkgs.follows = "nixpkgs";
    caprinix-secrets.inputs.snowfall-lib.follows = "snowfall-lib";
    caprinix-secrets.inputs.treefmt-nix.follows = "treefmt-nix";

    caprinix-settings.url = "github:caprinix/settings";
    caprinix-settings.inputs.nixpkgs.follows = "nixpkgs";
    caprinix-settings.inputs.snowfall-lib.follows = "snowfall-lib";

    caprinix-devenv.url = "github:caprinix/devenv";

    # region misc
    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;

      src = ./.;

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

      overlays = with inputs; [
        nur.overlays.default
        caprinix-devenv.overlays.default
        nix-vscode-extensions.overlays.default
      ];

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        {
          home-manager.backupFileExtension = "home-manager-backup";
        }
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        caprinix-secrets.nixosModules.secrets
      ];

      homes.modules = with inputs; [
        impermanence.nixosModules.home-manager.impermanence
        caprinix-secrets.homeModules.secrets
      ];

      homes.users = lib.loadSpecialArgs ./homes;

      deploy = {
        nodes = {};
      };

      outputs-builder = channels: let
        treefmtEval = inputs.treefmt-nix.lib.evalModule channels.nixpkgs ./treefmt.nix;
      in {
        formatter = treefmtEval.config.build.wrapper;
      };
    };
}
