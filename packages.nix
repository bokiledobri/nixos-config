{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    git
    firefox
    wtype
    nvd
    neovide
    inotify-tools
    emacs
    vscode-fhs
    podman-compose
    zoom-us

   # Graficki alati
    inkscape
    imagemagick
    krita
    scribus
    ghostscript
    graphicsmagick
    gawk
    vips

   # Python
    python3Packages.pyvips
    pyright
    ruff

   # Moderni CLI alati 
    bun
    eza         
    bat        
    fd        
    ripgrep  
    bottom  
    zoxide 
    fzf   
    wl-clipboard
    unzip
    just
    neofetch
    tmux
    gigalixir

    # Sway dodaci
    foot
    wofi
    i3status
    swaybg
    waybar

    # Programski jezici
    elixir
    erlang
    go
    nodejs
    python3
    gcc
    gnumake
    tree-sitter
    
    # Kodeci
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
  ];
}
