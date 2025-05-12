{ pkgs, ... }: {
  home.packages = [
    pkgs.rnote # notes
    pkgs.saber # notes
    pkgs.motrix # downloader

    pkgs.wineWowPackages.stable
    pkgs.samba # for wine
    pkgs.xorg.xlsclients
  ];
}
