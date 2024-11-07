{ config, lib, pkgs, osConfig, nixosVars, ... }:

let cfg = config.${osConfig.networking.hostName}.home.navi;
in {
  options.${osConfig.networking.hostName}.home.navi.enable = lib.mkEnableOption "navi with cheatsheets";
  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        navi
      ];
      #$USER/.local/share/navi/cheats is the default directory used by navi to store user cheatsheets and the cheatsheets repository downloaded by the `navi repo browse` command
      file.".local/share/navi/cheats".source = pkgs.symlinkJoin {
        name = "navi_cheatsheets_directory";
        paths = let
          fetchedCheatsheetsRepo = builtins.fetchGit {
           url = "https://github.com/denisidoro/cheats";
           rev = "1339965e9615ce00174cc308a41279d9c59aa75f";
         }; #navi's official cheatsheets repository
        in
        [ fetchedCheatsheetsRepo.outPath ./cheatsheets ];
      };
      };
    };
}

