{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge;
  inherit (lib.caprinix.shared.programs) sharedZshConfig;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.zsh;
in {
  options.caprinix.programs.zsh = {
    enable = mkEnableOption "zsh";
  };

  config = mkIfEnabled cfg {
    programs = {
      zsh = mkMerge [
        enabled
        sharedZshConfig
        {
          autosuggestions = {
            async = true;
          };
          enableBashCompletion = true;
          enableGlobalCompInit = true;
        }
      ];
    };

    environment.pathsToLink = ["/share/zsh"];
  };
}
