{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  ignores = import ./ignores.nix;

  cfg = config.caprinix.programs.git;
in {
  options.caprinix.programs.git = {
    enable = mkEnableOption "git";
  };

  config = mkIfEnabled cfg {
    programs = {
      git =
        enabled
        // {
          inherit ignores;
          package = pkgs.gitFull;
          lfs = enabled;
          maintenance = enabled;
          userEmail = "154707993+replicapra@users.noreply.github.com";
          userName = "replicapra";
          extraConfig = {
            user = {
              signingKey = "~/.ssh/id_ed25519.pub";
            };
            gpg.format = "ssh";
            commit.gpgSign = true;
            tag.gpgSign = true;
          };
        };
    };
  };
}
