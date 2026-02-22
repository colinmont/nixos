# Summary: Per-machine settings for host "go" (hardware, networking, packages).
{ config, pkgs, ... }:

{
  # Hardware scan results live next to this file.
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Host identity and network behavior.
  networking = {
    hostName = "go";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  # Device-specific hardware toggles.
  hardware = {
    sensor.iio.enable = true;

    # Enable support for touchscreen and stylus
    enableAllFirmware = true;
    enableAllHardware = true;

    # Install libinput for better input device handling
    #libinput.enable = true;
  };

  # Power management: use TLP instead of power-profiles-daemon.
  services = {
    tlp.enable = true;
    power-profiles-daemon.enable = false;
  };

  # Shell aliases and system packages for this host.
  environment = {
    interactiveShellInit = ''
      alias nixbuild='sudo nixos-rebuild switch --flake /etc/nixos#go'
    '';
    systemPackages = with pkgs; [
      home-manager
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

  # Add device-related group memberships to the shared user.
  users.users.colin.extraGroups = [ "adbusers" "kvm" ];

  # Host-specific program enables.
  programs = {
    #adb.enable = true;
    steam.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
