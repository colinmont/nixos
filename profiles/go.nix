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
    # CLI utilities
    eza          # Modern ls replacement
    fzf          # Fuzzy finder
    ripgrep      # Fast grep
    fd           # Fast find
    bat          # Syntax highlighting cat
    jq           # JSON processor
    yq           # YAML processor
    htop         # Process viewer
    tree         # Directory tree
    unzip
    p7zip

    # Development tools
    gh           # GitHub CLI
    lazygit      # Terminal UI for git
    difftastic   # Modern diff tool
    just         # Command runner

    # Nix tools
    nix-tree     # Browse nix store
    nix-output-monitor
    comma        # Run packages without installing

    # Terminal
    kitty        # GPU-accelerated terminal
  ];

  # ============================================
  # Shell Configuration (Bash)
  # ============================================
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "ll" = "eza -la --group-directories-first";
      "la" = "eza -a --group-directories-first";
      "ls" = "eza --group-directories-first";
      "lt" = "eza -la --tree --level=2";
      
      # Tools
      "cat" = "bat --paging=never";
      "grep" = "rg";
      "find" = "fd";
      "top" = "htop";
      
      # Nix
      "nixbuild" = "sudo nixos-rebuild switch --flake /etc/nixos#go";
      "nixhome" = "home-manager switch --flake /etc/nixos#colin@go";
      "nixupdate" = "nix flake update --flake /etc/nixos";
      "nixclean" = "sudo nix-collect-garbage -d";
      
      # Git shortcuts
      "g" = "git";
      "gs" = "git status";
      "ga" = "git add";
      "gc" = "git commit";
      "gp" = "git push";
      "gl" = "git pull";
      "gd" = "git diff";
      "lg" = "lazygit";
    };

    initExtra = ''
      # FZF integration
      eval "$(fzf --bash)"
      
      # Better history
      export HISTSIZE=100000
      export HISTFILESIZE=100000
      export HISTCONTROL=ignoreboth:erasedups
      
      # Default editor
      export EDITOR="nvim"
      export VISUAL="nvim"
      
      # Starship prompt (if we add it later)
      # eval "$(starship init bash)"
    '';
  };

  # ============================================
  # Git Configuration
  # ============================================
  programs.git = {
    enable = true;
    userName = "colin";
    userEmail = "colin@example.com";  # User should update this
    
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = false;
      
      core = {
        editor = "nvim";
        pager = "bat --paging=always";
      };
      
      diff = {
        tool = "difftastic";
        external = "difft";
      };
      
      difftool = {
        prompt = false;
      };
      
      merge = {
        tool = "vimdiff";
        conflictstyle = "diff3";
      };
      
      color = {
        ui = true;
      };
      
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        visual = "!gitk";
      };
    };
  };

  # ============================================
  # FZF Configuration
  # ============================================
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
      "--preview 'bat --color=always --style=header,grid --line-range :300 {}'"
    ];
    
    fileWidgetOptions = [
      "--preview 'bat --color=always --style=header,grid --line-range :300 {}'"
    ];
  };

  # ============================================
  # Bat Configuration
  # ============================================
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "numbers,changes,header";
    };
  };

  # ============================================
  # Eza Configuration
  # ============================================
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    icons = "auto";
    git = true;
  };

  # ============================================
  # Direnv (for per-directory env vars)
  # ============================================
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # ============================================
  # Kitty Terminal Configuration
  # ============================================
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 10;
      
      # Performance
      scrollback_lines = 10000;
      enable_audio_bell = false;
      
      # Appearance
      background_opacity = "0.95";
      window_padding_width = 4;
      
      # Tab bar
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      
      # Colors (Catppuccin Mocha-like)
      background = "#1e1e2e";
      foreground = "#cdd6f4";
      cursor = "#f5e0dc";
      cursor_text_color = "#1e1e2e";
      selection_background = "#353749";
      selection_foreground = "#cdd6f4";
      color0 = "#45475a";
      color1 = "#f38ba8";
      color2 = "#a6e3a1";
      color3 = "#f9e2af";
      color4 = "#89b4fa";
      color5 = "#f5c2e7";
      color6 = "#94e2d5";
      color7 = "#bac2de";
      color8 = "#585b70";
      color9 = "#f38ba8";
      color10 = "#a6e3a1";
      color11 = "#f9e2af";
      color12 = "#89b4fa";
      color13 = "#f5c2e7";
      color14 = "#94e2d5";
      color15 = "#a6adc8";
    };
  };

  # ============================================
  # Neovim (user-level config)
  # ============================================
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    
    extraConfig = ''
      " Basic settings
      set number
      set relativenumber
      set cursorline
      set expandtab
      set shiftwidth=2
      set tabstop=2
      set softtabstop=2
      set autoindent
      set smartindent
      set wrap
      set linebreak
      set scrolloff=8
      set sidescrolloff=8
      set hlsearch
      set incsearch
      set ignorecase
      set smartcase
      set showmatch
      set matchtime=2
      set splitbelow
      set splitright
      set hidden
      set backup
      set writebackup
      set undofile
      set swapfile
      set clipboard=unnamedplus
      set mouse=a
      set termguicolors
      set background=dark
      set completeopt=menu,menuone,noselect
      set pumheight=10
      set signcolumn=yes
      set colorcolumn=80,120
      set laststatus=2
      set showcmd
      set showmode
      set ruler
      set wildmenu
      set wildmode=longest:full,full
      
      " Enable syntax highlighting
      syntax on
      filetype plugin indent on
      
      " Colorscheme (using built-in habamax as fallback)
      colorscheme habamax
      
      " Key mappings
      let mapleader = " "
      nnoremap <leader>w :w<CR>
      nnoremap <leader>q :q<CR>
      nnoremap <leader>x :x<CR>
      nnoremap <leader>h :noh<CR>
      nnoremap <leader>sv :vsplit<CR>
      nnoremap <leader>sh :split<CR>
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l
      
      " Better indenting in visual mode
      vnoremap < <gv
      vnoremap > >gv
      
      " Move lines in visual mode
      vnoremap J :m '>+1<CR>gv=gv
      vnoremap K :m '<-2<CR>gv=gv
    '';
  };

  # ============================================
  # Home Directory Organization (XDG)
  # ============================================
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
      desktop = "$HOME/Desktop";
      templates = "$HOME/Templates";
      publicShare = "$HOME/Public";
    };
  };

  # ============================================
  # File Creation
  # ============================================
  home.file = {
    # Create empty directories for organization
    "Projects/.keep".text = "";
    
    # Git ignore global
    ".config/git/ignore".text = ''
      # IDE
      .idea/
      .vscode/
      *.swp
      *.swo
      *~
      
      # OS
      .DS_Store
      Thumbs.db
      
      # Build
      build/
      dist/
      *.o
      *.so
      *.a
      
      # Logs
      *.log
      logs/
      
      # Environment
      .env
      .env.local
      
      # Nix
      result
      result-*
    '';
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
