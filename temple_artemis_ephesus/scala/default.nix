{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = config.${osConfig.networking.hostName}.home.scala;
in {
  options.${osConfig.networking.hostName}.home.scala.enable = lib.mkEnableOption "scala-related packages";
  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        scala
      ];
    };
  };
}
