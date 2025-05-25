{ config, ... }: let
  mkSymlinks = set: builtins.mapAttrs (k: v: {
    source = config.lib.file.mkOutOfStoreSymlink v;
  }) set;
in {
  xdg.configFile = mkSymlinks {
    "niri/config.kdl" = "/s/dot/niri.kdl";
    "nushell/config.nu" = "/s/dot/config.nu";
    "nushell/env.nu" = "/s/dot/env.nu";
    "nushell/history.txt" = "/a/nu-history";
    "hypr/hyprland.conf" = "/s/dot/hyprland.conf";
    "sway/config" = "/s/dot/sway";
    "foot/foot.ini" = "/s/dot/foot.ini";
    "mako/config" = "/s/dot/mako.ini";
    "wob/wob.ini" = "/s/dot/wob.ini";
    "mpv/input.conf" = "/s/dot/mpv.conf";
    "river/init" = "/s/dot/river.sh";

    rclone = "/a/rclone";
    fcitx5 = "/a/fcitx5";
    nvim = "/a/nvim";
    cmus = "/a/cmus";
    mozc = "/a/mozc";
    "BraveSoftware/Brave-Browser" = "/a/brave";
    obs-studio = "/a/obs";
    OpenTabletDriver = "/a/otd";
    dolphin-emu = "/a/dolphin/";
    azahar-emu = "/a/azahar/";
  };

  xdg.dataFile = mkSymlinks {
    fcitx5 = "/a/fcitx5";
    nvim = "/a/nvim";
    nix = "/a/nix";
    zathura = "/a/zathura";
    Anki2 = "/a/anki";
    Steam = "/a/steam-data";
    PrismLauncher = "/a/prism";
    osu = "/a/osu/";
    dolphin-emu = "/a/dolphin/";
    azahar-emu = "/a/azahar/";
    lutris = "/a/lutris";

    "applications/persist" = "/a/entries/";
    "applications/wine" = "/a/wine/apps/";
  };

  home.file = mkSymlinks {
    ".peaclock/config" = "/s/dot/peaclock";

    ".rustup" = "/a/rustup";
    ".cargo" = "/a/cargo";
    ".gnupg" = "/a/gnupg";
    ".android" = "/a/android";
    ".password-store" = "/a/pass";
    ".minetest" = "/a/minetest/";
    ".steam" = "/a/steam/";
    ".wine" = "/a/wine2";

    ".cache/mpv" = "/a/mpv";

    f = "/f";
    n = "/n";
    s = "/s";
    a = "/a";
  };

}
