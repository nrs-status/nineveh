{ config, lib, pkgs,nixosVars, osConfig, ... }:

let cfg = config.${osConfig.networking.hostName}.home.cli;
in {
  options.${osConfig.networking.hostName}.home.cli.enable = lib.mkEnableOption "CLI programs";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        bat-extras.batgrep
        croc
        fd
        nix-tree
        parallel
        ripgrep
        rmlint
        tree
        xxHash
        yazi
        pb_cli
        fzf
        jq
        trash-cli
        mods


	#Archives
	#currently test driving atool, previous stack is commented out
        #lrzip
        #lz4
        #p7zip
        #unar
        #unzip
	atool

	#Monitoring	
        
        duf
        ncdu
	psmisc
        smartmontools
        cfspeedtest

        #scripts
        (pkgs.writeShellScriptBin "rb" (builtins.readFile ../../resources/rebuild.sh))
      ];

     # sessionVariables = {
      #  ET_NO_TELEMETRY = "1";
     #   CARGO_REGISTRIES_CRATES_IO_PROTOCO = "sparse";
     #   RSYNC_CHECKSUM_LIST = "xxh3 xxh128 xxh64 sha1 md5 md4 none";
     #   RSYNC_COMPRESS_LIST = "lz4 zstd zlibx zlib none";
     #   MANWIDTH = 80;
     # };
    };


    programs = {
      aria2 = {#download manager
        enable = true;
        settings = {
          continue = true;
          file-allocation = "falloc";
          max-connection-per-server = 16;
          min-split-size = "8M";
          no-file-allocation-limit = "8M";
          on-download-complete = "exit";
          split = 32;
        };
      };
      atuin = {#shell history
        enable = true;
        settings = {
          dialect = "uk";
          update_check = false;
        #  sync_address = "https://atuin.lunik.one:443";
        #  sync_frequency = "15m";
          style = "compact";
          show_preview = true;
          exit_mode = "return-query";
          history_filter = [
            "^ "
            "^export"
          ];
        };
      };
      bat = {
        enable = true;
        config = {
          theme = "gruvbox-dark";
          pager = "less -FR";
        };
      };
      btop = {
        enable = true;
        settings = {
          theme_background = true;
          truecolor = true;
          force_tty = false;
          presets =
            "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
          rounded_corners = true;
          graph_symbol = "braille";
          graph_symbol_cpu = "default";
          graph_symbol_mem = "default";
          graph_symbol_net = "default";
          graph_symbol_proc = "default";
          shown_boxes = "cpu mem net proc gpu0";
          update_ms = 2000;
          proc_sorting = "cpu lazy";
          proc_reversed = false;
          proc_tree = false;
          proc_colors = true;
          proc_gradient = true;
          proc_per_core = true;
          proc_mem_bytes = true;
          proc_info_smaps = false;
          proc_left = true;
          cpu_graph_upper = "total";
          cpu_graph_lower = "total";
          cpu_invert_lower = true;
          cpu_single_graph = false;
          cpu_bottom = false;
          show_uptime = true;
          check_temp = true;
          cpu_sensor = "Auto";
          show_coretemp = true;
          cpu_core_map = "";
          temp_scale = "celsius";
          show_cpu_freq = true;
          clock_format = "%X";
          background_update = true;
          custom_cpu_name = "";
          disks_filter = "";
          mem_graphs = true;
          mem_below_net = true;
          show_swap = true;
          swap_disk = false;
          show_disks = true;
          only_physical = true;
          use_fstab = false;
          show_io_stat = true;
          io_mode = false;
          io_graph_combined = false;
          io_graph_speeds = "";
          net_download = 100;
          net_upload = 100;
          net_auto = true;
          net_sync = false;
          net_iface = "";
          show_battery = true;
          log_level = "DISABLED";
          color_theme = "${pkgs.btop}/share/btop/themes/gruvbox_dark.theme";
        };
      };
      dircolors = {
        enable = true;
      };
      direnv = {
        enable = true;
        nix-direnv = { enable = true; };
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
      tmux = import ../../resources/tmux.nix { inherit (pkgs) tmuxPlugins; };
      fzf = rec {
        enable = true;
        enableFishIntegration = true;
      };
      yt-dlp = {#audio/video downloder
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
        options = [
          "--cmd j"
        ];
      };
    };
};
}
