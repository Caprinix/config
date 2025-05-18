{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;

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

  config = mkIf cfg.enable {inherit (import ./layouts/${cfg.layout}.nix cfg.args) disko;};
}
