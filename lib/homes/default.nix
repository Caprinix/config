{lib, ...}: let
  inherit (lib.attrsets) listToAttrs;
  inherit (lib.snowfall.fs) get-nix-files-recursive;
  inherit (lib.snowfall.path) get-parent-directory;
in {
  loadHomeSpecialArgs = rootPath: let
    specialArgFiles = builtins.filter (name: builtins.baseNameOf name == "special-args.nix") (get-nix-files-recursive rootPath);
  in
    listToAttrs (builtins.map (file: {
        name =
          builtins.unsafeDiscardStringContext
          (get-parent-directory file);
        value = {
          specialArgs = import file;
        };
      })
      specialArgFiles);
}
