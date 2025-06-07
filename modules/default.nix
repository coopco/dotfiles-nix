{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "24.05";
    # List of custom modules
    imports = [
        ./firefox
        ./shell
        ./sxhkd
    ];
}
