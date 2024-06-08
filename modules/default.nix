{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "24.05";
    # List of custom modules
    imports = [
        # gui
        ./firefox
        #./foot
        #./eww
        #./dunst
        #./hyprland
        #./wofi

        ## cli
        #./nvim
        #./zsh
        #./git
        #./gpg
        #./direnv

        ## system
        #./xdg
	#./packages
    ];
}
