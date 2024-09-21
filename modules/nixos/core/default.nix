{ pkgs, lib, ... }:
let
  inherit (lib.caprinix) enabled;

  htop-settings = import ./htop-settings.nix;
in
{
  imports = [
    ./nix.nix
  ];

  config = {
    environment.systemPackages = with pkgs; [
      ripgrep
      ripgrep-all
      jq
      fq
      yq
      jnv
      unrar
      unzip
    ];

    programs = {
      htop = enabled // {
        settings = htop-settings;
      };
    };
  };
}
