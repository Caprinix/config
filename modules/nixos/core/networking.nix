_: {
  config = {
    networking.useNetworkd = true;
    networking.domain = "replicapra.dev";

    systemd.network.enable = true;
  };
}
