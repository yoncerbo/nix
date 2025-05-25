{

  programs.alvr.enable = true;
  programs.git.lfs.enable = true;

  services.monado.enable = true;
  services.monado.defaultRuntime = true;
  services.monado.highPriority = true;

  systemd.user.services.monado.environment = {
    # STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
  };

}
