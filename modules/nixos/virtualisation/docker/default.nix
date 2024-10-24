{
  lib,
  config,
  pkgs,
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

    environment.systemPackages = with pkgs; [
      dive
      lazydocker
    ];

    users.users = {
      replicapra = {
        extraGroups = [
          "docker"
        ];
      };
    };
  };
}
