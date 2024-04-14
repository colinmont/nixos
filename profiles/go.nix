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

  ];

  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
