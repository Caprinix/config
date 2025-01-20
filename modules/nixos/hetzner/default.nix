{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (lib.caprinix) mkIfEnabled;

  cfg = config.caprinix.hetzner;
in {
  options.caprinix.hetzner = {
    enable = mkEnableOption "hetzner";
    ipv6 = mkOption {
      type = types.str;
      example = "2001:db8:abcd:0012::1/64";
      description = ''
        The IPv6 address assigned to the server.
      '';
    };
  };

  config = mkIfEnabled cfg {
    systemd.network.networks = {
      "10-enp1s0" = {
        address = [cfg.ipv6];
        routes = [
          {Gateway = "fe80::1";}
        ];
        networkConfig.DHCP = "ipv4";
        matchConfig.Name = "enp1s0";
      };
    };

    networking.firewall.trustedInterfaces = ["enp7s0"];

    services.qemuGuest.enable = true;
    systemd.services.qemu-guest-agent.path = [pkgs.shadow];
  };
}
