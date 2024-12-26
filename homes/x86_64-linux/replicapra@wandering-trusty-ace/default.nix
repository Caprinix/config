{lib, ...}: let
  inherit (lib.caprinix) enabled;
in {
  imports = [./persistence.nix];

  config = {
    caprinix = {
      programs = {
        atuin = enabled;
        firefox = enabled;
        git = enabled;
        neovim = enabled;
        starship = enabled;
        tmux = enabled;
        zsh = enabled;
      };
      workbench = enabled;
      persistence = enabled;
    };
  };
}
