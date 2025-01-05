{homeConfig, ...}: {
  inherit (homeConfig.caprinix.workbench.distrobox) enable;
  directories = [
    ".mozilla/firefox"
  ];
}
