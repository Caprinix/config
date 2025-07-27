{lib, ...}: {
  mkDeploy = {
    self,
    overrides ? {},
  }: let
    systems = self.nixosConfigurations;
    nodes = lib.foldlAttrs (acc: name: value:
      acc
      // (
        if value.config.caprinix.deployment.enable
        then let
          inherit (value.pkgs) system;
        in {
          ${name} = {
            hostname = value.config.networking.fqdn;
            sshUser = "deployment";
            sshOpts = ["-i" "~/.ssh/caprinix_deployment_id_ed25519"];
            profiles.system = {
              user = "root";
              path = lib.deploy-rs.${system}.activate.nixos value;
            };
          };
        }
        else {}
      )) {}
    systems;
  in {
    nodes = lib.snowfall.attrs.merge-deep [nodes overrides];
  };
}
