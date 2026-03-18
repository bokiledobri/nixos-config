{ config, pkgs, ... }:

{
  users.users.bojan = {
    isNormalUser = true;
    description = "Bojan";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  users.users.gaga = {
    isNormalUser = true;
    description = "Gaga";
    extraGroups = [ "networkmanager" "video" "audio" ];
  };
}
