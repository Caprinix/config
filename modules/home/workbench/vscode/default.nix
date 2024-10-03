{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.workbench.vscode;

  userSettings = import ./userSettings.nix;
in
{
  options.caprinix.workbench.vscode = {
    enable = mkEnableOption "vs-code" // {
      default = config.caprinix.workbench.enable;
    };
  };

  config = mkIfEnabled cfg {
    programs = {
      vscode = enabled // {
        inherit userSettings;
        package = pkgs.vscode.fhs;
      };
    };
  };
}
