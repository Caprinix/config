{lib, ...}: let
  inherit (lib.caprinix) enabled;
in {
  config = {
    networking.useNetworkd = true;
    networking.domain = "replicapra.dev";

    systemd.network.enable = true;

    networking.nftables = enabled;
  };
}
