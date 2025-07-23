_: {
  enable = true;
  directories = [
    "/var/log"
    "/var/lib/nixos"
    "/var/lib/systemd/coredump"
    {
      directory = "/var/lib/colord";
      user = "colord";
      group = "colord";
      mode = "u=rwx,g=rx,o=";
    }
  ];
  files = [
    "/etc/machine-id"
    "/var/lib/sops/age/key.txt"
    {
      file = "/var/keys/secret_file";
      parentDirectory = {
        mode = "u=rwx,g=,o=";
      };
    }
  ];
}
