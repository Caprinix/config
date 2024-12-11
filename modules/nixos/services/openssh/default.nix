{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.caprinix) enabled;

  cfg = config.caprinix.services.openssh;
in {
  options.caprinix.services.openssh = {
    enable = mkEnableOption "openssh";
  };

  config = mkIf cfg.enable {
    services = {
      openssh =
        enabled
        // {
          settings = {
            X11Forwarding = false;
            UseDns = true;
            PermitRootLogin = "no";
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
  };
}
