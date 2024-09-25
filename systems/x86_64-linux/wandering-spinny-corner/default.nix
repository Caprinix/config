{ lib, ... }:
let
  inherit (lib.caprinix) enabled;
in
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./persistence.nix
  ];

  config = {
    caprinix = {
      disko = enabled // {
        layout = "impermanence";
        args = {
          device = "/dev/sda";
        };
      };
      impermanence = enabled;
      programs = {
        zsh = enabled;
      };
      services = {
        openssh = enabled;
      };
    };
  };
}
