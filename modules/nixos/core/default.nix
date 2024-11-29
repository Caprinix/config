{ pkgs, lib, ... }:
let
  inherit (lib.caprinix) enabled;

  htop-settings = import ./htop-settings.nix;
in
{
  imports = [
    ./nix.nix
    ./users.nix
  ];

  config = {
    programs = {
      htop = enabled // {
        settings = htop-settings;
      };
    };
  };
}
