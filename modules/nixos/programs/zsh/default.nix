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
      zsh =
        enabled
        // {
          autosuggestions =
            enabled
            // {
              async = true;
            };
          enableBashCompletion = true;
          enableCompletion = true;
          enableGlobalCompInit = true;
          ohMyZsh = enabled;
          syntaxHighlighting =
            enabled
            // {
              highlighters = [
                "main"
                "brackets"
              ];
            };
        };
    };
  };
}
