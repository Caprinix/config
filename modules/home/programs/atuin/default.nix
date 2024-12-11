{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.programs.atuin;
in {
  options.caprinix.programs.atuin = {
    enable = mkEnableOption "atuin";
  };

  config = mkIfEnabled cfg {
    programs = {
      atuin =
        enabled
        // {
          enableZshIntegration = true;
          settings = {
            style = "full";
            sync_frequency = "5m";
            filter_mode = "global";
            filter_mode_shell_up_key_binding = "session";
          };
        };
    };
  };
}
