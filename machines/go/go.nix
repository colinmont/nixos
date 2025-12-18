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

  hardware.sensor.iio.enable = true;
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
    nix-search-cli
     #media
    vlc
    jellyfin-media-player
    runescape
    maliit-keyboard

    #utils
    wget
    beeper
    obsidian
    gparted
    kcalc
    btrfs-progs
    git
    #orca-slicer

    #web
    #fluffychat
    firefox
    chromium
    sidequest
    bambu-studio
 ];
};
users.users.colin.extraGroups = [ "adbusers" "kvm" ];
      programs = {
      adb.enable = true;
      steam.enable = true;
      neovim = {
            enable = true;
            defaultEditor = true;
        };

    };


 }
