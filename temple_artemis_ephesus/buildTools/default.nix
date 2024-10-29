{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = config.${osConfig.networking.hostName}.home.buildTools;
in {
  options.${osConfig.networking.hostName}.home.buildTools.enable = lib.mkEnableOption "buildTools-related packages";
  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        gnumake
        gcc
      ];
    };
  };
}
