 
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
        hostName = "vps";
        networkmanager.enable = true;
        firewall.enable = false;
    };


 environment.systemPackages = with pkgs; [
    neovim
    wget
    cifs-utils
    htop
    git

  ];

      programs = {

        neovim = {
            enable = true;
            defaultEditor = true;
        };

    };
}
