{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled;

  cfg = config.caprinix.workbench;
in
{
  options.caprinix.workbench = {
    enable = mkEnableOption "workbench";
  };

  config = mkIfEnabled cfg {
    home.packages = with pkgs; [
      devbox
      devenv
    ];
  };
}
