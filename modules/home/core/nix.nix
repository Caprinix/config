{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkOption mkMerge types;
  inherit (lib.caprinix) sharedNixConfig;

  cfg = config.nix;
in
{
  options.nix = {
    gc = {
      # small workaround as it's called gc.dates
      # in nixos but gc.frequency in home-manger 
      dates = mkOption { type = types.str; };
    };
  };

  config = mkMerge [
    sharedNixConfig

    {
      nix = {
        checkConfig = true;
        gc = {
          automatic = true;
          frequency = cfg.gc.dates;
          options = "--delete-older-than 3d";
          persistent = true;
        };
      };
    }
  ];
}
