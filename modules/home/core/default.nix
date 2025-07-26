{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.snowfall.fs) get-non-default-nix-files;
  inherit (lib.caprinix-essentials.modules) enabled;
in {
  imports = get-non-default-nix-files ./.;

  config = {
    home.shell.enableShellIntegration = true;
    home.stateVersion = osConfig.system.stateVersion or "25.05";

    programs.home-manager = enabled;
    programs.nix-your-shell = enabled;
  };
}
