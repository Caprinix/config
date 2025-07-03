{pkgs, ...}: {
  languages.nix.enable = true;
  languages.nix.lsp.package = pkgs.nixd;

  git-hooks.hooks.nix-flake-check = {
    enable = true;
    entry = "nix flake check --all-systems";
    pass_filenames = false;
  };

  git-hooks.hooks.nix-fmt = {
    enable = true;
    entry = "nix fmt";
    pass_filenames = true;
  };
}
