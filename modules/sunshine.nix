{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.sunshine;

in

{
  options = {

    services.sunshine = {
      enable = mkEnableOption (mdDoc "Sunshine");
    };

  };

  config = mkIf config.services.sunshine.enable {

    boot.kernelModules = [ "uinput" ];

    services = {
        avahi = {
          enable = true;
          publish = { enable = true; };
        };
      };

    environment.systemPackages = [
      pkgs.sunshine
    ];

    security.wrappers.sunshine = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+p";
      source = "${pkgs.sunshine}/bin/sunshine";
    };


    systemd.user.services.sunshine =
      {
        description = "sunshine";
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${config.security.wrapperDir}/sunshine";
        };
      };

  };
}


