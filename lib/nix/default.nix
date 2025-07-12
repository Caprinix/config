{
  sharedNixConfig = {
    checkConfig = true;
    gc = {
      dates = "daily";
      options = "--delete-older-than 3d";
      automatic = true;
      persistent = true;
      randomizedDelaySec = "900";
    };
    settings = {
      trusted-users = [
        "@wheel"
        "@sudo"
      ];
    };
  };
  sharedNixpkgsConfig = {
    allowUnfree = true;
  };
}
