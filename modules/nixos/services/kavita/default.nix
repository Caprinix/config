{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) enabled mkIfEnabled;

  cfg = config.caprinix.services.kavita;
in {
  options.caprinix.services.kavita = {
    enable = mkEnableOption "kavita";
  };

  config = mkIfEnabled cfg {
    services = {
      kavita =
        enabled
        // {
          dataDir = "/var/lib/kavita";
          tokenKeyFile = config.sops.secrets."services/kavita/token-key".path;
        };
    };
  };
}
