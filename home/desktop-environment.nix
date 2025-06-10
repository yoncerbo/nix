{ pkgs, ... }: {
  home.packages = [
    # Different compositors
    pkgs.niri
    pkgs.river
    pkgs.hyprland
    pkgs.sway

    # Stuff used in the config and utilities
    pkgs.fuzzel
    pkgs.xwayland
    pkgs.pinentry-qt
    pkgs.wl-clipboard
    pkgs.playerctl
    pkgs.brightnessctl
    pkgs.libnotify
    pkgs.mako
    pkgs.wob
    pkgs.wlr-randr
    pkgs.swaybg
  ];
}
