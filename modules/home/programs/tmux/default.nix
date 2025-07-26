{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.tmux;

  extraConfig = builtins.readFile ./tmux-extra.conf;
in {
  options.caprinix.programs.tmux = {
    enable = mkEnableOption "tmux";
  };
  config = mkIfEnabled cfg {
    programs = {
      tmux =
        enabled
        // {
          inherit extraConfig;
          aggressiveResize = true;
          baseIndex = 1;
          clock24 = true;
          focusEvents = true;
          historyLimit = 10000;
          keyMode = "vi";
          mouse = true;
          prefix = "C-t";
          terminal = "screen-256color";
          tmuxinator = enabled;
          tmuxp = enabled;
        };
    };
  };
}
