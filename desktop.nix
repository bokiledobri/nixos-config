{ config, pkgs, ... }:

{
  # Grafički stack i Display Manager
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.sway.enable = true;
  programs.river-classic.enable = true;

  # Tastatura
  services.xserver.xkb = {
    layout = "us,rs";
    variant = "";
    options = "grp:alt_shift_toggle";
  };

  # Gnome Keyring — unlock at GDM login so OAuth tokens persist across sessions
  security.pam.services.gdm-password.enableGnomeKeyring = true;

  # Zvuk (PipeWire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
