{ lib, config, pkgs, ...}:
let
  mkSymlinks = set: builtins.mapAttrs (k: v: {
    source = config.lib.file.mkOutOfStoreSymlink v;
  }) set;
in {

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
      userName = "meersen";
      userEmail = "<>";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
  };

  manual.html.enable = true;

  # home.pointerCursor.package = pkgs.vanilla-dmz;
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      libsForQt5.fcitx5-qt
      fcitx5-gtk
      fcitx5-mozc # japanese
      fcitx5-hangul # korean
      fcitx5-chinese-addons
      fcitx5-rime # chinese
      fcitx5-m17n
      fcitx5-table-other
      fcitx5-configtool
    ];
  };

  # Shell command to run in file changed between generations
  # xdg.configFile.<name>.onChange

  xdg.configFile = mkSymlinks {
    "niri/config.kdl" = "/s/dot/niri.kdl";
    "nushell/config.nu" = "/s/dot/nu/config.nu";
    "nushell/env.nu" = "/s/dot/nu/env.nu";
    "nushell/history.txt" = "/s/dot/nu/history";
    "hypr/hyprland.conf" = "/s/dot/hyprland.conf";
    "sway/config" = "/s/dot/sway";
    "foot/foot.ini" = "/s/dot/foot.ini";
    "mako/config" = "/s/dot/mako.ini";
    "wob/wob.ini" = "/s/dot/wob.ini";
    "mpv/input.conf" = "/s/dot/mpv.conf";

    fcitx5 = "/f/fcitx5";
    nvim = "/f/nvim";
    cmus = "/f/cmus";
    mozc = "/f/mozc";
    "BraveSoftware/Brave-Browser" = "/f/brave";
  };

  xdg.dataFile = mkSymlinks {
    fcitx5 = "/f/fcitx5";
    nvim = "/f/nvim";
    nix = "/f/nix";
    zathura = "/f/zathura";
  };

  home.file = mkSymlinks {
    ".rustup" = "/f/rustup";
    ".cargo" = "/f/cargo";
    ".gnupg" = "/f/gnupg";
    ".peaclock/config" = "/s/dot/peaclock";
    ".android" = "/f/android";

    ".cache/mpv" = "/f/mpv";

    f = "/f";
    n = "/n";
    s = "/s";
    a = "/a";
  };
}
