{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.services.tailscale;
in {
  options.caprinix.services.tailscale = {
    enable = mkEnableOption "tailscale";
  };

  config = mkIfEnabled cfg {
    services.tailscale =
      enabled
      // {
        authKeyFile = config.sops.secrets."services/tailscale/auth-key".path;
        openFirewall = true;
      };

    networking.firewall.trustedInterfaces = [config.services.tailscale.interfaceName];
  };
}
