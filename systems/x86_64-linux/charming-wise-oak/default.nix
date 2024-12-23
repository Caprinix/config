{lib, ...}: let
  inherit (lib) catAttrs attrValues getAttrs;
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
      services = {
        openssh = enabled;
      };
    };

    users.users.replicapra = {
      openssh.authorizedKeys.keys = catAttrs "sshPublicKey" (
        attrValues (getAttrs ["wandering-woof-scorebook" "wandering-bendy-snake"] systems)
      );
    };
  };
}
