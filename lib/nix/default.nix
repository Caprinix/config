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
      trusted-users = [
        "@wheel"
        "@sudo"
      ];
      extra-trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
        "https://numtide.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };
  };
  sharedNixpkgsConfig = {
    allowUnfree = true;
  };
}
