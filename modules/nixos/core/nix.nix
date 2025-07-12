{lib, ...}: let
  inherit (lib) mkMerge;
  inherit (lib.caprinix) sharedNixConfig;
in {
  config = {
    nix = mkMerge [
      sharedNixConfig
      {
        checkAllErrors = true;
        settings = {
          auto-optimise-store = true;
        };
        optimise = {
          dates = "daily";
          automatic = true;
          persistent = true;
          randomizedDelaySec = "900";
        };
      }
    ];
  };
}
