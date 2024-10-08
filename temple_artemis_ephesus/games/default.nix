{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = config.${osConfig.networking.hostName}.home.games;
in {
  options.${osConfig.networking.hostName}.home.games.enable = lib.mkEnableOption "Firefox";
  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        brogue
        crawl
        dwarfs #read-only fs
        fuse-overlayfs

        #wine64
       # wineWowPackages.waylandFull
        wineWowPackages.unstableFull
        winetricks
        lutris
        bottles

        bubblewrap #prereq for some installs
      ];
    };
  };
}
