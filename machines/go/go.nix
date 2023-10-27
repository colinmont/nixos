 { config, pkgs, ... }:

 {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

    networking = {
      hostName = "go";
      networkmanager.enable = true;
      firewall.enable = false;
    };
 environment.systemPackages = with pkgs; [
     #office
    kate
    libreoffice
    thunderbird

     #media
    shutter
    vlc
    jellyfin-media-player

    #utils
    neovim
    wget

    cifs-utils
   # obsidian
    gparted
    kcalc
    krdc
    htop
    btrfs-progs
    gh

    #web
    fluffychat
    firefox


  ];

      programs = {

        neovim = {
            enable = true;
            defaultEditor = true;
        };

    };
  }
