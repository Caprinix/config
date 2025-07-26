{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.ssh;
in {
  options.caprinix.programs.ssh = {
    enable = mkEnableOption "ssh";
  };

  config = mkIfEnabled cfg {
    programs = {
      ssh =
        enabled
        // {
          package = pkgs.openssh;
          hashKnownHosts = true;
        };
    };
  };
}
