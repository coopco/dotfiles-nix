{ pkgs, ... }:

let
  nixvim = pkgs.writeShellScriptBin "nvim" ''
    /home/connor/Projects/nixvim/result/bin/nvim
  '';

in { environment.systemPackages = [ nixvim ]; }

# TODO this is kind of bad

#{ inputs, pkgs, lib, config, ... }: {
  #imports = [
  #   inputs.nixvim.nixosModules.nixvim
  # ];


  #nixvim = {
  #  inputs.nixpkgs.follows = "nixpkgs";
  #};
  #programs.nixvim = {
  #  enable = true;
  #  colorschemes.catppuccin = {
  #    enable = true;
  #  };
  #};

#  with lib;
#  let 
#    cfg = config.modules.nvim;
#  in {
#    options.modules.nvim = { enable = mkEnableOption "nvim"; };
#    config = mkIf cfg.enable {
#      .homeManagerModules.nixvim = {
#      enable = true;
#      defaultEditor = true;
#    };
#    };
#  };
#}

#}
#with lib, inputs;
#let 
#  cfg = config.modules.nvim;
#in {
#  imports = [
#    # For home-manager
#    inputs.nixvim.homeManagerModules.nixvim
#  ];
#  options.modules.nvim = { enable = mkEnableOption "nvim"; };
#  config = mkIf cfg.enable {
#    .homeManagerModules.nixvim = {
#      enable = true;
#      defaultEditor = true;
#    };
#  };
#}
