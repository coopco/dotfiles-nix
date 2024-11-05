{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # https://nixos.wiki/wiki/flakes#Importing_packages_from_multiple_channels
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO elsewhere
    nixvim = {
      #url = "github:nix-community/nixvim/nixos-24.05";
      url = "github:coopco/nixvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  #outputs = { self, nixpkgs, ... }@inputs: {
  #  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
  #    system = "x86_64-linux";
  #    modules = [
  #      # Import the previous configuration.nix we used,
  #      # so the old configuration file still takes effect
  #      ./configuration.nix
  #    ];
  #  };
  #};
  # All outputs for the system (configs)
  outputs = { home-manager, nixpkgs, nixpkgs-unstable, ... }@inputs: 
      let
          system = "x86_64-linux";
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          lib = nixpkgs.lib;

          # This lets us reuse the code to "create" a system
          # https://github.com/sioodmy/dotfiles/blob/main/flake.nix
          mkSystem = pkgs: system: hostname:
              pkgs.lib.nixosSystem {
                  system = system;
                  modules = [
                      { networking.hostName = hostname; }
                      # General configuration (users, networking, sound, etc)
                      ./modules/system/configuration.nix
		                  # TODO move into actual module
		                  ./modules/nvim/default.nix
                      # Hardware config (bootloader, kernel modules, filesystems, etc)
                      # DO NOT USE MY HARDWARE CONFIG!! USE YOUR OWN!!
                      (./. + "/hosts/${hostname}/hardware-configuration.nix")
                      home-manager.nixosModules.home-manager
                      {
                          home-manager = {
                              useUserPackages = true;
                              useGlobalPkgs = true;
                              extraSpecialArgs = { inherit inputs; };
                              backupFileExtension = "backup";
                              # Home manager config (configures programs like firefox, zsh, eww, etc)
                              users.connor = (./. + "/hosts/${hostname}/user.nix");
                          };
                          nixpkgs.overlays = [
                            # make unstable packages available via overlay
                            (final: prev: {
                              unstable = nixpkgs-unstable.legacyPackages.${prev.system};
                            })
                          #    # Add nur overlay for Firefox addons
                          #    nur.overlay
                          #    (import ./overlays)
                          ];
                      }
                  ];
                  specialArgs = { inherit inputs; };
              };

      in {
          nixosConfigurations = {
              # Now, defining a new system is can be done in one line
              #                                Architecture   Hostname
              desktop = mkSystem inputs.nixpkgs "x86_64-linux" "desktop";
          };
  };
}
