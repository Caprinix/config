{homeConfig, ...}: {
  inherit (homeConfig.caprinix.workbench.distrobox) enable;
  directories = [
    ".local/share/containers"
    ".distrobox"
  ];
}
