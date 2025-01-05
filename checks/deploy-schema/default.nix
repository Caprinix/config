{
  inputs,
  pkgs,
}: let
  inherit (pkgs) system;
  checks = inputs.deploy-rs.lib.${system}.deployChecks inputs.self.deploy;
  inherit (checks) deploy-schema;
in
  deploy-schema
