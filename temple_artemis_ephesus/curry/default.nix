{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = config.${osConfig.networking.hostName}.home.curry;
in {
  options.${osConfig.networking.hostName}.home.curry.enable = lib.mkEnableOption "curry-related packages";
  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        pakcs
      ];
    };
  };
}
