{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkMerge types;
  inherit (lib.caprinix) sharedNixConfig sharedNixpkgsConfig;

  cfg = config.nix;
in {
  options.nix = {
    gc = {
      # small workaround as it's called gc.dates
      # in nixos but gc.frequency in home-manger
      dates = mkOption {type = types.str;};
    };
  };

  config = {
    nix = mkMerge [
      sharedNixConfig
      {
        gc = {
          frequency = cfg.gc.dates;
        };
      }
      (lib.optionalAttrs (config.sops.secrets ? "nix/secret-config") {
        extraOptions = ''
          !include ${config.sops.secrets."nix/secret-config".path}
        '';
      })
    ];
    nixpkgs.config = sharedNixpkgsConfig;
    xdg.configFile."nixpkgs/config.nix".text =
      lib.generators.toPretty {
        multiline = true;
      }
      sharedNixpkgsConfig;
  };
}
