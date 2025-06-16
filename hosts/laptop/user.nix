{ config, lib, inputs, pkgs, ...}:
{
    imports = [ ../../modules/default.nix ];

    config = {
        # Add rehash directly
        home.packages = [ pkgs.rehash ];

        modules = {
            firefox.enable = true;
            shell.enable = true;
            sxhkd.enable = true;
        };
    };
}
