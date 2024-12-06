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

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # region caprinix 
    caprinix-secrets.url = "github:caprinix/secrets";
    caprinix-secrets.inputs.nixpkgs.follows = "nixpkgs";
    caprinix-secrets.inputs.snowfall-lib.follows = "snowfall-lib";

    caprinix-settings.url = "github:caprinix/settings";
    caprinix-settings.inputs.nixpkgs.follows = "nixpkgs";
    caprinix-settings.inputs.snowfall-lib.follows = "snowfall-lib";

    caprinix-devenv.url = "github:caprinix/devenv";

    # region misc 
    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    let
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

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        caprinix-secrets.nixosModules.secrets
      ];

      homes.modules = with inputs; [ impermanence.nixosModules.home-manager.impermanence ];

      homes.users = {
        "replicapra@wandering-bendy-snake".specialArgs = {
          osConfig = {
            system.stateVersion = "24.05";
            virtualisation.podman.enable = true;
            virtualisation.docker.enable = true;
          };
        };
        "replicapra@wandering-cunning-dragon".specialArgs = {
          osConfig = {
            system.stateVersion = "24.05";
            virtualisation.podman.enable = false;
            virtualisation.docker.enable = true;
          };
        };
      };

      overlays = with inputs; [
        nur.overlay
        caprinix-devenv.overlays.default
        nix-vscode-extensions.overlays.default
      ];

      outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };
    };
}
