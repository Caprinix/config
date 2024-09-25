{ lib, ... }:
let
  inherit (lib) listToAttrs;
  inherit (lib.snowfall) fs path;

  systemFiles = fs.get-non-default-nix-files ./.;
  getName = file: path.get-file-name-without-extension file;
in
{
  systems = (
    listToAttrs (
      map (system: {
        name = getName system;
        value = import system;
      }) systemFiles
    )
  );
}
