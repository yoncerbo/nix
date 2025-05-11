{ pkgs, ... }: {
  hardware.bluetooth.enable = true;
  # For bluetooth support
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
}
