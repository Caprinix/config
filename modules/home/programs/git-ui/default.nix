{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.git-ui;
in {
  options.caprinix.programs.git-ui = {
    enable = mkEnableOption "git-ui";
  };

  config = mkIfEnabled cfg {
    programs = {
      gitui = enabled;
      lazygit = enabled;
      gh =
        enabled
        // {
          extensions = with pkgs; [
            gh-dash
            gh-eco
          ];
          gitCredentialHelper = enabled;
          settings = {
            git_protocol = "ssh";
          };
        };
      gh-dash = enabled;
    };

    assertions = [
      {
        assertion = config.programs.git.enable;
        message = "git-ui needs git to be installed";
      }
    ];
  };
}
