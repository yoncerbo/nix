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
    "etc/NetworkManager/system-connections" = "/persist/a/network-manager/";
    "/etc/nixos" = "/persist/s/nix";
    # "etc/machine-id" = "/a/machine-id";

    "/f" = "/persist/f/";
    "/s" = "/persist/s/";
    "/a" = "/persist/a/";
    "/n" = "/persist/n/";
  };

}
