{lib, ...}: let
  inherit (lib.caprinix) enabled systems;
in {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
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
      services = {
        tailscale = enabled;
        openssh =
          enabled
          // {
            authorizedKeys = [
              systems.wandering-woof-scorebook.sshPublicKey
              systems.ethereal-inspired-satyr.sshPublicKey
            ];
          };
        kavita = enabled;
      };
      hetzner =
        enabled
        // {
          ipv6 = "2a01:4f8:1c1c:e5fb::1/64";
        };
    };
  };
}
