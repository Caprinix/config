{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled;

  cfg = config.caprinix.deployment;
in {
  options.caprinix.deployment = {
    enable = mkEnableOption "deployment";
  };

  config = mkIfEnabled cfg {
    users.groups.deployment = {};
    users.users.deployment = {
      isNormalUser = true;
      group = "deployment";
      extraGroups = [
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxakIX6l4Doi/QPTI884nLWyBeaPN96qcp46iUEuUa3 deployment@caprinix"
      ];
    };
    security.sudo.extraRules = [
      {
        users = ["deployment"];
        runAs = "root:root";
        commands = [
          {
            command = "/nix/store/*/activate-rs";
            options = ["NOPASSWD"];
          }
          {
            command = "/run/current-system/sw/bin/rm /tmp/deploy-rs-*";
            options = ["NOPASSWD"];
          }
          {
            command = "/run/current-system/sw/bin/reboot";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };
}
