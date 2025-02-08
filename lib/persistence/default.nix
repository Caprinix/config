{lib, ...}: let
  inherit (lib.lists) flatten filter length last head;
in {
  mkDynamicUserPath = path: let
    parts = filter (x: x != "") (flatten (builtins.split "(^/var/lib/|^/var/lib/cache/|^/var/log/)" path));
  in
    if (length parts > 1) && !(lib.strings.hasPrefix "private/" (last parts))
    then "${head parts}private/${last parts}"
    else path;
}
