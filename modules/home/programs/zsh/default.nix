{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.zsh;
in {
  options.caprinix.programs.zsh = {
    enable = mkEnableOption "zsh";
  };

  config = mkIfEnabled cfg {
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        dotDir = ".config/zsh";
        history = {
          append = true;
          expireDuplicatesFirst = true;
          extended = true;
          ignoreDups = true;
          ignoreSpace = true;
          path = "${config.xdg.dataHome}/zsh/zshistory";
        };
        syntaxHighlighting =
          enabled
          // {
            highlighters = [
              "main"
              "brackets"
            ];
          };
        oh-my-zsh =
          enabled
          // {
            extraConfig = ''
              zstyle ':omz:update' mode auto
              zstyle ':omz:update' frequency 1
            '';
            plugins = [];
          };
      };
    };
  };
}
