{ pkgs, lib, ... }: {
  hardware.pulseaudio.enable = lib.mkForce false;

  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;
}
