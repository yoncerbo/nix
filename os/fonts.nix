{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-code
    fira-code-symbols
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    liberation_ttf
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
}
