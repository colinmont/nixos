# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

      # Define your hostname.
  networking = {
        hostName = "desktop";
        networkmanager.enable = true;
        firewall.enable = false;
    };

  virtualisation.libvirtd.enable = true;

  environment = {
  #aliases
    interactiveShellInit = ''
      alias nixbuild='sudo nixos-rebuild switch --flake /etc/nixos#desktop'
  '';


  systemPackages = with pkgs; [
    vscodium
    libreoffice
    thunderbird

     #media
    shutter
    vlc
    jellyfin-media-player
    gimp

    #utils
    neovim
    wget
    cifs-utils
    retroarchFull
    virt-manager
    comma
    kcalc
    gparted
    btop
    git
    btrfs-progs

    #web
    beeper
    firefox
    ungoogled-chromium
    deluge
    google-chrome

    ];
  };


      services = {
        sunshine.enable = true;
      };
      programs = {
        #steam
        steam.enable = true;

        #neovim
        neovim = {
            enable = true;
            defaultEditor = true;
        };


    };
}
