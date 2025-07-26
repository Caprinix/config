{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.script-directory;
in {
  options.caprinix.programs.script-directory = {
    enable = mkEnableOption "script-directory";
  };

  config = mkIfEnabled cfg {
    programs = {
      script-directory =
        enabled
        // {
          settings = {
            SD_ROOT = "${config.home.homeDirectory}/.script-directory";
          };
        };
      zsh = {
        # initExtra = ''
        #   fpath+="${pkgs.script-directory}/share/zsh/site-functions"
        # '';
      };
    };
  };
}
