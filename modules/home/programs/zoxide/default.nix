{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.zoxide;
in {
  options.caprinix.programs.zoxide = {
    enable = mkEnableOption "zoxide";
  };

  config = mkIfEnabled cfg {
    programs = {
      zoxide = enabled;
    };
  };
}
