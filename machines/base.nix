{ config, pkgs, ... }:

{

    #env
    environment = {
        variables = {
        EDITOR = "nvim";
        };
    };

    # Bootloader.
    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
            };
        #kernelPackages = pkgs.linuxPackages_6_15;
    };



  # Set your time zone.
    time.timeZone = "America/Halifax";
  # Select internationalisation properties.
    i18n.defaultLocale = "en_CA.UTF-8";

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

    # Define a user account..
    users.users.colin = {
        isNormalUser = true;
        description = "colin";
        extraGroups = [ "networkmanager" "wheel" "docker" "1000" "dialout"];
    };

    #enable sound with pipewire
    security.rtkit.enable = true;


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

    system.stateVersion = "23.05"; # Do not change
  }



