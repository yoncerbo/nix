{ pkgs, ... }: {
  home.packages = with pkgs; [
    qbittorrent
    wayvnc
    remmina
    android-tools
    
    # Screenshot tools
    wayshot
    grim
    slurp
    flameshot
    satty
  ];
}
