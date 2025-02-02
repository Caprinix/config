{systemConfig, ...}: {
  inherit (systemConfig.caprinix.services.nginx) enable;
  directories = [
    "/var/lib/acme"
  ];
}
