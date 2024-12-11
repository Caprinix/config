{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.programs.tmux;
in {
  options.caprinix.programs.tmux = {
    enable = mkEnableOption "tmux";
  };
  config = mkIfEnabled cfg {
    programs = {
      tmux =
        enabled
        // {
          baseIndex = 1;
          clock24 = true;
          mouse = true;
          keyMode = "vi";
          prefix = "C-t";
          shell = mkIfEnabled config.caprinix.programs.zsh "${pkgs.zsh}/bin/zsh";
          terminal = "screen-256color";
          tmuxinator = enabled;
          tmuxp = enabled;
        };
    };
  };
}
