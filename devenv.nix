{
  pkgs,
  ...
}: {
  languages.nix.enable = true;
  languages.nix.lsp.package = pkgs.nixd;
}
