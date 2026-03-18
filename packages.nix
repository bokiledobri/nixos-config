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
    
   # Moderni CLI alati (Rust alternative)
    eza         
    bat        
    fd        
    ripgrep  
    bottom  
    zoxide 
    fzf   
    wl-clipboard

    # Sway dodaci
    foot
    wofi
    i3status
    swaybg

    # Programski jezici
    elixir
    erlang
    go
    nodejs
    python3
    
    # Kodeci
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
  ];
}
