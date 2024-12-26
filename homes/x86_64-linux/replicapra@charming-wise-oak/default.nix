{lib, ...}: let
  inherit (lib.caprinix) enabled;
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
    };
  };
}
