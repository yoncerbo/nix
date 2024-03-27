let 
  config = { config = ""; };
  data = { data = ""; };
in {

sway.conifg = "sway/config";
foot.config = "foot/config.ini";
mako.config = "mako/config";
nvim = config // data;

}
