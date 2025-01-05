_: {
  enable = true;
  directories = [
    "/var/log"
    "/var/lib/nixos"
    "/var/lib/systemd/coredump"
    "/var/lib/sops-nix"
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
    "/etc/ssh/ssh_host_ed25519_key"
    "/etc/ssh/ssh_host_ed25519_key.pub"
    "/var/lib/sops/age/key.txt"
    {
      file = "/var/keys/secret_file";
      parentDirectory = {
        mode = "u=rwx,g=,o=";
      };
    }
  ];
}
