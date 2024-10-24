{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkAfter mkOption;
  inherit (lib.types) bool listOf str;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.virtualisation;
in
{
  options.caprinix.virtualisation = {
    enable = mkEnableOption "virtualisation";

    autoPrune = {
      enable = mkOption {
        type = bool;
        default = false;
        description = ''
          Whether to periodically prune Docker and Podman resources. If enabled, a
          systemd timer will run `docker system prune -f`
          as specified by the `dates` option.
        '';
      };

      flags = mkOption {
        type = listOf str;
        default = [ ];
        example = [ "--all" ];
        description = ''
          Any additional flags passed to {command}`docker system prune` and {command}`podman system prune`.
        '';
      };

      dates = mkOption {
        default = "weekly";
        type = str;
        description = ''
          Specification (in the format described by
          {manpage}`systemd.time(7)`) of the time at
          which the prune will occur.
        '';
      };
    };
  };

  config = mkIfEnabled cfg {
    virtualisation.containers = enabled;
  };
}
