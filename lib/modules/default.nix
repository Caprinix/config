{ lib, ... }:
let
  inherit (lib) mkIf;
in
{
  enabled = {
    enable = true;
  };

  disabled = {
    enable = false;
  };

  mkIfEnabled = option: content: mkIf (option.enable) content;
}
