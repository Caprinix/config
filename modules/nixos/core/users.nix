{config, ...}: {
  config = {
    users.mutableUsers = false;

    users.users = {
      replicapra = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets."users/replicapra/password".path;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
    };
  };
}
