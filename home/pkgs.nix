{ pkgs, ... }: {
  home.packages = with pkgs; [
    qbittorrent
    wayvnc
    remmina
  ];
}
