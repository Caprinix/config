{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkAliasOptionModule;
  inherit (lib.caprinix.shared.programs) sharedZshConfig;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.zsh;
in {
  imports = [
    (mkAliasOptionModule
      ["programs" "zsh" "autosuggestions"]
      ["programs" "zsh" "autosuggestion"])
    (mkAliasOptionModule
      ["programs" "zsh" "vteIntegration"]
      ["programs" "zsh" "enableVteIntegration"])
    (mkAliasOptionModule
      ["programs" "zsh" "histFile"]
      ["programs" "zsh" "history" "path"])
    (mkAliasOptionModule
      ["programs" "zsh" "histSize"]
      ["programs" "zsh" "history" "size"])
    (mkAliasOptionModule
      ["programs" "zsh" "ohMyZsh"]
      ["programs" "zsh" "oh-my-zsh"])
  ];

  options.caprinix.programs.zsh = {
    enable = mkEnableOption "zsh";
  };

  config = mkIfEnabled cfg {
    programs = {
      zsh = mkMerge [
        enabled
        sharedZshConfig
        {
          autocd = true;
          dotDir = "${config.xdg.configHome}/zsh";
          history = {
            append = true;
            expireDuplicatesFirst = true;
            extended = true;
            ignoreDups = true;
            ignoreSpace = true;
            path = "${config.programs.zsh.dotDir}/.zshistory";
          };
          oh-my-zsh = {
            extraConfig = ''
              zstyle ':omz:update' mode auto
              zstyle ':omz:update' frequency 1
            '';
          };
        }
      ];
    };
  };
}
