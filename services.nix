{ config, pkgs, ... }:
{
services.postgresql = {
    enable = true;
    
    # 1. ZAKUCAVANJE VERZIJE (Ključna linija)
    # Možeš izabrati postgresql_14, 15 ili 16. Šta god staviš, tu ostaje zauvek.
    package = pkgs.postgresql_15;
    
    # 2. Podešavanje za Elixir/Ecto (TCP konekcije)
    enableTCPIP = true;
    
    # 3. Autentifikacija za lokalni razvoj (Trust)
    # Ovo dozvoljava tvom Phoenix serveru da se poveže bez komplikacija sa lozinkama
    authentication = pkgs.lib.mkOverride 10 ''
      # type database  user  auth-method
      local  all       all   trust
      host   all       all   127.0.0.1/32 trust
      host   all       all   ::1/128      trust
    '';
  };
  services.redis.servers.main = {
    enable = true;
    port = 6379;
  };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Dozvoljava ti da koristiš 'docker' i 'docker-compose' komande
  };
  # Fix za Gemini Code Assist (Google-ov kod ne ume sam da kreira temp folder)
  systemd.tmpfiles.rules = [
    "d /tmp/gemini 0777 root root -"
    "d /tmp/gemini/ide 0777 root root -"
  ];
}
