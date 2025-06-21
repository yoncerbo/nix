{ pkgs, ... }: {
  home.packages = with pkgs; [
    qbittorrent
    wayvnc
    remmina
    
    # Screenshot tools
    wayshot
    grim
    slurp
    flameshot
    satty
  ];
}
