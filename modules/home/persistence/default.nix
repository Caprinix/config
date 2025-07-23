{
  inputs,
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (lib) lists mkEnableOption;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled;
  inherit (lib.snowfall.fs) get-nix-files-recursive;
  inherit (config.snowfallorg.user) name;

  cfg = config.caprinix.persistence;

  flakeRoot = inputs.self.outPath;
  homePersistenceFiles = builtins.filter (name: builtins.baseNameOf name == "home-persistence.nix") (get-nix-files-recursive flakeRoot);
  allHomePersistenceImports = builtins.map (file:
    import file {
      inherit lib;
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
      "/persistent/home/${name}" = {
        directories = lists.flatten (builtins.map ({directories ? [], ...}: directories) homePersistenceImports);
        files = lists.flatten (builtins.map ({files ? [], ...}: files) homePersistenceImports);
        allowOther = true;
      };
    };
  };
}
