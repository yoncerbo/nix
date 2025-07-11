{ pkgs, ... }: {
  home.packages = [
    # Broswers
    pkgs.brave
    pkgs.librewolf
    # pkgs.qutebrowser

    pkgs.gnome-calculator
    pkgs.mpv
    pkgs.zathura
    pkgs.foot
    pkgs.anki-bin
    # pkgs.ani-cli

    pkgs.swayimg
    pkgs.feh
    pkgs.imv
  ];

  # home.pointerCursor.package = pkgs.vanilla-dmz;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
  };
}
