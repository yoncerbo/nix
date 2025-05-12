{ pkgs, ... }: {
  home.packages = [
    pkgs.sd
    pkgs.bat
    pkgs.curl
    pkgs.wget
    pkgs.man
    pkgs.pass
    pkgs.yt-dlp
    pkgs.gnupg
    pkgs.zip
    pkgs.unar
    pkgs.libsixel
    pkgs.coreutils
    # pkgs.binutils
    pkgs.pciutils
    pkgs.unzip
    pkgs.fd
    pkgs.fzf
    pkgs.lf
    pkgs.ripgrep
    pkgs.tree
    pkgs.p7zip
    pkgs.rsync
    pkgs.restic
    pkgs.rclone
    pkgs.peaclock
    pkgs.nushell
    pkgs.carapace # autocompletion for nu
    pkgs.btop
    pkgs.xdg-utils
    pkgs.pulsemixer
    # pkgs.speedread
  ];
}
