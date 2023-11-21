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


 environment = {

  #aliases
  interactiveShellInit = ''
    alias nixbuild='sudo nixos-rebuild switch --flake #desktop'
  '';

  systemPackages = with pkgs; [
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
    git
    btrfs-progs
    gh
    partition-manager

    #web
    fluffychat
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
