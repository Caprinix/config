{lib, ...}: let
  inherit (lib.caprinix) enabled systems;
in {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./persistence.nix
  ];

  config = {
    caprinix = {
      disko =
        enabled
        // {
          layout = "impermanence";
          args = {
            device = "/dev/sda";
          };
        };
      impermanence = enabled;
      persistence = enabled;
      deployment = enabled;
      programs = {
        zsh = enabled;
        steam = enabled;
      };
      services = {
        tailscale = enabled;
        openssh =
          enabled
          // {
            authorizedKeys = [
              systems.wandering-woof-scorebook.sshPublicKey
            ];
          };
      };
      virtualisation =
        enabled
        // {
          autoPrune =
            enabled
            // {
              dates = "daily";
            };
          podman = enabled;
          docker = enabled;
          qemu = enabled;
        };
    };
  };
}
