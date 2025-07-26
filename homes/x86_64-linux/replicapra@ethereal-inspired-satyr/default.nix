{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.caprinix-essentials.modules) enabled;
in {
  config = {
    caprinix = {
      programs = {
        atuin = enabled;
        bat = enabled;
        direnv = enabled;
        fzf = enabled;
        git = enabled;
        git-ui = enabled;
        mise = enabled;
        neovim = enabled;
        script-directory = enabled;
        ssh = enabled;
        starship = enabled;
        tmux = enabled;
        zellij = enabled;
        zoxide = enabled;
        zsh = enabled;
      };
    };
    home.packages = with pkgs; [
      devenv
      devbox
    ];
  };
}
