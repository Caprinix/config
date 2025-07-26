{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled;

  cfg = config.caprinix.programs.podman;
in {
  options.caprinix.programs.podman = {
    enable = mkEnableOption "podman";
  };

  config = mkIfEnabled cfg {
    home.packages = with pkgs; [
      fetchit
      podman-tui
    ];
  };
}
