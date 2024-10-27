{ lib, ... }:
let
  inherit (lib) catAttrs attrValues getAttrs;
  inherit (lib.caprinix) enabled systems;
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
        steam = enabled;
      };
      services = {
        openssh = enabled;
      };
      virtualisation = enabled // {
        autoPrune = enabled // {
          dates = "daily";
        };
        podman = enabled;
        docker = enabled;
        qemu = enabled;
      };
    };

    users.users.replicapra = {
      openssh.authorizedKeys.keys = catAttrs "sshPublicKey" (
        attrValues (getAttrs [ "wandering-woof-scorebook" ] systems)
      );
    };

  };
}
