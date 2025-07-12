{lib, ...}: let
  inherit (lib.snowfall.fs) get-non-default-nix-files;
in {
  imports = get-non-default-nix-files ./.;
}
