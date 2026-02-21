{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "go";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  hardware = {
    sensor.iio.enable = true;

    # Enable support for touchscreen and stylus
    enableAllFirmware = true;
    enableAllHardware = true;

    # Install libinput for better input device handling
    #libinput.enable = true;
  };

  services = {
    tlp.enable = true;
    power-profiles-daemon.enable = false;
  };

  environment = {
    interactiveShellInit = ''
      alias nixbuild='sudo nixos-rebuild switch --flake /etc/nixos#go'
    '';
    systemPackages = with pkgs; [
      vscode-fhs

      # office
      #kate
      libreoffice

      # media
      vlc
      jellyfin-media-player

      # utils
      wget
      beeper
      obsidian
      gparted
      #kcalc
      btrfs-progs
      git
      nodejs      
      antigravity-fhs
      uv

      # web
      firefox
      chromium
      sidequest

      # Surface-specific tools
      iptsd
      onboard
    ];
  };

  users.users.colin.extraGroups = [ "adbusers" "kvm" ];

  programs = {
    #adb.enable = true;
    steam.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
