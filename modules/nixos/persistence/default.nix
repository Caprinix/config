{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) lists mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled;
  inherit (lib.snowfall.fs) get-nix-files-recursive;

  cfg = config.caprinix.persistence;

  flakeRoot = inputs.self.outPath;
  homeConfig = config.snowfallorg.users.replicapra.home.config;
  systemPersistenceFiles = builtins.filter (name: builtins.baseNameOf name == "system-persistence.nix") (get-nix-files-recursive flakeRoot);
  allSystemPersistenceImports = builtins.map (file:
    import file {
      inherit homeConfig lib;
      systemConfig = config;
    })
  systemPersistenceFiles;
  systemPersistenceImports = builtins.filter (persistence: persistence.enable) allSystemPersistenceImports;
in {
  options.caprinix.persistence = {
    enable = mkEnableOption "persistence";
  };

  config = mkIfEnabled cfg {
    environment.persistence = {
      "/persistent/system" = {
        hideMounts = true;
        directories = lists.flatten (builtins.map ({directories ? [], ...}: directories) systemPersistenceImports);
        files = lists.flatten (builtins.map ({files ? [], ...}: files) systemPersistenceImports);
      };
    };
  };
}
