{ pkgs, nixvimPkg }:
with pkgs; [
  git
  ripgrep
  bat
  eza
  jq
  fzf

  elan

  strace
  inotify-tools
] ++ [ nixvimPkg ]
