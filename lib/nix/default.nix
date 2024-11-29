{
  sharedNixConfig = {
    checkConfig = true;
    gc = {
      dates = "daily";
      options = "--delete-older-than 3d";
      automatic = true;
      persistent = true;
    };
    settings = {
      trusted-users = [ "@wheel" "@sudo" ];
    };
  };
  sharedNixpkgsConfig = {
    allowUnfree = true;
  };
}
