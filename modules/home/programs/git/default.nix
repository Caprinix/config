{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled enabled;

  cfg = config.caprinix.programs.git;

  ignores = import ./ignores.nix;
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
          userEmail = "replicapra@outlook.com";
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
      lazygit = enabled;
      gh =
        enabled
        // {
          settings = {
            git_protocol = "ssh";
          };
        };
    };
  };
}
