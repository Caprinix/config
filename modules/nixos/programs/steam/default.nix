{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.programs.steam;
in {
  options.caprinix.programs.steam = {
    enable = mkEnableOption "steam";
  };
  config = mkIfEnabled cfg {
    programs.steam =
      enabled
      // {
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
    environment.systemPackages = with pkgs; [
      steam-run
      steam-tui
      steamcmd
    ];
  };
}
