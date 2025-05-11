{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    plugins = [
      pkgs.tmuxPlugins.resurrect
    ];
    extraConfig = ''
      source-file /a/tmux/tmux.conf
      unbind C-a
      set-option -g prefix C-a

      # Fix for wrong colors
      set-option -ga terminal-overrides ",xterm-256color:Tc

      # Fix escape delay
      set -sg escape-time 5

      set -g status-style "bg=black"
      set -g status-style "fg=white"

      set -g default-shell nu

      set -g @resurrect-strategy-nvim "session"
      set -g @resurrect-strategy-vim "session"
    '';
  };
}
