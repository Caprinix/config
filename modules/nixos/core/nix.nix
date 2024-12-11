{lib, ...}: let
  inherit (lib) mkMerge;
  inherit (lib.caprinix) sharedNixConfig sharedNixpkgsConfig;
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
          dates = ["daily"];
          automatic = true;
        };
      }
    ];
    nixpkgs.config = sharedNixpkgsConfig;
  };
}
