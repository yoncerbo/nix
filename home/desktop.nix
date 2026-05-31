{ lib, config, pkgs, ...}: {
  imports = [
    ./git.nix
    ./neovim.nix
    # ./tmux.nix
    ./xdg-portal.nix
    ./symlinks.nix

    # Packages
    ./graphical.nix
    ./desktop-environment.nix
    ./cli.nix
    ./gaming.nix
    ./language-servers.nix
    ./programming.nix
    ./pkgs.nix
    ./obs.nix
    ./desktop-pkgs.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "m";
    homeDirectory = "/home/m";
    stateVersion = "22.11";
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "xcb";
  };

  # https://discourse.nixos.org/t/struggling-to-configure-gtk-qt-theme-on-laptop/42268/4
  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Light-Cursors";
      package = pkgs.catppuccin-cursors.mochaLight;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Mocha-Light-Cursors";
    package = pkgs.catppuccin-cursors.mochaLight;
    size = 16;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = "Breeze-Dark";
    color-scheme = "prefer-dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "gtk2";
    style.package = pkgs.kdePackages.breeze-gtk;
  };

  home.packages = [
    pkgs.papirus-folders
  ];

  programs.ghostty = {
    enable = true;
    systemd.enable = true;
  };

  manual.html.enable = true;

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  services.mpris-proxy.enable = true;
}
