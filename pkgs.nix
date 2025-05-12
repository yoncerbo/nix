pkgs: with pkgs; [

  # Graphical
  brave
  # qutebrowser
  librewolf
  mpv
  zathura
  foot
  anki-bin
  gimp
  obs-studio
  krita
  # ani-cli

  # cli / tui
  sd
  bat
  curl
  wget
  man
  pass
  yt-dlp
  gnupg
  zip
  unar
  libsixel
  coreutils
  # binutils
  pciutils
  unzip
  fd
  fzf
  lf
  ripgrep
  tree
  p7zip
  rsync
  restic
  rclone
  peaclock
  nushell
  carapace # autocompletion for nu
  btop
  xdg-utils
  # speedread

  # Desktop environment
  fuzzel
  swayimg
  feh
  imv
  xwayland
  pinentry-qt
  wl-clipboard
  pamixer
  playerctl
  brightnessctl
  pulsemixer
  libnotify
  mako
  wob
  wlr-randr
  sway
  hyprland
  swaybg
  niri
  river
  kanata

  # Testing
  rnote # notes
  saber # notes
  motrix # downloader

  # Gaming
  # minetest
  # mindustry
  prismlauncher
  osu-lazer
  gamescope
  dolphin-emu
  azahar
  convmv # for renaming files in different encodings
  lutris
  glxinfo # gpu information

  # Programming
  glslviewer
  man-pages
  man-pages-posix
  llvm
  lld
  iverilog
  (python3.withPackages (pkgs: with pkgs; [
    myhdl
  ]))
  nodePackages.live-server
  # gcc
  bear
  markdown-oxide
  clang
  clang-tools
  nodePackages.typescript-language-server
  rust-analyzer
  # ld.lld
  gnumake
  qemu
  nasm

  wineWowPackages.stable
  samba
  xorg.xlsclients

]
