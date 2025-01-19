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
        openssh =
          enabled
          // {
            authorizedKeys = [
              systems.wandering-woof-scorebook.sshPublicKey
              systems.ethereal-inspired-satyr.sshPublicKey
            ];
          };
      };
      hetzner =
        enabled
        // {
          ipv6 = "2a01:4f8:c2c:f992::1/64";
        };
    };
  };
}
