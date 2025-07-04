{ pkgs, lib, config, inputs, ... }:

with lib;
let cfg = config.modules.shell;

in {
  options.modules.shell = { 
    enable = mkEnableOption "shell"; 
  };
  config = mkIf cfg.enable {
    programs.nushell = {
      enable = true;
      shellAliases = {
        v = "nvim";
        vi = "nvim";
      };
    };

    # Direnv
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };

    # TODO:
    programs.carapace.enable = true;
    programs.carapace.enableBashIntegration = true;
    programs.carapace.enableNushellIntegration = true;

    # TODO:
    programs.starship = { enable = true;
      settings = {
        add_newline = true;
        character = { 
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };
}
