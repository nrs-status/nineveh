{ pkgs, ... }:

pkgs.mkShell {
  packages = with pkgs; [
    core
    cliMinimal
    git
    nixvimUrls
    navi
    newsboat
    newsboatUrls
  ];

  shellHook =
    ''
      export EDITOR = "nvim";

      ln -s ${pkgs.newsboatUrls}/urls.txt $HOME/.newsboat/urls
    '';
}
