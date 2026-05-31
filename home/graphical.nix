{ pkgs, ... }: {
  home.packages = [
    # Broswers
    pkgs.brave
    pkgs.librewolf
    # pkgs.qutebrowser

    pkgs.gnome-calculator
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
    "text/html" = "zen.desktop";
    "x-scheme-handler/http" = "zen.desktop";
    "x-scheme-handler/https" = "zen.desktop";
  };

  programs.mpv = {
    enable = true;

    package = (
      pkgs.mpv.override {
        scripts = with pkgs.mpvScripts; [
          uosc
          sponsorblock
          thumbfast
          quality-menu
          mpris
        ];

        # mpv = pkgs.mpv-unwrapped.override {
        #   waylandSupport = true;
        # };
      }
    );
  };

}
