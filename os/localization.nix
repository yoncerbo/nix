{ pkgs, ... }: {
  time.timeZone = "Poland";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
    "pl_PL.UTF-8/UTF-8"
  ];

  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      kdePackages.fcitx5-qt
      fcitx5-mozc # japanese
      fcitx5-hangul # korean
      fcitx5-m17n
      fcitx5-table-other
      fcitx5-configtool
      fcitx5-nord
    ];
  };
}
