{ config, pkgs, ... }:
{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
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
  services.ollama = {
    enable = true;
  };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Dozvoljava ti da koristiš 'docker' i 'docker-compose' komande
  };
  systemd.services.backup-debug-memory = {
    description = "Sync Vector DB to Google Drive via Rclone";
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    path = with pkgs; [ rclone ];
    script = ''
      cp /home/bojan/.smriti/bokiledobri/memory.lbug /tmp/memory.lbug
      rclone --config /home/bojan/.config/rclone/rclone.conf copy /tmp/memory.lbug gdrive:/backups
      rm /tmp/memory.lbug
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "bojan";
      Environment = "HOME=/home/bojan";
    };
  };

  systemd.timers.backup-debug-memory = {
    description = "Timer for Vector DB Backup";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 04:00:00";
      Persistent = true;
    };
  };
  systemd.user.services.smriti-gateway = {
    description = "Smriti MCP Gateway (stdio → HTTP on :8765)";
    wantedBy = [ "default.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "/home/bojan/.local/bin/smriti-gateway";
      Restart = "on-failure";
      RestartSec = 5;
      EnvironmentFile = "/home/bojan/.config/environment.d/api-keys.conf";
      Environment = "PATH=/run/current-system/sw/bin:/run/wrappers/bin:/home/bojan/.local/bin:/home/bojan/.nix-profile/bin";
    };
  };

  systemd.services.litellm = {
    description = "LiteLLM Proxy (AI gateway, port 11000)";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.litellm}/bin/litellm --config /home/bojan/.config/litellm/config.yaml --host 127.0.0.1 --port 11000";
      Restart = "on-failure";
      RestartSec = 5;
      User = "bojan";
      EnvironmentFile = "/home/bojan/.config/environment.d/api-keys.conf";
      Environment = "HOME=/home/bojan";
    };
  };

  systemd.services.codex-relay = {
    description = "Codex Responses API proxy → LiteLLM (port 8090)";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" "litellm.service" ];
    requires = [ "litellm.service" ];
    serviceConfig = {
      ExecStart = "/home/bojan/.bun/bin/bun run /home/bojan/.local/bin/codex-proxy.js";
      Restart = "on-failure";
      RestartSec = 5;
      User = "bojan";
      Environment = "HOME=/home/bojan";
    };
  };

  # Fix za Gemini Code Assist (Google-ov kod ne ume sam da kreira temp folder)
  systemd.tmpfiles.rules = [
    "d /tmp/gemini 0777 root root -"
    "d /tmp/gemini/ide 0777 root root -"
  ];
}
