{ pkgs, lib, ... }: {
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;

  environment.systemPackages = with pkgs; [
    crosspipe
    pavucontrol
    pamixer
    pulseaudio # for pactl
  ];

  # https://davidelettieri.it/2024/02/04/fedora-pipewire-switch-channels
  services.pipewire.wireplumber.enable = true;
  services.pipewire.wireplumber.extraConfig."change-channels"."monitor.alsa.rules" = [{
    matches = [{
      "node.name" = "alsa_output.usb-ACTIONS_Pebble_V3-00.analog-stereo";
    }];
    actions."update-props" = {
      "audio.position" = "FR,FL";
    };
  }];
}
