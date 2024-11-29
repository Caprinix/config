{ lib, ...} : 
{
  config = {
    programs.git.extraConfig.user.signingKey = lib.mkForce "~/.ssh/wandering-bendy-snake";
  };
}