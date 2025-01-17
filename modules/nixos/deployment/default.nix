{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled;

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
        commands = [
          {
            command = "/nix/store/*/activate-rs";
            options = ["NOPASSWD"];
          }
          {
            command = "${pkgs.coreutils}/bin/rm /tmp/deploy-rs-*";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };
}