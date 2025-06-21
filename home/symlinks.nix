{ config, ... }: let
  mkSymlinks = set: builtins.mapAttrs (k: v: {
    source = config.lib.file.mkOutOfStoreSymlink v;
  }) set;
in {
  xdg.configFile = mkSymlinks {
    niri = "/s/dot/niri";
    nushell = "/s/dot/nushell"; # history is a symlink to /a/nu-history
    hypr = "/s/dot/hypr";
    sway = "/s/dot/sway";
    foot = "/s/dot/foot";
    mako = "/s/dot/mako";
    wob = "/s/dot/wob";
    mpv = "/s/dot/mpv";
    river = "/s/dot/river";
    fuzzel = "/s/dot/fuzzel";
    networkmanager-dmenu = "/s/dot/networkmanager-dmenu";

    rclone = "/a/rclone";
    fcitx5 = "/a/fcitx5";
    nvim = "/a/nvim"; # symlink inside to /s/dot/nvim
    cmus = "/a/cmus";
    mozc = "/a/mozc";
    "BraveSoftware/Brave-Browser" = "/a/brave";
    obs-studio = "/a/obs";
    OpenTabletDriver = "/a/otd";
    qBittorrent = "/a/qBittorrent/";
    sunshine = "/a/sunshine";
    alvr = "/a/alvr";

    dolphin-emu = "/mnt/2/appdata/dolphin-emu/";
    azahar-emu = "/mnt/2/appdata/azahar-emu/";
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
    lutris = "/a/lutris";
    umu = "/a/umu"; # proton

    QRookie = "/mnt/2/games/QRookie";

    dolphin-emu = "/mnt/2/appdata/dolphin-emu/";
    azahar-emu = "/mnt/2/appdata/azahar-emu/";

    "applications/persist" = "/a/entries/";
    "applications/wine" = "/a/wine/apps/";
  };

  home.file = mkSymlinks {
    ".peaclock/config" = "/s/dot/peaclock";

    ".git-credentials" = "/a/git/git-credentials";
    ".rustup" = "/a/rustup";
    ".cargo" = "/a/cargo";
    ".gnupg" = "/a/gnupg";
    ".android" = "/a/android";
    ".password-store" = "/a/pass";
    ".minetest" = "/a/minetest/";
    ".steam" = "/a/steam/";
    ".wine" = "/a/wine2";
    ".zen" = "/a/zen/";

    ".cache/mpv" = "/a/mpv";

    f = "/f";
    n = "/n";
    s = "/s";
    a = "/a";
  };

}
