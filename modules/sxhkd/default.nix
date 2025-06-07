{ lib, config, pkgs, ... }:

with lib;
let cfg = config.modules.shell;

in {
  options.modules.sxhkd = { enable = mkEnableOption "sxhkd"; };
  config = mkIf cfg.enable {
    services.sxhkd = {
      enable = true;
      keybindings = {
        "XF86MonBrightnessUp" = "/run/current-system/sw/bin/light -A 10";
        "XF86MonBrightnessDown" = "/run/current-system/sw/bin/light -U 10";
      };
    };
    systemd.user.services.sxhkd = {
      Unit = {
        Description = "sxhkd daemon";
        After = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.sxhkd}/bin/sxhkd";
        Restart = "always";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
