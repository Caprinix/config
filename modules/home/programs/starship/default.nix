{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption concatStrings;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled enabled;

  cfg = config.caprinix.programs.starship;

  format = import ./format.nix;
in {
  options.caprinix.programs.starship = {
    enable = mkEnableOption "starship promt";
  };

  config = mkIfEnabled cfg {
    programs = {
      starship =
        enabled
        // {
          settings = {
            sudo = {
              disabled = false;
              format = "[$symbol]($style)";
              symbol = "!";
            };
            format = concatStrings format;
            fill = {
              symbol = " ";
            };
          };
        };
    };
  };
}
