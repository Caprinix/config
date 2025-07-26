{lib, ...}: let
  inherit (lib.snowfall.attrs) merge-deep;
  inherit (lib.snowfall.fs) get-non-default-nix-files;
in {
  shared = merge-deep (builtins.map (path: import path {inherit lib;}) (get-non-default-nix-files ./.));
}
