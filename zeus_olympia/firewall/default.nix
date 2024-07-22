{
  config,
  lib,
  pkgs,
  nixosVars,
  ...
}: let
  cfg = config.${nixosVars.hostName}.system.firewall;
in {
  options.${nixosVars.hostName}.system.bluetooth.enable = lib.mkEnableOption "firewall";

  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      firewall = {
        enable = true;
        allowedTCPPorts = [8081];
      };
    };
  };
}
