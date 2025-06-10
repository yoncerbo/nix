{ pkgs, lib, ... }: {
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;

  environment.systemPackages = with pkgs; [
    helvum
    pavucontrol
    pamixer
  ];
}
