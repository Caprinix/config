{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;
  inherit
    (inputs.caprinix-settings.lib.vscode.helper)
    extensionStringToPackage
    getCombinedMixinExtensions
    mergeSettings
    getCombinedMixinSettings
    ;

  cfg = config.caprinix.workbench.vscode;

  extensions = map (mixin: extensionStringToPackage pkgs mixin) (getCombinedMixinExtensions [
    "base"
  ]);
  userSettings = mergeSettings [
    (getCombinedMixinSettings ["base"])
    (import ./userSettings.nix)
  ];
in {
  options.caprinix.workbench.vscode = {
    enable =
      mkEnableOption "vs-code"
      // {
        default = config.caprinix.workbench.enable;
      };
  };

  config = mkIfEnabled cfg {
    programs = {
      vscode =
        enabled
        // {
          inherit extensions userSettings;
          package = pkgs.vscode.fhs;
          enableExtensionUpdateCheck = false;
          enableUpdateCheck = false;
        };
    };
  };
}
