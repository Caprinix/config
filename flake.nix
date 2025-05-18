{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    #region snowfallorg
    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    # region nix-community
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #region misc
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
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

       systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
      ];

      outputs-builder = channels: let
        treefmtEval = inputs.treefmt-nix.lib.evalModule channels.nixpkgs ./treefmt.nix;
      in {
        formatter = treefmtEval.config.build.wrapper;
      };
    };
}
