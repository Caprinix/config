{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.bat;
in {
  options.caprinix.programs.bat = {
    enable = mkEnableOption "bat";
  };

  config = mkIfEnabled cfg {
    programs = {
      bat =
        enabled
        // {
          extraPackages = with pkgs.bat-extras; [
            batwatch
            batpipe
            batman
            batgrep
            batdiff
          ];
        };
    };
  };
}
