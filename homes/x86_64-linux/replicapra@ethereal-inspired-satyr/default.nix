{lib, ...}: let
  inherit (lib.caprinix) enabled disabled;
in {
  config = {
    caprinix = {
      programs = {
        atuin = enabled;
        git = enabled;
        neovim = enabled;
        starship = enabled;
        tmux = enabled;
        zsh = enabled;
      };
      workbench =
        enabled
        // {
          vscode = disabled;
        };
    };
    programs.home-manager = enabled;
  };
}
