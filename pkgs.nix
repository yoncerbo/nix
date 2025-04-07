pkgs: with pkgs; [
  restic
  rclone
  anki-bin
  peaclock
  swaybg
  niri
  home-manager
  foot
  nushell
  carapace # autocompletion for nu
  dash
  wlr-randr
  sway
  hyprland
  wofi
  wob
  btop
  mpv
  zathura
  libnotify
  mako
  brave
# qutebrowser
  librewolf
  ani-cli
  sd

  # Command line utils
  cmus
  pulsemixer
  bat
  curl
  wget
  man
  pass
  yt-dlp
  playerctl
  brightnessctl
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
  wl-clipboard
  bluez
  pinentry-qt
  rsync

  swayimg
  feh
  imv

  xwayland
  # minetest

  # tmux
  # tmuxPlugins.resurrect

  # Misc
  speedread

  # Vim stuff
  # gcc
  bear

  # Language servers
  markdown-oxide
  clang
  clang-tools
  nodePackages.typescript-language-server
  rust-analyzer

  kdePackages.qtwayland
  kdePackages.qtsvg
  xdg-utils

  (python3.withPackages (pkgs: with pkgs; [
    myhdl
  ]))
  nodePackages.live-server
  obs-studio
  river

  kanata
  kdePackages.kdialog
  wp-cli
  nasm
  # ld.lld
  qemu
  pamixer
  gnumake

  man-pages
  man-pages-posix

  llvm
  lld
  iverilog

  prismlauncher
  gimp
  krita
  glslviewer
  osu-lazer
  kanata

  rnote
  saber
  fuzzel

  # winetricks
  # wine-wayland
  # wine
  wineWowPackages.stable
  samba
  xorg.xlsclients
]
