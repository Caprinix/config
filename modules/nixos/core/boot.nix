_: {
  config = {
    boot.tmp.cleanOnBoot = true;
    boot.readOnlyNixStore = true;
    boot.loader.timeout = 30;
    boot.loader.grub.configurationLimit = 5;
    boot.loader.systemd-boot.configurationLimit = 5;
    boot.loader.systemd-boot.editor = false;
  };
}
