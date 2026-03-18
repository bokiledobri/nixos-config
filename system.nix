{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "sr_RS/UTF-8"
    "sr_RS@latin/UTF-8"
  ];

  nixpkgs.config.allowUnfree = true;

  # Swap
  swapDevices = [ { device = "/var/lib/swapfile"; size = 16384; } ];

  # Automatski Garbage Collector (briše generacije starije od 7 dana)
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Magični trik za štednju prostora (Hardlinkovanje identičnih fajlova)
  nix.settings.auto-optimise-store = true;
}
