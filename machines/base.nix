# Summary: Shared system defaults (locale, services, users, nix settings).
{ config, pkgs, ... }:

{

    # Environment defaults for interactive shells.
    environment = {
        variables = {
        EDITOR = "nvim";
        };
    };

    # Bootloader and firmware handling.
    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
            };
        #kernelPackages = pkgs.linuxPackages_6_15;
    };



    # Locale and time defaults.
    time.timeZone = "America/Halifax";
  # Select internationalisation properties.
    i18n.defaultLocale = "en_CA.UTF-8";

        # Core services shared across machines.
    services = {
        #disable pulseAudio
        pulseaudio.enable = false;
        #CUPS
        printing.enable = true;
        #SSH Daemon
        openssh.enable = true;
        #syncthing
        syncthing.enable = false;
        #Tailscale
        tailscale.enable = true;
        #enable flatpaks
        flatpak.enable = true;
        #enable and define xserver
        desktopManager = {
            plasma6.enable = true;
        };
        displayManager = {
            sddm.enable = true;
        };
        xserver = {
            xkb.layout = "us";
            enable = true;
        };  
    # Enable sound with pipewire.
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };
  };

    # Primary user definition; machines can extend extraGroups.
    users.users.colin = {
        isNormalUser = true;
        description = "colin";
        extraGroups = [ "networkmanager" "wheel" "docker" "1000" "dialout"];
    };

    # Enable realtime scheduling needed by audio.
    security.rtkit.enable = true;

    # Nix settings and garbage collection.
    nixpkgs.config.allowUnfree = true;
    nix = {
        settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Deduplicate and optimize nix store
        auto-optimise-store = true;
        };

        gc = {
            automatic = true;
            dates = "weekly";
            options = "+5";
        };
};

    # NixOS release compatibility marker.
    system.stateVersion = "23.05"; # Do not change
  }



