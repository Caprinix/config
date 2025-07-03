{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
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
      outputs-builder = channels: let
        treefmtEval = inputs.treefmt-nix.lib.evalModule channels.nixpkgs ./treefmt.nix;
      in {
        formatter = treefmtEval.config.build.wrapper;
      };
    };
}
