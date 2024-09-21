{ lib, ... }:
let
  inherit (lib) mkMerge;
  inherit (lib.caprinix) sharedNixConfig;
in
{
  config = mkMerge [
    sharedNixConfig
    {
      nix = {
        checkAllErrors = true;
        settings = {
          auto-optimise-store = true;
        };
        optimise = {
          dates = [ "daily" ];
          automatic = true;
        };
      };
    }
  ];
}
