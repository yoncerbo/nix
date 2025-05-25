{ pkgs, lib, config, zen-browser, inputs, ... }: {
  imports = [
    # ./wordpress.nix
    ./tablet.nix
    ./fonts.nix
    ./audio.nix
    ./bluetooth.nix
    ./localization.nix
    # ./waydroid.nix
    # ./kanata.nix
    # ./keyd.nix
    ./localization.nix
    ./mounts.nix
    ./sudo.nix
    ./networking.nix
    ./keyboard.nix
    ./vr.nix
  ];
}
