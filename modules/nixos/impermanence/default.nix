{
  lib,
  config,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkAfter
    mkOption
    types
    ;
  inherit (lib.caprinix-essentials.modules) mkIfEnabled;

  cfg = config.caprinix.impermanence;
in {
  options.caprinix.impermanence = {
    enable = mkEnableOption "impermanence";
    retentionDuration = mkOption {
      default = 7;
      description = "Number of days to keep old roots";
      type = types.int;
    };
  };

  config = mkIfEnabled cfg {
    boot.initrd.postDeviceCommands = mkAfter ''
      mkdir /btrfs_tmp
      mount /dev/root_vg/root /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi
      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }
      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +${toString cfg.retentionDuration}); do
          delete_subvolume_recursively "$i"
      done
      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
    '';

    fileSystems."/persistent".neededForBoot = true;

    programs.fuse.userAllowOther = true;
  };
}
