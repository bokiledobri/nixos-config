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
}
