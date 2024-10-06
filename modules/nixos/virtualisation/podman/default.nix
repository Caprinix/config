{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.virtualisation.podman;
in
{
  options.caprinix.virtualisation.podman = {
    enable = mkEnableOption "podman";
  };

  config = mkIfEnabled cfg {
    virtualisation.podman = enabled // {
      autoPrune = config.caprinix.virtualisation.autoPrune;
    };

    users.users = {
      replicapra = {
        extraGroups = [
          "podman"
        ];
      };
    };
  };
}
