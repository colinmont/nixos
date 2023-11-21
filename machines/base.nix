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
        kernelPackages = pkgs.linuxPackages_latest;
    };

  # Set your time zone.
    time.timeZone = "America/Halifax";
  # Select internationalisation properties.
    i18n.defaultLocale = "en_CA.UTF-8";

    services = {
        #CUPS
        printing.enable = true;
        #SSH Daemon
        openssh.enable = true;
        #syncthing
        syncthing.enable = true;
        #Tailscale
        tailscale.enable = true;
        #enable and define xserver
        flatpak.enable = true;

        xserver = {
            layout = "us";
            xkbVariant = "";
            displayManager = {
                gdm.enable = true;
                autoLogin.enable = true;
                autoLogin.user = "colin";
                defaultSession = "gnome";
            };
            desktopManager.gnome.enable = true;
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

    nix.settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };

    system.stateVersion = "23.05"; # Did you read the comment?

  }



