{osConfig, ...}: {
  imports = [
    ./nix.nix
  ];

  config = {
    home.stateVersion = osConfig.system.stateVersion;
  };
}
