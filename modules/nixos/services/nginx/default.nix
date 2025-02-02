{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (lib.caprinix) enabled mkIfEnabled;

  cfg = config.caprinix.services.nginx;
in {
  options.caprinix.services.nginx = {
    enable = mkEnableOption "nginx";
    virtualHosts = mkOption {
      type = types.attrs;
      default = {};
    };
  };
  config = mkIfEnabled cfg {
    security.acme.acceptTerms = true;
    security.acme.defaults.email = "security@replicapra.dev";

    services.nginx =
      enabled
      // {
        recommendedOptimisation = true;
        recommendedTlsSettings = true;
        recommendedGzipSettings = true;
      };
  };
}
