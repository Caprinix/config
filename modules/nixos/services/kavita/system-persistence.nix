{systemConfig, ...}: {
  inherit (systemConfig.caprinix.services.kavita) enable;
  directories = [
    systemConfig.services.kavita.dataDir
  ];
}
