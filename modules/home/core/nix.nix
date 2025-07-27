{lib, ...}: let
  inherit (lib) mkAliasOptionModule mkMerge;
  inherit (lib.caprinix.shared) sharedNixConfig sharedNixpkgsConfig;
in {
  imports = [
    (mkAliasOptionModule
      ["nix" "gc" "dates"]
      ["nix" "gc" "frequency"])
  ];

  config = {
    nix = mkMerge [
      sharedNixConfig
      {
        extraOptions = ''
          !include nix.custom.conf
          !include nix.secret.conf
        '';
      }
    ];
    xdg.configFile."nixpkgs/config.nix".text =
      lib.generators.toPretty {
        multiline = true;
      }
      sharedNixpkgsConfig;
  };
}
