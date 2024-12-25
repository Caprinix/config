{
  config.environment.persistence = {
    "/persistent/system" = {
      hideMounts = true;
      directories = [
        "/var/lib/bluetooth"
        "/etc/NetworkManager/system-connections"
      ];
      files = [];
    };
  };
}
