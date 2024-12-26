{
  config.environment.persistence = {
    "/persistent/system" = {
      directories = [
        "/var/lib/bluetooth"
        "/etc/NetworkManager/system-connections"
      ];
      files = [];
    };
  };
}
