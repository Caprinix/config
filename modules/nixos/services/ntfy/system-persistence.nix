{
  systemConfig,
  lib,
  ...
}: let
  inherit (lib.caprinix) mkDynamicUserPath;
in {
  inherit (systemConfig.caprinix.services.ntfy) enable;
  directories = [
    {
      inherit (systemConfig.services.ntfy-sh) user group;
      directory =
        mkDynamicUserPath (builtins.dirOf systemConfig.services.ntfy-sh.settings.auth-file);
    }
  ];
}
