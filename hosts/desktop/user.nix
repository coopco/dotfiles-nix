{ config, lib, inputs, pkgs, ...}:

{
    imports = [ ../../modules/default.nix ];
    config = {
        home.packages = [ pkgs.rehash ];
        modules = {
        #    # gui
            firefox.enable = true;
            shell.enable = true;
        #    #foot.enable = true;
        #    #eww.enable = true;
        #    #dunst.enable = true;
        #    #hyprland.enable = true;
        #    #wofi.enable = true;

        #    # cli
        #    nvim.enable = true;
        #    zsh.enable = true;
        #    git.enable = true;
        #    #gpg.enable = true;
        #    #direnv.enable = true;

        #    # system
        #    #xdg.enable = true;
        #    #packages.enable = true;
        };
        # Proprietary drivers
    };
}
