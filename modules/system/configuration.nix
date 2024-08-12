# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  #imports =
  #  [ # Include the results of the hardware scan.
  #    ./hardware-configuration.nix
  #  ];
  #imports = [
  #  inputs.nixvim.nixosModules.nixvim
  #];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModprobeConfig = ''
    options snd slots=snd_hda_intel
  '';

  networking.hostName = "desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  services.xserver.enable = true;

  # Proprietary drivers
  services.xserver.videoDrivers = [ "nvidia" ];


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    options = "ctrl:swapcaps";
    variant = "";
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];

  services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.displayManager.startx.enable = true;

  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
    src = /home/connor/Projects/wm/dwm;
    buildInputs = oldAttrs.buildInputs ++ [ pkgs.yajl ];
  });

  programs.hyprland.enable = true;

  #console.xkbConfig = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.connor = {
    isNormalUser = true;
    description = "Connor";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "connor";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # C headers for building dwm
  environment.extraOutputsToInstall = ["dev"];
  #environment.variables.C_INCLUDE_PATH = "${nixpkgs.expat.dev}/include";

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    st

    # Applications
    kitty  # Terminal
    firefox-devedition
    discord
    obsidian
    git
    dmenu  # Program launcher
    rofi  # Menus
    activitywatch
    mullvad-vpn  # VPN
    redshift
    syncthing
    syncthingtray
    flameshot
    lazygit
    spotify  # Music service
    zathura  # PDF viewer
    htop  # System monitor
    glances  # System monitor
    qbittorrent  # Torrent client
    vlc  # Video player
    picom-pijulius  # X Compositor
    (lutris.override {
      extraLibraries =  pkgs: [
        # List library dependencies here
      ];
      extraPkgs = pkgs: [
         # List package dependencies here
      ];
    })
    zotero_7  # Literature manager
    papis  # CLI Literature manager

    # Audio
    pamixer
    playerctl
    pavucontrol  # Audio mixer

    # Utilities
    blesh
    devour
    fzf  # Fuzzy search utility
    jq  # JSON parser
    feh  # Image viewer
    ranger  # TUI file manager
    zsh
    just  # Command runner
    sxhkd  # Hotkey daemon
    tree  # Recursive ls
    progress
    ripgrep  # Search in files
    difftastic  # difft: Fancy diff
    xdotool  # Tool for dwm automation
    xclip  # Clipboard engine

    wireguard-tools

    openvpn

    nix-index  # Search for files within packages

    elvish  # Fancy shell

    # libraries
    yajl

    # Packages from flake source
    # TODO: temp while nixvim broken. Currently installed through nix profile
    #inputs.nixvim.packages."${pkgs.unstable.system}".default  # Neovim config
  ];


  # Flatpak
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #xdg.portal.configPackages = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.enable = true;
  services.flatpak.enable = true;

  services.mullvad-vpn.enable = true;

  # Audio
  sound.enable = true; 
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  users.extraUsers.connor.extraGroups = [ "audio" ];

  users.users.connor = {
        shell = pkgs.bash;
  };

  environment.interactiveShellInit = ''
    alias v='nvim'
    alias vi='nvim'
  '';

  # Docker
  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  #};



 
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  xdg.mime.defaultApplications = {
    "x-scheme-handler/http"    = "firefox.desktop";
    "x-scheme-handler/https"   = "firefox.desktop";
    "x-scheme-handler/about"   = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  # Remote desktop
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "dwm";
  services.xrdp.audio.enable = true;
  services.xrdp.openFirewall = true;

  #services.tailscale.enable = true;

  #services.x2goserver.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      #AllowUsers = null;
      UseDns = true;
      X11Forwarding = true;
      PermitRootLogin = "no";
    };
  };

  # TODO: declarative sync folders
  services = {
    syncthing = {
        enable = true;
        user = "connor";
        dataDir = "/home/connor/Sync";    # Default folder for new synced folders
        configDir = "/home/connor/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };

  systemd.services.commandOnBoot = {
    script = ''
      sxhkd &
      feh --bg-scale /home/connor/wallpapers/1px.png &
    '';
    wantedBy = [ "multi-user.target" ];
  };

  #services.tailscale.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

