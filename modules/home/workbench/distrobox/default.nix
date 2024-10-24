{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled;

  cfg = config.caprinix.workbench.distrobox;
in
{
  options.caprinix.workbench.distrobox = {
    enable = mkEnableOption "distrobox" // {
      default = config.caprinix.workbench.enable;
    };
  };

  config = mkIfEnabled cfg {
    home.packages = with pkgs; [
      distrobox
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
