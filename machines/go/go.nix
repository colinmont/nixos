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
 environment = {
  interactiveShellInit = ''
    alias nixbuild='sudo nixos-rebuild switch --flake /etc/nixos#go'
  '';
  systemPackages = with pkgs; [
    vscodium
     #office
    kate
    libreoffice
    thunderbird

     #media
    shutter
    vlc
    jellyfin-media-player

    #utils
    wget
    micro
    beeper
    obsidian
    gparted
    kcalc
    krdc
    htop
    btrfs-progs
    git

    #web
    fluffychat
    firefox
    beeper
 ];
};
      programs = {

        neovim = {
            enable = true;
            defaultEditor = true;
        };

    };
 }
