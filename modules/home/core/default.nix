{osConfig, ...}: {
  config = {
    home.stateVersion = osConfig.system.stateVersion;
  };
}
