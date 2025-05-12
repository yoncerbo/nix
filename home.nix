{ lib, config, pkgs, ...}: {
  imports = [
    ./home/git.nix
    ./home/neovim.nix
    # ./home/tmux.nix
    # ./home/xdg-portal.nix
    ./home/symlinks.nix
    ./home/graphical.nix
    ./home/desktop-environment.nix
    ./home/cli.nix
    ./home/gaming.nix
    ./home/language-servers.nix
    ./home/programming.nix
    ./home/pkgs.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "m";
    homeDirectory = "/home/m";
    stateVersion = "22.11";
  };

  manual.html.enable = true;
}
