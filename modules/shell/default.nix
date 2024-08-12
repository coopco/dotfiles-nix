{ lib, config, ... }:

with lib;
let cfg = config.modules.shell;

in {
  options.modules.shell = { enable = mkEnableOption "shell"; };
  config = mkIf cfg.enable {
    programs.nushell = {
      enable = true;
    };

    # Direnv
    programs.direnv = {
      enable = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
