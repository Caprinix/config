{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkForce;
  inherit (lib.caprinix-essentials.modules) enabled mkIfEnabled;

  extraConfig = builtins.readFile ./sshd_config;

  cfg = config.caprinix.services.openssh;
in {
  options.caprinix.services.openssh = {
    enable = mkEnableOption "openssh";
  };

  config = mkIfEnabled cfg {
    services = {
      openssh =
        enabled
        // {
          inherit extraConfig;

          startWhenNeeded = true;
          authorizedKeysInHomedir = false;
          hostKeys = [
            {
              path = "/etc/ssh/ssh_host_ed25519_key";
              type = "ed25519";
            }
          ];
          settings = {
            X11Forwarding = false;
            UsePAM = false;
            UseDns = false;
            StrictModes = true;
            PrintMotd = false;
            PermitRootLogin = mkForce "no";
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            GatewayPorts = "no";
          };
        };
    };
  };
}
