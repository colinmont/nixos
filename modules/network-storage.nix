{ config, pkgs, ... }:

{

    fileSystems."/mnt/storage" = {
        device = "//server/storage";
        fsType = "cifs";
        options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,uid=colin";
        in ["${automount_opts},credentials=/etc/nixos/secrets/smbsecrets"];
    };

    fileSystems."/mnt/appdata" = {
        device = "//server/appdata";
        fsType = "cifs";
        options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,uid=colin";
        in ["${automount_opts},credentials=/etc/nixos/secrets/smbsecrets"];
    };

    fileSystems."/mnt/media" = {
        device = "//server/media/media";
        fsType = "cifs";
        options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,uid=colin";
        in ["${automount_opts},credentials=/etc/nixos/secrets/smbsecrets"];
    };

}
