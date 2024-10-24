{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.workbench.direnv;
in
{
  options.caprinix.workbench.direnv = {
    enable = mkEnableOption "direnv" // {
      default = config.caprinix.workbench.enable;
    };
  };

  config = mkIfEnabled cfg {
    programs = {
      direnv = enabled // {
        enableZshIntegration = true;
        nix-direnv = enabled;
        config = {
          whitelist = {
            prefix = [
              "/home/replicapra/Projects/replicapra"
            ];
          };
        };
      };
    };
  };
}
