{ lib, config, pkgs, ...}: {
  imports = [
    ./home/git.nix
    ./home/neovim.nix
    # ./home/tmux.nix
    # ./home/xdg-portal.nix
    ./home/symlinks.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "m";
    homeDirectory = "/home/m";
    stateVersion = "22.11";
    packages = import ./pkgs.nix pkgs;
  };

  manual.html.enable = true;

  # home.pointerCursor.package = pkgs.vanilla-dmz;

  xdg.mimeApps.enable = true;

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
  };
}
