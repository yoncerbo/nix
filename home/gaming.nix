{ pkgs, ... }: {
  home.packages = [
    # pkgs.minetest
    # pkgs.mindustry # cool foss game
    pkgs.prismlauncher # mienecraft
    pkgs.osu-lazer
    pkgs.gamescope # compositor
    pkgs.dolphin-emu # game cube and wii
    pkgs.azahar # 3ds
    pkgs.convmv # for renaming files in different encodings
    pkgs.lutris # game launcher
    pkgs.glxinfo # gpu information
    pkgs.winetricks # required for lutris
  ];
}
