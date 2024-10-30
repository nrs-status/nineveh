{
  config,
  lib,
  pkgs,
  nixosVars,
  osConfig,
  ...
}: let
  cfg = config.${osConfig.networking.hostName}.home.cli;
in {
  options.${osConfig.networking.hostName}.home.cli.enable = lib.mkEnableOption "CLI programs";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        bat-extras.batgrep
        croc #send files between two computers
        fd #better find
        nix-tree
        ripgrep #faster grep
        fzf #fuzzy finder
        jq #json processor
        trash-cli #put files in trash
        mods #command line chatgpt
        nix-output-monitor
        nh #nix helper tool
        nvd #nix diff tool
        eza #ls alternative
        direnv #load environment on entering a directory

        #Archives
        #currently test driving atool, previous stack is commented out
        unzip
        unrar
        atool


        #scripts
        (pkgs.writeShellScriptBin "rb" (builtins.readFile ./scripts/rebuild.sh))
      ];
    };

    programs = {
      bat = {
        enable = true;
        config = {
          theme = "gruvbox-dark";
          pager = "less -FR";
        };
      };
      dircolors = {
        enable = true;
      };
      direnv = {
        enable = true;
        nix-direnv = {enable = true;};
      };
      lesspipe.enable = true;
      nix-index = {
        enable = true;
      };
      tealdeer = {
        enable = true;
        settings.updates = {
          auto_update = true;
          auto_update_interval_hours = 24;
        };
      };
      tmux = import ./tmux.nix {inherit (pkgs) tmuxPlugins;};
      fzf = rec {
        enable = true;
        enableFishIntegration = true;
      };
      yt-dlp = {
        #audio/video downloder
        enable = true;
        settings = {
          embed-thumbnail = true;
          add-metadata = true;
          merge-output-format = "mkv";
          embed-subs = true;
          convert-subs = "ass";
          netrc = true;
          external-downloader = "${pkgs.aria2}/bin/aria2c";
        };
      };
      zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = [
          "--cmd j"
        ];
      };
    };
  };
}
