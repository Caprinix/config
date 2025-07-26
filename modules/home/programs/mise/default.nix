{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.mise;
in {
  options.caprinix.programs.mise = {
    enable = mkEnableOption "mise";
  };

  config = mkIfEnabled cfg {
    programs = {
      mise =
        enabled
        // {
          settings = {
            activate_aggressive = true;
            cache_prune_age = "3d";
            experimental = true;
            paranoid = true;
            go_default_packages_file = "${config.xdg.configHome}/mise/go_default_packages";
          };
        };
    };
  };
}
