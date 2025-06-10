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

  manual.html.enable = true;
}
