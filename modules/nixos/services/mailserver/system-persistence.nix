{systemConfig, ...}: {
  inherit (systemConfig.caprinix.services.mailserver) enable;
  directories = [
    systemConfig.mailserver.mailDirectory
    systemConfig.mailserver.sieveDirectory
    systemConfig.mailserver.certificateDirectory
    systemConfig.mailserver.dkimKeyDirectory
    "/var/lib/rspamd"
  ];
}
