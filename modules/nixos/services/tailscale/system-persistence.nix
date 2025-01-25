{systemConfig, ...}: {
  inherit (systemConfig.caprinix.services.tailscale) enable;
  directories = [
    "/var/lib/tailscale"
  ];
}
