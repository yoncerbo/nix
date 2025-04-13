# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "uas" "usb_storage" "sd_mod" ];

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/26288def-a47b-47da-b2c8-f906ef9b6e6f";
    fsType = "ext4";
    neededForBoot = true;
  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/BBE7-1259";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/591388f6-3fc1-4d47-9791-80b256f25032"; }
    ];
}
