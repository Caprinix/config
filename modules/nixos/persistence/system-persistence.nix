_: {
  enable = true;
  directories = [
    "/var/log"
    "/var/lib/nixos"
    "/var/lib/systemd/coredump"
    "/var/lib/containers"
    "/var/lib/docker"
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
      parentDirectory = {
        mode = "u=rwx,g=,o=";
      };
    }
  ];
}
