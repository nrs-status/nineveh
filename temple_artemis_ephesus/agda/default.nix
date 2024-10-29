{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = config.${osConfig.networking.hostName}.home.agda;
in {
  options.${osConfig.networking.hostName}.home.agda.enable = lib.mkEnableOption "agda-related packages";
  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        agda
        lua51Packages.luautf8
      ];
    };
  };
}
