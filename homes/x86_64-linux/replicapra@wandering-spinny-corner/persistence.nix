{
  config.home.persistence = {
    "/persistent/home/replicapra" = {
      directories = [
        "Documents"
        "Projects"
        ".local/share/Steam"
        ".local/share/containers"
        ".mozilla/firefox"
        ".distrobox"
      ];
      files = [ ];
      allowOther = true;
    };
  };
}
