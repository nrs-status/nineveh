{
  config,
  lib,
  pkgs,
  nixosVars,
  ...
}: let
  mainUserConf = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "networkmanager" "audio" "video"]; #wheel enables sudo for user; video allows controlling backlight
  };
in {
  system.nixos.label = "testing";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  programs.light.enable = true;

  environment.sessionVariables = {
    OPENAI_API_KEY = "sk-proj-8TxI0dUhlU57e7A7n5QzT3BlbkFJWNzLYwBfb3uGKKSxhKzK";
  };
  programs.fish.enable = true;
  users.users.${nixosVars.mainUser} =
    if config.programs.fish.enable
    then mainUserConf // {shell = pkgs.fish;}
    else mainUserConf;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  boot.supportedFilesystems = ["ntfs"]; # to be able to use external hdd
  nix = {
    #automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    #enable flakes
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    settings = {
      sandbox = "relaxed";
      auto-optimise-store = true;

      substituters = [
        "https://nix-community.cachix.org"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    variables = {
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      curl
      git
      pavucontrol
      pulseaudio
      keyd
    ];
  };

  hardware.opengl.enable = true; #needed for sway

  services.openssh.enable = true;
  system.stateVersion = "23.11";
}
