{ lib, ... }: {
  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
  };

  systemd.services.waydroid-container.wantedBy = lib.mkForce [];
}
