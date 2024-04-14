{ config, pkgs, ... }:

{

  #hardware, bluetooth
    hardware = {
        bluetooth = {
            enable = true; # enables support for Bluetooth
            powerOnBoot = true; # powers up the default Bluetooth controller on boot
        };
    };

}
