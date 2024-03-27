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
      enable = true;
      userName = "meersehn";
      userEmail = "<>";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };

  manual.html.enable = true;

  # wayland.windowManager.sway.enable = true;

  # check sway customization
  # check dconf
  # i18n.inputMethod
  # launchd
  # nix
  # programs
  # services
  # systemd.automount 5

  # home.pointerCursor.package = pkgs.vanilla-dmz;
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      libsForQt5.fcitx5-qt
      fcitx5-gtk
      fcitx5-mozc # japanese
      fcitx5-hangul # korean
      fcitx5-chinese-addons
      # fcitx5-rime # chinese
      fcitx5-m17n
      fcitx5-table-other
      fcitx5-configtool
    ];
  };

  # Shell command to run in file changed between generations
  # xdg.configFile.<name>.onChange

  xdg.configFile = mkSymlinks {
    "nushell/config.nu" = "/f/config.nu";
    "nushell/env.nu" = "/f/env.nu";
    "hypr/hyprland.conf" = "/f/hyprland.conf";
    "sway/config" = "/f/sway";
    "foot/foot.ini" = "/f/foot.ini";
    "mako/config" = "/f/mako.ini";
    "wob/wob.ini" = "/f/wob.ini";
    "mpv/input.conf" = "/f/mpv.conf";
    "niri/config.kdl" = "/f/niri.kdl";

    "nushell/history.txt" = "/f/nushell-history.txt";
    fcitx5 = "/f/fcitx5";
    nvim = "/f/nvim-data";
    cmus = "/f/cmus";
    mozc = "/f/mozc";
    "BraveSoftware/Brave-Browser" = "/f/brave";
  };

  xdg.dataFile = mkSymlinks {
    fcitx5 = "/f/fcitx5";
    nvim = "/f/nvim-data";
    nix = "/f/nix-data";
    zathura = "/f/zathura";
  };

  home.file = mkSymlinks {
    ".rustup" = "/f/rustup";
    ".cargo" = "/f/cargo";
    ".gnupg" = "/f/gnupg";
  };
}
