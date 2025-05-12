{ pkgs, ... }: {
  services.kanata = {
    enable = true;
    keyboards.main.extraDefCfg = ''
      movemouse-inherit-accel-state yes
      log-layer-changes no
    '';
    keyboards.main.devices = [ "/dev/input/event0" "/dev/input/by-id/usb-30fa_USB_Optical_Mouse-event-mouse" "/dev/input/by-id/usb-Dell_Dell_USB_Keyboard-event-kbd" ];
    keyboards.main.config = builtins.readFile ../kanata.kbd;
  };

  environment.systemPackages = [ pkgs.kanata ];

  # systemd.services.kanata = {
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "notify";
  #     ExecStart = "${pkgs.kanata}/bin/kanata --cfg /d/kanata.kbd";
  #   };
  # };

}
