{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  languages.nix.enable = true;
  languages.nix.lsp.package = pkgs.nixd;

  editors.vscode.enable = true;
  editors.vscode.mixins = [
    "nix"
    "git"
  ];
}
