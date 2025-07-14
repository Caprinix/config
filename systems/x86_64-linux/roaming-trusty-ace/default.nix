{lib, ...}: let
  inherit (lib.caprinix-essentials.modules) enabled;
in {
  imports = [
    ./configuration.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  config = {
    caprinix = {
      services.openssh = enabled;
    };
  };
}
