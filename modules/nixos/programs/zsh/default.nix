{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.programs.zsh;
in {
  options.caprinix.programs.zsh = {
    enable = mkEnableOption "zsh";
  };

  config = mkIfEnabled cfg {
    users.users.replicapra.shell = pkgs.zsh;
    programs.zsh = enabled;
  };
}
