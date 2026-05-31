{ pkgs, inputs, ... }: {
  home.packages = [
    # pkgs.minetest
    # pkgs.mindustry # cool foss game
    pkgs.prismlauncher # mienecraft
    # pkgs.osu-lazer-bin
    pkgs.gamescope # compositor
    pkgs.dolphin-emu # game cube and wii
    pkgs.azahar # 3ds
    pkgs.convmv # for renaming files in different encodings
    pkgs.lutris # game launcher
    pkgs.mesa-demos # gpu information
    pkgs.winetricks # required for lutris
    pkgs.wineWow64Packages.waylandFull
    pkgs.samba # for wine
  ];

}
