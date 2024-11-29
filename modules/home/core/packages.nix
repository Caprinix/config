{ pkgs, ... }:
{
  config = {
    home.packages = with pkgs; [
      ripgrep
      ripgrep-all
      jq
      fq
      yq
      jnv
      unrar
      unzip
    ];
  };
}
