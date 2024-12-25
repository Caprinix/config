{lib, ...}: let
  inherit (lib.caprinix) enabled;
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
      services = {
        openssh =
          enabled
          // {
            authorizedSystems = [
              "wandering-woof-scorebook"
            ];
          };
      };
    };
  };
}
