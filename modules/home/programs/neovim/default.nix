{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.neovim;
in {
  options.caprinix.programs.neovim = {
    enable = mkEnableOption "nvim";
  };

  config = mkIfEnabled cfg {
    programs = {
      neovim =
        enabled
        // {
          defaultEditor = true;
          viAlias = true;
          vimAlias = true;
          vimdiffAlias = true;
        };
    };
  };
}
