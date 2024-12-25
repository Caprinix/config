{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption catAttrs attrValues getAttrs types;
  inherit (lib.caprinix) enabled systems mkIfEnabled;

  cfg = config.caprinix.services.openssh;
in {
  options.caprinix.services.openssh = {
    enable = mkEnableOption "openssh";
    authorizedSystems = mkOption {
      type = types.listOf types.str;
      default = [];
    };
  };

  config = mkIfEnabled cfg {
    services = {
      openssh =
        enabled
        // {
          settings = {
            X11Forwarding = false;
            UseDns = true;
            PermitRootLogin = "prohibit-password";
            PasswordAuthentication = false;
          };
          extraConfig = ''
            PubkeyAuthentication yes
            PermitEmptyPasswords no
            ChallengeResponseAuthentication no
            PermitUserEnvironment no
            AllowAgentForwarding no
            AllowTcpForwarding no
            PermitTunnel no
            ClientAliveInterval 300
          '';
        };
      fail2ban =
        enabled
        // {
          bantime-increment =
            enabled
            // {
              overalljails = true;
              rndtime = "15m";
            };
        };
    };
    users.users.replicapra.openssh.authorizedKeys.keys = catAttrs "sshPublicKey" (
      attrValues (getAttrs cfg.authorizedSystems systems)
    );
    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHzMnGcLpIyjvzi/YkMqUdFGhyE92e4t9aSgNmOvY57 master@replicapra"
    ];
  };
}
