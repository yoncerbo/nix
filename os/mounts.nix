let
  mkBinds = set: builtins.attrValues (builtins.mapAttrs (k: v: {
    where = k;
    what = v;
    wantedBy = [ "multi-user.target" ];
    type = "none";
    options = "bind";
  }) set);
in {
  systemd.mounts = mkBinds {
    "etc/NetworkManager/system-connections" = "/a/network-manager/";
    "etc/machine-id" = "/a/machine-id";
    "/etc/nixos" = "/d/nix";
    "/f" = "/nix/files/";
    "/s" = "/nix/source/";
    "/a" = "/nix/app/";
    "/d" = "/nix/dot/";
    "/m" = "/nix/media/";
  };

  fileSystems."/usb" = {
    device = "/dev/disk/by-uuid/75757fe7-c997-4b8b-9f8a-67e8e289ad64";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" ];
  };

}
