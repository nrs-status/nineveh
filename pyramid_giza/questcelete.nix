{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    core
    cli-minimal
    git
    nixvim-minimal
    navi
  ];

  shellHook =
    ''
      export EDITOR = "nvim";
    '';
}
