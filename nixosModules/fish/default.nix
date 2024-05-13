{ config, lib, pkgs, nixosVars, ... }:

let
  cfg = config.${nixosVars.hostName}.system.fish;
in
{
  options.${nixosVars.hostName}.system.fish.enable = lib.mkEnableOption "Key rebindings";
  config = lib.mkIf cfg.enable { 
    programs.fish = {
      enable = true;
      shellAliases = {
        cp = "cp -riv";
        mv = "mv -iv";
        rm = "trash";
        getpublicip = "curl https://api.ipify.org";
        rb = "sudo rb";
        se = "sudoedit";
      };

      shellAbbrs = {
        g = "git";
        gc = "git commit -m";
        
        zhm = "cd /etc/nixos/homeModules";
        zn = "cd /etc/nixos";
        znm = "cd /etc/nixos/nixosModules";
        ze = "cd /etc/nixos/envs";

        tl = "trash-list";

        c = "clear";
        j = "yazi";

      };
    };
  };
}
