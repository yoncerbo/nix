{ pkgs, ... }: {
  home.packages = [
    pkgs.rnote # notes
    pkgs.saber # notes
    pkgs.motrix # downloader
    pkgs.qbittorrent

    pkgs.xorg.xlsclients
  ];
}
