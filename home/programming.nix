{ pkgs, ... }: {
  home.packages = [
    pkgs.glslviewer
    pkgs.man-pages
    pkgs.man-pages-posix
    pkgs.llvm
    pkgs.lld
    pkgs.iverilog
    pkgs.nodePackages.live-server
    # pkgs.gcc
    # pkgs.ld.lld
    pkgs.gnumake
    pkgs.qemu
    pkgs.nasm
  ];
}
