{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = config.${osConfig.networking.hostName}.home.lean4;
in {
  options.${osConfig.networking.hostName}.home.lean4.enable = lib.mkEnableOption "lean4-related packages";
  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        elan
        #do not use the lean4 package, manage lean version with elan instead
      ];
    };
  };
}
