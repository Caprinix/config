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
      programs = {
        zsh = enabled;
        steam = enabled;
      };
      services = {
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
