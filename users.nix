{ config, pkgs, ... }:

{
  users.users.bojan = {
    isNormalUser = true;
    description = "Bojan";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
  };

  users.users.gaga = {
    isNormalUser = true;
    description = "Gaga";
    extraGroups = [ "networkmanager" "video" "audio" "wheel"];
  };
}
