{
  inputs,
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (lib) lists mkEnableOption;
  inherit (lib.caprinix) mkIfEnabled;
  inherit (lib.snowfall.fs) get-nix-files-recursive;

  cfg = config.caprinix.persistence;

  flakeRoot = inputs.self.outPath;
  homePersistenceFiles = builtins.filter (name: builtins.baseNameOf name == "home-persistence.nix") (get-nix-files-recursive flakeRoot);
  allHomePersistenceImports = builtins.map (file:
    import file {
      systemConfig = osConfig;
      homeConfig = config;
    })
  homePersistenceFiles;
  homePersistenceImports = builtins.filter (persistence: persistence.enable) allHomePersistenceImports;
in {
  options.caprinix.persistence = {
    enable = mkEnableOption "persistence";
  };

  config = mkIfEnabled cfg {
    home.persistence = {
      "/persistent/home/replicapra" = {
        directories = lists.flatten (builtins.map ({directories ? [], ...}: directories) homePersistenceImports);
        files = lists.flatten (builtins.map ({files ? [], ...}: files) homePersistenceImports);
        allowOther = true;
      };
    };
  };
}
