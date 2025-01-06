{lib, ...}: {
  imports = [
    ./nix.nix
    ./users.nix
  ];

  config = {
    boot.tmp.cleanOnBoot = true;
  };
}
