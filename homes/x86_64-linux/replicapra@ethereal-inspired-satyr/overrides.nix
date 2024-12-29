{lib, ...}: {
  config = {
    programs.git.extraConfig.user.signingKey = lib.mkForce "~/.ssh/ethereal-creative-satyr/id_ed25519";
  };
}
