# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./aliases.nix	
    ];


    networking = {
        hostName = "server";
        networkmanager.enable = true;
        firewall.enable = false;
    };


  systemd.services.NetworkManager-wait-online.enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vscode
  docker-compose
  mergerfs
  lazydocker
  neovim
  ];

# List services that you want to enable:

#enable samba and setup a share
services.samba = {
  enable = true;
  securityType = "user";
  extraConfig = ''
    workgroup = WORKGROUP
    server string = Server
    disable netbios = yes
    server role = standalone server
    security = user 
  '';
  shares = {
    storage = {
      path = "/mnt/storage";
      browseable = "no";
      "read only" = "no";
      "writeable" = "yes";
      "force create mode" = "0660";
      "force directory mode" = "0770";
      "valid users" = "colin";
    };
  };
};

#enable docker
virtualisation = {
  docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
};

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

#disk config
fileSystems."/mnt/disk1" = {
  device = "/dev/disk/by-id/ata-ST2000DM008-2FR102_ZFL0R79K-part1";
    fsType = "btrfs"; # replace with the appropriate file system type
    options = [ "defaults" ];
  };
fileSystems."/mnt/disk2" = {
  device = "/dev/disk/by-id/ata-ST2000DM008-2FR102_ZFL2E3C2-part1";
    fsType = "xfs"; # replace with the appropriate file system type
    options = [ "defaults" ];
  };
fileSystems."/mnt/disk3" = {
  device = "/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z10XKG-part1";
    fsType = "xfs"; # replace with the appropriate file system type
    options = [ "defaults" ];
  };
fileSystems."/mnt/disk4" = {
  device = "/dev/disk/by-id/ata-ST2000DM008-2FR102_ZFL5BAKB";
    fsType = "xfs"; # replace with the appropriate file system type
    options = [ "defaults" ];
  };
fileSystems."/mnt/storage" = {
  device = "/mnt/disk*";
    fsType = "fuse.mergerfs"; # replace with the appropriate file system type
    options = [ "defaults" ];
  };


#Systemd services
systemd.services.healthchecksio = {
  serviceConfig.User = "colin";
  serviceConfig.Type = "oneshot";
  path = [
        pkgs.curl
      ];
      script = "curl https://hc-ping.com/d416c575-422f-4b17-9b79-2a4f83f78f08"; 
};

#systemd timers
systemd.timers.healthchecksio = {
  wantedBy = [ "timers.target" ];
  partOf = [ "healthchecksio.service" ];
  timerConfig.OnCalendar = "minutely";
};


}
