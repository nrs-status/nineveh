{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = config.${osConfig.networking.hostName}.home.nixvim;
in {
  options.${osConfig.networking.hostName}.home.nixvim.enable = lib.mkEnableOption "nixvim";
  config = lib.mkIf cfg.enable {
    home = {
      sessionVariables.EDITOR = "nvim";
      packages = with pkgs; [
        nixvim

        rustywind #tailwind formatter
        stylelint #css formatter
        htmlbeautifier #html formatter

        cabal_fmt #cabal formatter
        fixjson #json formatter
        yamlfmt #yaml formatter

        beautysh #bash formatter
      ];
    };
  };
}
