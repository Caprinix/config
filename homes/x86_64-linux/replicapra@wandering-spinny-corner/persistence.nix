{
  config.home.persistence = {
    "/persistent/home/replicapra" = {
      directories = [
        "Documents"
        "Projects"
        ".local/share/Steam"
        ".mozilla/firefox"
      ];
      files = [ ];
      allowOther = true;
    };
  };
}
