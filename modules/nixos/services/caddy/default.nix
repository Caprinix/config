{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (lib.caprinix) enabled mkIfEnabled;

  cfg = config.caprinix.services.caddy;
in {
  options.caprinix.services.caddy = {
    enable = mkEnableOption "caddy";
    virtualHosts = mkOption {
      type = types.attrs;
      default = {};
    };
  };

  config = mkIfEnabled cfg {
    services.caddy =
      enabled
      // {
        inherit (cfg) virtualHosts;
        environmentFile = config.sops.secrets."services/caddy/secrets.env".path;
        globalConfig = ''
          admin off
          persist_config off
        '';
        enableReload = false;
        email = "replicapra@outlook.com";
      };

    networking.firewall.allowedTCPPorts = [80 443];
  };
}
