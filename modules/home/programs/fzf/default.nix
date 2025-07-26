{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.fzf;
in {
  options.caprinix.programs.fzf = {
    enable = mkEnableOption "fzf";
  };

  config = mkIfEnabled cfg {
    programs = {
      fzf =
        enabled
        // {
          tmux = mkIfEnabled config.caprinix.programs.tmux {
            enableShellIntegration = true;
          };
        };
    };
  };
}
