{ config, lib, inputs, pkgs, ...}:

{
    imports = [ ../../modules/default.nix ];
    config.modules = {
    #    # gui
        firefox.enable = true;
        shell.enable = true;
        sxhkd.enable = true;
    };
}
