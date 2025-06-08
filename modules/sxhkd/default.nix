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
        "XF86AudioRaiseVolume" = "/run/current-system/sw/bin/pamixer -i 5; /run/current-system/sw/bin/dwm-msg run_command updatestatus_ipc";
        "XF86AudioLowerVolume" = "/run/current-system/sw/bin/pamixer -d 5; /run/current-system/sw/bin/dwm-msg run_command updatestatus_ipc";
        "XF86AudioMute" = "/run/current-system/sw/bin/pamixer -t; /run/current-system/sw/bin/dwm-msg run_command updatestatus_ipc";
        "XF86AudioPrev" = "/run/current-system/sw/bin/playerctl previous";
        "XF86AudioPlay" = "/run/current-system/sw/bin/playerctl play-pause";
        "XF86AudioNext" = "/run/current-system/sw/bin/playerctl next";
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
