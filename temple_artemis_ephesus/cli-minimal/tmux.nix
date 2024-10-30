{ tmuxPlugins }:

{
  enable = true;
  baseIndex = 1;
  clock24 = true;
  escapeTime = 0;
  keyMode = "vi";
  newSession = true;
  prefix = "C-a";
  terminal = "tmux-256color";
  plugins = [
    # tmuxPlugins.tmux-fzf
    tmuxPlugins.gruvbox
    tmuxPlugins.resurrect
    {
      plugin = tmuxPlugins.continuum;
      extraConfig = ''
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '20' # minutes
      '';
    }
    {
      plugin = tmuxPlugins.tilish;
      extraConfig = ''
        set -g @tilish-default 'main-vertical'
        set -g @tilish-easymode 'on'
        set -g @tilish-prefix 'C-\'
        set -g @tilish-dmenu 'on'
      '';
    }
    {
      plugin = tmuxPlugins.sysstat;
      extraConfig = ''
        set -g status-right "#{sysstat_cpu} | #{sysstat_mem} | #{sysstat_swap} | #{sysstat_loadavg} | #[fg=blue]#(echo $USER)#[default]@#H"
      '';
    }
  ];
  extraConfig = ''
    # Enable mouse
    set -g mouse
    set -g mouse on

    # horizontal splits
    unbind-key |
    bind-key | split-window -h

    # vertical splits
    unbind-key _
    bind-key _ split-window

    # true color
    set -as terminal-overrides ",xterm-kitty,foot:RGB"

    # fix cursor shape in neovim
    set -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'

    # swapping panes with arrow keys
    unbind-key ^Left
    bind-key ^Left swap-pane -U
    unbind-key ^Right
    bind-key ^Right swap-pane -D
    unbind-key ^Up
    bind-key ^Up swap-pane -U
    unbind-key ^Down
    bind-key ^Down swap-pane -D

    # use v and y in copy-mode
    bind-key -T copy-mode-vi 'v' send -X begin-selection
    bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
  '';
}

