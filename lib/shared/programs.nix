{lib, ...}: let
  inherit (lib.caprinix-essentials.modules) enabled;
in {
  programs = {
    sharedZshConfig = {
      enableCompletion = true;
      vteIntegration = true;
      autosuggestions =
        enabled
        // {
          strategy = [
            "history"
            "completion"
          ];
        };
      histSize = 10000;
      ohMyZsh =
        enabled
        // {
          plugins = [];
        };
      syntaxHighlighting =
        enabled
        // {
          highlighters = [
            "main"
            "brackets"
          ];
        };
    };
  };
}
