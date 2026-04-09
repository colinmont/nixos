# Summary: Home-manager profile for user colin on host go (packages, shell, apps).
{ config, pkgs, ... }:

{
  imports = [];

  # Home Manager basic info
  home.username = "colin";
  home.homeDirectory = "/home/colin";
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # ============================================
  # Packages
  # ============================================
  home.packages = with pkgs; [

  ];





  # ============================================
  # File Creation
  # ============================================
  home.file = {
   
  };

  # ============================================
  # Session Variables
  # ============================================
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "kitty";
    BROWSER = "firefox";
    
    # Better defaults
    LESS = "-R --mouse --wheel-lines=3";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    
    # Nix
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # ============================================
  # Path additions
  # ============================================
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
