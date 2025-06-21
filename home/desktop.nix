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


  gtk = {
    enable = true;
    theme.name = "orchis-theme";
    theme.package = pkgs.orchis-theme;
    iconTheme.name = "Adwaita";
    iconTheme.package = pkgs.adwaita-icon-theme;
    cursorTheme.name = "Adwaita";
    cursorTheme.package = pkgs.adwaita-icon-theme;
  };

  manual.html.enable = true;
}
