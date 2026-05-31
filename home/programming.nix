{ pkgs, ... }: {
  home.packages = [
    pkgs.man-pages
    pkgs.man-pages-posix
    # pkgs.llvm
    # pkgs.lld
    # pkgs.iverilog
    # pkgs.nodePackages.live-server
    # pkgs.glslviewer
    # pkgs.gcc
    # pkgs.ld.lld
    # pkgs.gnumake
    # pkgs.qemu
    # pkgs.nasm

    # pkgs.android-studio
  ];
}
