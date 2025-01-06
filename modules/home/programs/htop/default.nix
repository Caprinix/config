{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.programs.htop;
in {
  options.caprinix.programs.htop = {
    enable = mkEnableOption "htop";
  };

  config = mkIfEnabled cfg {
    programs = {
      htop =
        enabled;
    };
  };
}
