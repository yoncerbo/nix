{ pkgs, ... }: {
  home.packages = [
    # Different compositors
    # pkgs.niri
    # pkgs.river
    # pkgs.hyprland
    # pkgs.xwayland
    # pkgs.sway

    # Stuff used in the config and utilities
    pkgs.wdisplays
    pkgs.swayidle
    pkgs.waybar
    pkgs.hyprlock
    pkgs.fuzzel
    pkgs.bzmenu
    pkgs.networkmanager_dmenu
    pkgs.pinentry-qt
    pkgs.wl-clipboard
    pkgs.playerctl
    pkgs.brightnessctl
    pkgs.libnotify
    pkgs.mako
    pkgs.wob
    pkgs.wlr-randr
    pkgs.swaybg
    pkgs.wpaperd
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    settings.source = "/s/dot/hypr/hyprland.conf";
  };
  
  programs = {
    hyprlock.enable = true;
  };

  services = {
    # hyprsunset.enable = true;
    hyprpolkitagent.enable = true;
    hypridle.enable = true;
  };
}
