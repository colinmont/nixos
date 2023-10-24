{ config, pkgs, ... }:

{

  imports =
    [

    ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "colin";
  home.homeDirectory = "/home/colin";

  home.packages = with pkgs; [                              
    htop
    firefox
    kate
    thunderbird
    libreoffice
    ryujinx
    yuzu    
    sunshine
  ];
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backward
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName  = "Colin";
    userEmail = "cm@mntg.ca";
  };

}
