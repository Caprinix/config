{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled;

  cfg = config.caprinix.disko;
in {
  options.caprinix.disko = {
    enable = mkEnableOption "disko";
    layout = mkOption {
      type = types.str;
      default = "simple";
    };
    args = mkOption {
      type = types.attrs;
      default = {};
    };
  };

  config = mkIfEnabled cfg {inherit (import ./layouts/${cfg.layout}.nix cfg.args) disko;};
}
