{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.direnv;
in {
  options.caprinix.programs.direnv = {
    enable = mkEnableOption "direnv";
  };

  config = mkIfEnabled cfg {
    programs = {
      direnv =
        enabled
        // {
          nix-direnv = enabled;
          inherit (config.caprinix.programs) mise;
          config = {
            global = {
              strict_env = true;
            };
            whitelist = {
              prefix = [
                "/home/replicapra/Projects/github.com/replicapra"
                "/home/replicapra/Projects/github.com/caprinix"
              ];
            };
          };
        };
    };
  };
}
