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
        mailserver = enabled;
        nginx =
          enabled
          // {
            virtualHosts = {
              "ntfy.replicapra.dev" = {
                forceSSL = true;
                enableACME = true;
                locations = {
                  "/" = {
                    proxyPass = "http://127.0.0.1:2586/";
                    proxyWebsockets = true;
                  };
                };
              };
            };
          };
        ntfy = enabled;
      };
      hetzner =
        enabled
        // {
          ipv6 = "2a01:4f8:c0c:8143::1/64";
        };
    };
  };
}
