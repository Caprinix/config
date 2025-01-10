{systemConfig, ...}: {
  inherit (systemConfig.caprinix.programs.steam) enable;
  directories = [
    ".local/share/Steam"
  ];
}
