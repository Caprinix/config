{
  osConfig,
  ...
}:
{
  imports = [
    ./nix.nix
    ./packages.nix
  ];

  config = {
    home.stateVersion = osConfig.system.stateVersion;
  };
}
