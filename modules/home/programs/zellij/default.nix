{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.zellij;
in {
  options.caprinix.programs.zellij = {
    enable = mkEnableOption "zellij";
  };

  config = mkIfEnabled cfg {
    programs = {
      zellij = enabled // {};
    };
  };
}
