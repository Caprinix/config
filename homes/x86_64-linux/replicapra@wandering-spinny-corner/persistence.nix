{
  config.home.persistence = {
    "/persistent/home" = {
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
