 { config, pkgs, ... }:

 {

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
    git
    cifs-utils
    obsidian
    gparted
    kcalc
    krdc
    htop
    git
    btrfs-progs
    gh

    #web
    fluffychat
    firefox
    ungoogled-chromium
    deluge

  ];

      programs = {
        #steam
        steam.enable = true;

        neovim = {
            enable = true;
            defaultEditor = true;
        };

    };
  }
