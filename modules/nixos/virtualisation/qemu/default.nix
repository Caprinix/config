{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled;

  cfg = config.caprinix.virtualisation.qemu;
in
{
  options.caprinix.virtualisation.qemu = {
    enable = mkEnableOption "qemu";
  };

  config = mkIfEnabled cfg {
    environment.systemPackages = with pkgs; [
      quickemu
    ];
  };
}
