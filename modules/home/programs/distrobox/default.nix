{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.distrobox;
in {
  options.caprinix.programs.distrobox = {
    enable = mkEnableOption "distrobox";
    containers = mkOption {
      type = types.attrs;
      default = {};
    };
  };

  config = mkIfEnabled cfg {
    programs = {
      distrobox =
        enabled
        // {
          inherit (cfg) containers;
          enableSystemdUnit = true;
        };
    };
    home.packages = with pkgs; [
      distrobox-tui
    ];

    assertions = [
      {
        assertion = osConfig.virtualisation.podman.enable || osConfig.virtualisation.docker.enable;
        message = "Distrobox needs a container manager. Please install one of podman or docker";
      }
    ];
  };
}
