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

    # region caprinix 
    caprinix-secrets.url = "git+ssh://git@github.com/caprinix/secrets.git";
    caprinix-secrets.inputs.nixpkgs.follows = "nixpkgs";
    caprinix-secrets.inputs.snowfall-lib.follows = "snowfall-lib";

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
      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        caprinix-secrets.nixosModules.secrets
      ];

      homes.modules = with inputs; [ impermanence.nixosModules.home-manager.impermanence ];
    };
}
