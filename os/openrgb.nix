{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    openrgb
  ];

  services.hardware.openrgb.enable = true;
}
