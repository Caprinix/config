{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.virtualisation.docker;
in
{
  options.caprinix.virtualisation.docker = {
    enable = mkEnableOption "docker";
  };

  config = mkIfEnabled cfg {
    virtualisation.docker = enabled // {
      autoPrune = config.caprinix.virtualisation.autoPrune;
    };

    users.users = {
      replicapra = {
        extraGroups = [
          "docker"
        ];
      };
    };
  };
}
