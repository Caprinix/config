{systemConfig, ...}: {
  inherit (systemConfig.caprinix.services.caddy) enable;
  directories = [
    systemConfig.services.caddy.dataDir
  ];
}
