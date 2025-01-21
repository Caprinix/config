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
        caddy =
          enabled
          // {
            virtualHosts = {
              "discord.liebesplural.club" = {
                extraConfig = ''
                  redir {$LIEBESPLURAL_DISCORD_LINK} permanent
                '';
              };
              "whatsapp.liebesplural.club" = {
                extraConfig = ''
                  redir {$LIEBESPLURAL_WHATSAPP_LINK} permanent
                '';
              };
              "books.liebesplural.club" = {
                extraConfig = ''
                  reverse_proxy http://10.0.0.2:5000
                '';
              };
            };
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
