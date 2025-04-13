{ lib, config, pkgs, ...}:
let
  mkSymlinks = set: builtins.mapAttrs (k: v: {
    source = config.lib.file.mkOutOfStoreSymlink v;
  }) set;
in {
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "m";
    homeDirectory = "/home/m";
    stateVersion = "22.11";
    packages = import ./pkgs.nix pkgs;
  };

  programs = {
    neovim = {
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    git = {
      enable = true;
      userName = "meersen";
      userEmail = "<>";
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "store";
      };
    };
    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        resurrect
      ];
      extraConfig = ''
        source-file /a/tmux/tmux.conf
        unbind C-a
        set-option -g prefix C-a

        # Fix for wrong colors
        set-option -ga terminal-overrides ",xterm-256color:Tc

        # Fix escape delay
        set -sg escape-time 5

        set -g status-style "bg=black"
        set -g status-style "fg=white"

        set -g default-shell nu

        set -g @resurrect-strategy-nvim "session"
        set -g @resurrect-strategy-vim "session"
      '';
    };
  };

  manual.html.enable = true;

  # home.pointerCursor.package = pkgs.vanilla-dmz;

  # Shell command to run in file changed between generations
  # xdg.configFile.<name>.onChange

  xdg.configFile = mkSymlinks {
    "niri/config.kdl" = "/d/niri.kdl";
    "nushell/config.nu" = "/d/config.nu";
    "nushell/env.nu" = "/d/env.nu";
    "nushell/history.txt" = "/a/nu-history";
    "hypr/hyprland.conf" = "/d/hyprland.conf";
    "sway/config" = "/d/sway";
    "foot/foot.ini" = "/d/foot.ini";
    "mako/config" = "/d/mako.ini";
    "wob/wob.ini" = "/d/wob.ini";
    "mpv/input.conf" = "/d/mpv.conf";
    "river/init" = "/d/river.sh";

    rclone = "/a/rclone";
    fcitx5 = "/a/fcitx5";
    nvim = "/a/nvim";
    cmus = "/a/cmus";
    mozc = "/a/mozc";
    "BraveSoftware/Brave-Browser" = "/a/brave";
    obs-studio = "/a/obs";
    OpenTabletDriver = "/a/otd";
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

    "applications/wine" = "/a/wine/apps/";
    desktop-directories = "/a/wine/desktop-directories/";
  };

  home.file = mkSymlinks {
    ".peaclock/config" = "/d/peaclock";

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
    d = "/d";
    m = "/m";
  };

  xdg.mimeApps.enable = true;

  xdg.desktopEntries.textractor = {
    name = "Textractor";
    exec = "env WINEPREFIX=/home/m/.wine wine /home/m/.wine/drive_c/users/m/Desktop/Textractor/x86/Textractor.exe";
    # path = "~/.wine/drive_c/users/m/Desktop/Textractor/";
    type = "Application";
  };

  xdg.desktopEntries.unred-night = {
    name = "Unred Night";
    exec = "env WINEPREFIX=/home/m/.wine LANG=ja_JP.UTF-8 wine /m/vn/unred-night/URN.exe";
    # path = "/m/vn/unred-night/";
    type = "Application";
  };

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };
}
