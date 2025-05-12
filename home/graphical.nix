{ pkgs, ... }: {
  home.packages = [
    # Broswers
    pkgs.brave
    pkgs.librewolf
    # pkgs.qutebrowser

    pkgs.mpv
    pkgs.zathura
    pkgs.foot
    pkgs.anki-bin
    pkgs.gimp
    pkgs.obs-studio
    pkgs.krita
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
