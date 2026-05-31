{ pkgs, ... }: {
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.bluetooth.settings.General.FastConnectable = true;

  # For bluetooth support
  services.pulseaudio.package = pkgs.pulseaudioFull;

  environment.systemPackages = [ pkgs.bluez ];
}
