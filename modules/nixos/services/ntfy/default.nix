{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (lib.caprinix) enabled mkIfEnabled;

  cfg = config.caprinix.services.ntfy;
in {
  options.caprinix.services.ntfy = {
    enable = mkEnableOption "ntfy";
    virtualHosts = mkOption {
      type = types.attrs;
      default = {};
    };
  };
  config = mkIfEnabled cfg {
    services.ntfy-sh =
      enabled
      // {
        settings = {
          base-url = "https://ntfy.replicapra.dev";
          listen-http = "0.0.0.0:2586";
          auth-default-access = "deny-all";
          enable-signup = false;
          enable-login = true;
          enable-reservations = false;
          behind-proxy = true;
          auth-file = "/var/lib/ntfy-sh/user.db";
          attachment-cache-dir = "/var/lib/ntfy-sh/attachments";
          cache-file = "/var/lib/ntfy-sh/cache-file.db";
        };
      };
  };
}
