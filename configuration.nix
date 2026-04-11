# =========================================================================
# NIXOS MAIN CONFIG
# =========================================================================

{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
    ./system.nix
    ./desktop.nix
    ./users.nix
    ./packages.nix
    ./services.nix
  ];

  # Globalne varijable
  environment.variables.EDITOR = "nvim";

  # Verzija sistema (ne menjaj ovo)
  system.stateVersion = "25.11";
}
