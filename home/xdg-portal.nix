{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = [ "gtk" ];
    config.common."org.freedesktop.impl.portal.Screencast" = [ "river" ];
    config.common."org.freedesktop.portal.Screencast" = [ "river" ];
  };
}
