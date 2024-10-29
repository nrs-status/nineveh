{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = config.${osConfig.networking.hostName}.home.prolog;
in {
  options.${osConfig.networking.hostName}.home.prolog.enable = lib.mkEnableOption "prolog-related packages";
  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        swiProlog
      ];
    };
  };
}
