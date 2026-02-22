# Summary: Bluetooth enablement module shared by machines.
{ config, pkgs, ... }:

{

    # Hardware Bluetooth support and boot-time power state.
    hardware = {
        bluetooth = {
            enable = true; # enables support for Bluetooth
            powerOnBoot = true; # powers up the default Bluetooth controller on boot
        };
    };

}
